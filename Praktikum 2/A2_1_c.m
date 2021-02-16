clear all; close all; clc;

B0 = [1 -0.854];
A0 = [1 -1.708 1];
B1 = [1 -0.823];
A1 = [1 -1.645 1];
f_a = 8000;
N = 1024;
x = zeros(1,N);
x(1) = 1;

y0 = filter(B0,A0,x);
y1 = filter(B1,A1,x);
y = y0 + y1;
% Untersuchen Sie wie ändert sich die 2-Tonerkennung wenn man DFT
% der Länge Nz = 1024 (mit zero-padding) ohne und mit Fensterung
% (Blackman-Fenster) anwendet. Darstellen Sie die Amplitudengänge

% Ohne Fensterung
Y = abs(fft(y)); 
W = 2*(0:N-1)/N; 
% Mit Fensterung
w = blackman(N);
yb = y .* w';
Yb = abs(fft(yb)); 
Wb = 2*(0:N-1)/N;
% Darstellung
figure;
subplot(2,1,1);
stem(W,Y);xlabel('\Omega/\pi');ylabel('|Y(e^{j\Omega})|');title('Y ohne Fensterung');
subplot(2,1,2);
stem(Wb,Yb);xlabel('\Omega/\pi');ylabel('|Y(e^{j\Omega})|');title('Y mit Fensterung');