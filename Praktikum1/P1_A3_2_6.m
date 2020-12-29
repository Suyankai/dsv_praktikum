clear all; close all; clc;
% Ploten Sie in einem Graph Amplitudengänge von Filtern 2.2.1, 2.2.2, 2.3.1,2.3.2 (nutzen Sie hold Funktion)
% WICHTIG: Das Ergebnis vom Aufgabe 4.3 wird mit anderen Ergebnisse hier
% vergleichen!!!
T_s = 0.25;
f_a = 8000;
t = 8 * T_s;
N = t * f_a;
F_a =-f_a/2:f_a/N:f_a/2-f_a/N;% Horizontale Punkten
E = zeros(1,N);
E(1) = 1;

% A3_1
Hd1 = P1_A3_1_filter;
Hd1 = filter(Hd1,E);
Y1 = fft(Hd1);
Y1_n = log10(abs(Y1 / sqrt(length(Y1))));
figure;plot(F_a,fftshift(Y1_n));
xlabel('Frequenz（Hz）','fontsize',12)
ylabel('Amplitude |dB|','fontsize',12);
title('Amplitudengänge von Filtern 2.2.1, 2.2.2, 2.3.1,2.3.2 ')
hold on;

% A3_2
Hd2 = P1_A3_2_filter;
Hd2 = filter(Hd2,E);
Y2 = fft(Hd2);
Y2_n = log10(abs(Y2 / sqrt(length(Y2))));
plot(F_a,fftshift(Y2_n));

% A2_1
fsamp = 8000;
fcuts = [550 930];
mags = [1 0];
devs = [0.02 0.02];
[n,Wn,beta,ftype] = kaiserord(fcuts,mags,devs,fsamp);
hh = fir1(n,Wn,ftype,kaiser(n+1,beta));
Hd3 = filter(hh,1,E);
Y3 = fft(Hd3);
Y3_n = log10(abs(Y3 / sqrt(length(Y3))));
plot(F_a,fftshift(Y3_n));

% A2_2
dev = [0.02 0.02];       % Ripple
f_a = 8000;        % Sampling frequency
f = [550 930];    % Cutoff frequencies
a = [1 0];        % Desired amplitudes
[n,fo,ao,w] = firpmord(f,a,dev,f_a);
b = firpm(n,fo,ao,w);
Hd4 = filter(b,1,E);
Y4 = fft(Hd4);
Y4_n = log10(abs(Y4 / sqrt(length(Y4))));
plot(F_a,fftshift(Y4_n));

% A4
% Hd5 = P1_A4_filter;
% Hd5 = filter(Hd5,E);
% Y5 = fft(Hd5);
% Y5_n = log10(abs(Y5 / sqrt(length(Y5))));
% plot(F_a,fftshift(Y5_n),'--');
% legend('Butterworth-IIR','Eliptische-IIR','Kaiser-FIR','Tschebyscheff-FIR','BP-Eliptische-IIR')
% hold off;

