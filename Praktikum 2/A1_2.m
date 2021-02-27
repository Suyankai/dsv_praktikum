clear all; close all; clc;

B = [1 -0.854];
A = [1 -1.708 1];
f_a = 8000;
f_0 = 697;
T1 = 0.04;
T2 = 8000 * 1 / f_a; %7(d)
N = T2 * f_a;% change here!
x = zeros(1,N);
x(1) = 1;

% 3.Bestimmen Sie die NST und PST des Systems und Zeichnen Sie NST-PST
% Plan mit der Funktion zplane().
zplane(B,A)

% 5.(d) Berechnen Sie Ausgangsignal y(n) = h(n) ∗ x(n):
y = filter(B,A,x);
%n = 0:(length(y)-1);
n = 0:(N-1);
figure;
plot(n,y);
xlabel('Frequenz（Hz）','fontsize',12)
ylabel('Amplitude ','fontsize',12)

% 6. Berechnen Sie DFT Y (k) von y(n) und darstellen Sie den Amplitudengang:
W = 2*(0:N-1)/N; % Freq. Axis
%F_a =-f_a/2:f_a/N:f_a/2-f_a/N;
Y = abs(fft(y));
figure;
stem(W,Y);
xlabel('\Omega/\pi'); 
ylabel('|Y(e^{j\Omega})|');

% 7.(d) Berechnen und Darstellen Sie den Amplitudengang für den von Ihen
% ausgewählten Parameter M so, dass kein Leck-Effekt auftritt.