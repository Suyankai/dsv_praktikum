function [y,yhex] = quant(x, Qi, xmax)
%quant Quantise vector elements 
%   
%   [y,yhex] = quant(x, Qi, xmax)
%
% Input:
%       x - input signal vector
%       Qi - nuber of binary digits of twos complement representation
%       xmax - spcifies quantisation range <-xmax, xmax-1LSB>
%               values above range are saturated +/-x=+/-xmax if |x|>xmax
% Output:
%       y - quantized signal vector
%       yhex - quantized signal vector wint hexadecimal num. representation

doPlot = 1;

if nargin == 2
    xmax = max(abs(x)); 
elseif nargin == 3
   
end

% saturate values above range <-xmax-delta/2, xmax-delta/2>
%delta = xmax/2^(Qi-1);
%x=min(x, xmax-delta/2);
%x=max(x,-xmax-delta/2);

xnorm = x/xmax;         % normalize values to <-1,1>
LSB   = 1/2^(Qi-1);     % LSB in <-1,1>
a     = 2^(Qi-1);       % scaling factor to integer range

y = round(a*xnorm);         % shift left by Qi-1 bits and round
ynorm = y/a;                % scale back to <-1,1>
ynorm = min(ynorm,1-LSB);   % saturate positive values to 1-LSB level to <-1,1)
ynorm = max(ynorm,-1);

if doPlot==1
    x0 = min(xnorm);
    x1 = max(xnorm);
    gcf;
    subplot(121);
    hold off;
    plot([x0,x1],[x0,x1],':');
    hold on;
    plot(xnorm,xnorm,'+');
    plot(xnorm,ynorm, 'o');
    grid on;
    xlabel('x_{norm}');
    ylabel('y=Q(x_{norm})');
    title('Normalized Quantiser Transfer Function');
end

% convert to hex twos complement representation
idx = find(y<0);        % negative values
z = ynorm*a;
z(idx)=2^Qi + z(idx);
yhex = dec2hex(z);      

% scale to original range
y = ynorm*xmax;            % scale <-1,1) range to  <-xmax,xmax)

if doPlot==1
    x0 = min(x);
    x1 = max(x);
    gcf;
    subplot(122);
    hold off;
    plot([x0,x1],[x0,x1],'--');
    hold on;
    plot(x,x,'+');
    plot(x,y, 'o');
    grid on;
    xlabel('x');
    ylabel('y=Q(x)');
    title('Quantiser Transfer Function');
end

end

