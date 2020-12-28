function [ x,fs, marks, cf ] = signal_src(sel);
% SIGNAL_SRC DSV2-Lab1 test singal generator
%
%   [ x,fs, marks, cf ] = signal_src( input_args ) 
%   x     - generated signal (default: sequence of 8 symbols)
%   fs    - sampling frequency (default 8kHz)
%   marks - symbol start positions within signal
%   cf    - symbol carrier frequencies
%   sel   - select function:
%           1 - raw signal
%           2 - signal + noise
%           3 - signal + interference
%           4 - signal + noise + interference
%

%--- Symbol frequency factors regarding A-tone reference
A = 440; % reference
C = A*2^(-9/12); 
D = A*2^(-7/12); 
E = A*2^(-5/12); 
F = A*2^(-4/12);
G = A*2^(-2/12);
H = A*2^(2/12); 
C2 = A*2^(3/12); 

%--- symbol sequence
symbol = [C D E F G A H C2];
duration = [1 1 1 1 1 1 1 1];

%--- signal parameters
marks=1; % symbol start positions
N = 1/4; % time scaling
fs = 8000; % sampling frequency
x = []; % define variable for audio signal
cf = [];  % carrier frequencies in Hz

%--- signal generation
for k = 1:length(symbol) % for loop
    L = N*fs*duration(k); % number of samples per tone
    n = 0:L-1; % normalized time
    w = (2*pi/fs)*symbol(k); % normalized radian frequency
    s = sin(w*n); % sinusoidal tone

    % symbol windowing method
    %s=s.*tukeywin(length(s))';
    s=s.*hamming(length(s))';
    
    x = [x s]; % concatenate audio signal
    cf = [cf symbol(k)]; % collect carrier frequencies
    marks=[marks length(x)+1];
end

%--- time axis
n=(0:length(x)-1)/fs;

% symbol start marks vector
marks = marks(1:length(marks)-1);

%--- noise superposition
if(sel==2)
    x=x+0.2*randn(size(x));
end

%--- interference superposition
if(sel==3)
    x=x+0.3*sin(2*pi*950*n);
end

if(sel==4)
    x=x+0.2*randn(size(x));
    x=x+0.3*sin(2*pi*950*n);
end

%--- sound card output
soundsc(x,fs,16);

%--- test signal plot
subplot(2,1,1);
plot(n,x); 
hold on; 
stem(marks/fs, ones(1,length(marks)),'r.');
hold off;
grid
xlabel('nT  [s]'); ylabel('x(nT)');
subplot(2,1,2);
W=(0:length(x)-1)/length(x)*fs;
plot(W,20*log10(abs(fft(x( 1:length(W)))))); 
xlabel('f [Hz]'); ylabel('|X(e^{j\omega T})|  [dB]');
grid

end

