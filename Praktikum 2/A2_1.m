clear all; close all; clc;

B0 = [1 -0.854];
A0 = [1 -1.708 1];
B1 = [1 -0.823];
A1 = [1 -1.645 1];
T1 = 0.04;
f_a = 8000;
N = T1 * f_a;
x = zeros(1,N);
x(1) = 1;

% 2.(c) Berechnen Sie die Ausgangsignale
y0 = filter(B0,A0,x);
y1 = filter(B1,A1,x);
y = y0 + y1;

% 2.(d) Darstellen Sie die Signale y0(n), y1(n), y(n) = y0(n) + y1(n):
n = 0:(N-1);
n = n * T1 / N * 1000;
figure;
subplot(3,1,1); stem(n,y0);xlabel('Time(ms)','fontsize',12);ylabel('Amplitude ','fontsize',12);title('y0');
subplot(3,1,2); stem(n,y1);xlabel('Time(ms)','fontsize',12);ylabel('Amplitude ','fontsize',12);title('y1');
subplot(3,1,3); stem(n,y);xlabel('Time(ms)','fontsize',12);ylabel('Amplitude ','fontsize',12);title('y = y0 + y1');

% 3.(d) Bestimmen und darstellen Sie den Amplitudengang von y(n) mit der
% DFTs der Längen N, Nmin und Nmax
figure;
subplot(3,1,1);
Y = abs(fft(y)); 
W = 2*(0:N-1)/N; 
stem(W,Y);
xlabel('\Omega/\pi');ylabel('|Y(e^{j\Omega})|');title('Y');
subplot(3,1,2);
Nmin = 110;
xmin = zeros(1,Nmin);
xmin(1) = 1;
y0min = filter(B0,A0,xmin);
y1min = filter(B1,A1,xmin);
ymin = y0min + y1min;
Ymin = abs(fft(ymin));
W = 2*(0:Nmin-1)/Nmin; stem(W,Ymin);xlabel('\Omega/\pi');ylabel('|Y(e^{j\Omega})|');title('Ymin');
subplot(3,1,3);
Nmax = 128;
xmax = zeros(1,Nmax);
xmax(1) = 1;
y0max = filter(B0,A0,xmax);
y1max = filter(B1,A1,xmax);
ymax = y0max + y1max;
Ymax = abs(fft(ymax)); 
W = 2*(0:Nmax-1)/Nmax; stem(W,Ymax);xlabel('\Omega/\pi');ylabel('|Y(e^{j\Omega})|');title('Ymax');

% 4.(a) Berechnen und darstellen Sie den Amplitudengang des Blackmanfensters ( w=blackman(...) )
w = blackman(N);
wmax = blackman(Nmax);
wmin = blackman(Nmin);
wvtool(w)

% 5. Wiederholen Sie die Berechnung der DFT im Punkt-3 für N, Nmin und
% Nmax mit der Signalgewichtung mit einem Blackman-Fenster.
% (a) Erklären Sie, welche Auswirkung ergeben sich durch die Fensterung?
% Wird die Erkennung der Töne mit Fensterung erleichtert?

% Falls N
yb = y .* w';
Yb = abs(fft(yb)); 
Wb = 2*(0:N-1)/N;
% Falls Nmin
xmin = zeros(1,Nmin);
xmin(1) = 1;
y0min = filter(B0,A0,xmin);
y1min = filter(B1,A1,xmin);
ymin = y0min + y1min;
ybmin = ymin .* wmin';
Ybmin = abs(fft(ybmin)); 
Wbmin = 2*(0:Nmin-1)/Nmin;
% Falls Nmax
xmax = zeros(1,Nmax);
xmax(1) = 1;
y0max = filter(B0,A0,xmax);
y1max = filter(B1,A1,xmax);
ymax = y0max + y1max;
ybmax = ymax .* wmax';
Ybmax = abs(fft(ybmax)); 
Wbmax = 2*(0:Nmax-1)/Nmax;
% Darstellung
figure;
subplot(3,1,1);
stem(Wb,Yb);xlabel('\Omega/\pi');ylabel('|Y(e^{j\Omega})|');title('Y nach Blackmanfensterung (N)');
subplot(3,1,2);
stem(Wbmin,Ybmin);xlabel('\Omega/\pi');ylabel('|Y(e^{j\Omega})|');title('Y nach Blackmanfensterung (Nmin)');
subplot(3,1,3);
stem(Wbmax,Ybmax);xlabel('\Omega/\pi');ylabel('|Y(e^{j\Omega})|');title('Y nach Blackmanfensterung (Nmax)');
