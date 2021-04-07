% --------------------------------------------
% Nome do Aluno: Andre Luis Maldonado Daniel 
% Curso: LT37C - Fundamentos de Comunicacao
% --------------------------------------------

%% Exercicio 1
% Modulacao

%Limpar e fechar tudo
clc;
clear;
close all;

% Arquivo de audio da mensagem
load('./sound.mat');

% Reproducao do audio
sound(m,fs);

% Tamanho do vetor da mensagem
N = length(m);

% Periodo de amostragem de m
T = 1/fs;

% Vetor de tempo
t = (0:N-1)*T;

% Frequencia da portadora Hz
fc = 20e3;

% Portadora
c = cos(2*pi*fc*t);
s = m.*c;

% Plot dos sinais
figure()
subplot(3,1,1)
plot(t,m)
title('Sinal m(t)')
grid on
subplot(3,1,2)
plot(t,c)
title('Portadora c(t)')
xlim([0.94 0.95])
grid on
subplot(3,1,3)
plot(t,s,'b',t,m,'k')
title('Sinal modulado s(t) e sinal m(t)')
xlabel('Tempo(s)')
grid on

% FFT dos sinais
M = abs(fftshift(fft(m)))/N;
C = abs(fftshift(fft(c)))/N;
S = abs(fftshift(fft(s)))/N;

% Vetor de frequencias
f = linspace(-fs/2,fs/2,N);

% Plot das FFT's
figure();
subplot(3,1,1);
plot(f/1000,M);
title('Sinal |M(f)|');
grid on;
subplot(3,1,2);
plot(f/1000,C);
title('Portadora |C(f)|');
grid on;
subplot(3,1,3);
plot(f/1000,S,'b', f/1000,M,'k');
title('Sinal modulado |S(f)| e sinal |M(f)|');
xlabel('Frequencia(kHz)');
grid on;

%% Exercicio

% Demodulacao do sinal
v = s.*c;

% Gerando filtro passa-baixa
fcorte = 6e3/(fs/2);
h = fir1(2e3,fcorte);
[H,fh] = freqz(h,1,N/2+1,fs/1e3);
H = abs(H);
vo = filter(h,1,v);

% FFT de v(t) e vo(t)
V = abs(fftshift(fft(v)))/N;
Vo = abs(fftshift(fft(vo)))/N;

% Plot dos sinais V(f) e Vo(f)
figure();
subplot(4,1,1);
plot(f/1000,S);
title('Sinal Modulado |S(f)|');
xlim([0 50]);
grid on;
subplot(4,1,2)
plot(f/1000,V);
title('Sinal demodulado |V(f)|');
ylim([0 3e-3]);
xlim([0 50]);
grid on;
subplot(4,1,3);
plot(fh,H);
title('Resposta em frequencia do filtro |H(f)|');
grid on;
subplot(4,1,4);
plot(f/1000,Vo);
title('Sinal recuperado |Vo(f)|');
xlabel('Frequencia(kHz)');
ylim([0 3e-3]);
xlim([0 50]);
grid on;
sound(m,fs);
sound(vo,fs);