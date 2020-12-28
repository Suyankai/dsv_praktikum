clear all; close all; clc;

% Parameter
T_s = 0.25;
f_a = 8000;
t = 8 * T_s;% Warum 8
N = t * f_a;

% Generieren Sie in Matlab ein Testsignal x(n)
[ x, fs, marks, cf ] = signal_src(4); 

% Berechnen Sie die Energie des Signals x(n) im Zeitbereich:
E_t = sum(x.^2);

% Berechnen Sie das Signalspektrum von x(n) mittels DFT
X = fft(x);

% Stellen Sie den Betragsfrequenzgang |X(ej2πkn=N)| auf linearer und dB Amplitudenskala dar.
X_0 = log10(abs(X / sqrt(length(X))));% Verticale Punkten vom X
%X_0 = abs(X / sqrt(length(X)));
F_a =-f_a/2:f_a/N:f_a/2-f_a/N;;% Horizontale Punkten vom X
figure,plot(F_a,fftshift(X_0));
xlabel('Frequenz（Hz）','fontsize',12)
ylabel('Amplitude |dB|','fontsize',12)

% Berechnen Sie die Energie des Signals im Frequenzbereich und vergleichen Sie es mit dem Ergebniss vorner.
E_f = sum(X_0.^2);% Nutzt man hier die normierten Werte

