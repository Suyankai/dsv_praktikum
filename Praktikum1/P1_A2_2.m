clear all; close all; clc;
% Für gleiches Toleranzschema wie in der Aufgabe 2.2.1 entwerfen Sie jetzt FIR
% mit dem Tschebyscheff-Verfahren.

% 1. Bestimmen Sie mit der Matlab-Funktion firpmord() Filter-Ordnung N
dev = [0.02 0.02];       % Ripple
f_a = 8000;        % Sampling frequency
f = [550 930];    % Cutoff frequencies
a = [1 0];        % Desired amplitudes
[n,fo,ao,w] = firpmord(f,a,dev,f_a);

% 2. Berechnen Sie die Filterkoeffizienten mit firpm() Funktion.
b = firpm(n,fo,ao,w);

% 3. Ploten Sie den Amplitudengang und analysieren Sie, ob die Anforderungen
% erfüllt sind (Detaildarstellung für Durchlassbereich und Sperrbereich).
% Beschreiben Sie die Unterschiede bei Frequenzgängen von Filtern 2.2.1 und 2.2.2.
figure; freqz(b,1,1024,f_a);


