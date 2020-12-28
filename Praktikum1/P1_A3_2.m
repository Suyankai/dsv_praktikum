clear all; close all; clc;
% Entwerfen Sie jetzt eliptische IIR mit dem Matlab-Werkzeug fdatool (oder
% ellipord() und ellip() ) für gleiches Toleranzschema wie in der Aufgabe
% 2.3.1
T_s = 0.25;
f_a = 8000;
t = 8 * T_s;
N = t * f_a;
[ x, fs, marks, cf ] = signal_src(4); 
Hd = P1_A3_2_filter;
y = filter(Hd,x);
Y = fft(y);
Y_0 = log10(abs(Y / sqrt(length(Y))));% Verticale Punkten
F_a =-f_a/2:f_a/N:f_a/2-f_a/N;% Horizontale Punkten 
figure,plot(F_a,fftshift(Y_0));
xlabel('Frequenz（Hz）','fontsize',12)
ylabel('Amplitude |dB|','fontsize',12)