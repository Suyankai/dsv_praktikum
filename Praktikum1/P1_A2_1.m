clear all; close all; clc;

% 2. Bestimmen Sie mit Matlab-Funktion kaiserord() die Kaiserfilterparameter:
% (a) Filter-Parameter β
% (b) Filter-Ordnung N
% (c) Optimieren Sie geeignete Toleranzschemaparameter in Punkt 1 so,
% dass Filter-Ordnung max. 40 ist.
fsamp = 8000;
fcuts = [550 930];
mags = [1 0];
devs = [0.02 0.02];
[n,Wn,beta,ftype] = kaiserord(fcuts,mags,devs,fsamp);

% 3. Entwerfen Sie nun ein Kaiser-Filter mit fir1() Funktion
hh = fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale');

% 4. Ploten Sie den Amplitudengang des Filters (Funktion freqz), NST-PSTPlan (zplane) und analysieren Sie, 
% ob die Anforderungen erfüllt sind (Detaildarstellung für Durchlasbereich und Sperrbereich).
figure; freqz(hh,1,1024,fsamp);
figure; zplane(hh,1)%Hier ist der Problem

% 5. Filtern sie das Testsignal mit dem entworfenen Filter und Matlab-Funktion
% y=filter(b,a,x) und stellen Sie den Amplitudengang jY (ejΩ)j des Signals y(n) dar.
% Diskutieren Sie die Qualität der Nutzsignalseparation vom
% Interferenzsignal.
% Parameter
T_s = 0.25;
f_a = 8000;
t = 8 * T_s;
N = t * f_a;
[ x, fs, marks, cf ] = signal_src(4); 
y = filter(hh,1,x);
Y = fft(y);
Y_0 = log10(abs(Y / sqrt(length(Y))));% Verticale Punkten
F_a =-f_a/2:f_a/N:f_a/2-f_a/N;% Horizontale Punkten 
figure,plot(F_a,fftshift(Y_0));
xlabel('Frequenz（Hz）','fontsize',12)
ylabel('Amplitude |dB|','fontsize',12)
