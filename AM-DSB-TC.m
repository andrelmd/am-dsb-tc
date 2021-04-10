%--------------------------------------------
% Nome do Aluno: Andre Luis Maldonado Daniel e Erasmo Costa
% Curso: LT37C - Fundamentos de Comunicacao
% Relatorio de modulacao AM-DSB-TC
% --------------------------------------------

%% Exercicio 1
%Limpar e fechar tudo
clc; %limpa a janela de comandos
clear; %limpa as variaveis e funcoes da memoria 
close all; %fecha as janelas abertas de figuras 

% Arquivo de audio da mensagem
load('./sound.mat'); %carrega o arquivo 'sound.mat' para o Workspace

% Reproducao do arquivo sound
sound(m,fs); %reproduz o sinal do vetor 'm', com frequencia de amostragem 'fs'

% Tamanho do vetor da mensagem
N = length(m); %'N' recebe o tamanho do vetor 'm' (432008)

% Periodo de amostragem de m
T = 1/fs; %'T' recebe o valor do periodo de amostragem (5.668934240362812e-06)

% Vetor de tempo
t = (0:N-1)*T; %'t' recebe o vetor de tempo

% Frequencia da portadora em Hz
fc = 20e3; %'fc' recebe o valor da frequencia da portadora em Hz (20kHz)

% Portadora
c = cos(2*pi*fc*t); %'c' recebe a portadora
s = m.*c; %'s' recebe o sinal modulado

% Plot dos sinais
% Plot do sinal de audio m(t)
figure(); %cria uma janela de figura

subplot(3,1,1); %divide a janela de figura em 3x1 e seleciona a primeira parte para o plot atual
plot(t,m); %plota 'm' versus 't'
xlim([0.94 0.95]); %define os limites do eixo X em 0,94 e 0,95
title('Sinal m(t)'); %define o nome do grafico como 'Sinal m(t)'
ylabel('Amplitude do Sinal'); %define o nome do eixo Y como 'Amplitude do Sinal'
grid on; %construcao das linhas de grade

% Plot da portadora c(t)
subplot(3,1,2); %divide a janela de figura em 3x1 e seleciona a segunda parte para o plot atual
plot(t,c); %plota 'c' versus 't'
xlim([0.94 0.95]); %define os limites do eixo X em 0,94 e 0,95
title('Portadora c(t)'); %define o nome do grafico como 'Portadora c(t)'
ylabel('Amplitude do Sinal'); %define o nome do eixo Y como 'Amplitude do Sinal'
grid on; %construcao das linhas de grade

% Plot do sinal modulado s(t) e do sinal de audio m(t)
subplot(3,1,3); %divide a janela de figura em 3x1 e seleciona a terceira parte para o plot atual
plot(t,s,'b',t,m,'k'); %plota 's' versus 't' em azul e 'm' versus 't' em preto
xlim([0.94 0.95]); %define os limites do eixo X em 0,94 e 0,95
title('Sinal Modulado s(t) e Sinal m(t)'); %define o nome do grafico como 'Sinal Modulado s(t) e Sinal m(t)'
xlabel('Tempo(s)'); %define o nome do eixo X como 'Tempo(s)'
ylabel('Amplitude do Sinal'); %define o nome do eixo Y como 'Amplitude do Sinal'
grid on; %construcao das linhas de grade

% FFT dos sinais
M = abs(fftshift(fft(m)))/N; %'M' recebe a FFT do sinal de audio m(t)
C = abs(fftshift(fft(c)))/N; %'C' recebe a FFT da portadora c(t)
S = abs(fftshift(fft(s)))/N; %'S' recebe a FFT do sinal modulado s(t)

% Vetor de frequencias
f = linspace(-fs/2,fs/2,N); %'f' recebe um vetor de 'N' pontos gerados entre '-fs/2' e 'fs/2'

% Plot das FFT's
% Plot da FFT do sinal |M(f)|
figure(); %cria uma janela de figura

subplot(3,1,1); %divide a janela de figura em 3x1 e seleciona a primeira parte para o plot atual
plot(f/1000,M); %plota 'M' versus 'f/1000'
xlim([-50 50]); %define os limites do eixo X em -50 e 50
title('Sinal |M(f)|'); %define o nome do grafico como 'Sinal |M(f)|'
grid on; %construcao das linhas de grade

% Plot da FFT da portadora |C(f)|
subplot(3,1,2); %divide a janela de figura em 3x1 e seleciona a segunda parte para o plot atual
plot(f/1000,C); %plota 'C' versus 'f/1000'
xlim([-50 50]); %define os limites do eixo X em -50 e 50
title('Portadora |C(f)|'); %define o nome do grafico como 'Portadora |C(f)|'
grid on; %construcao das linhas de grade

% Plot da FFT do sinal modulado |S(f)| e do sinal de audio |M(f)|
subplot(3,1,3); %divide a janela de figura em 3x1 e seleciona a teceira parte para o plot atual
plot(f/1000,S,'b', f/1000,M,'k'); %plota 'S' versus 'f/1000' em azul e 'M' versus 'f/1000' em preto
xlim([-50 50]); %define os limites do eixo X em -50 e 50
title('Sinal Modulado |S(f)| e Sinal |M(f)|'); %define o nome do grafico como 'Sinal modulado |S(f)| e sinal |M(f)|'
xlabel('Frequencia(kHz)'); %define o nome do eixo X como 'Frequencia(kHz)'
grid on; %construcao das linhas de grade

%% Exercicio 2
% Demodulacao do sinal
v = s.*c; %'v' recebe o sinal demodulador

% Gerando filtro passa-baixa
fcorte = 6e3/(fs/2); %fcorte recebe (0.068027210884354 Hz)
h = fir1(2e3,fcorte); %'h' recebe um filtro digital FIR passa-baixas de ordem 2000 e frequencia de corte fcorte (0.068027210884354 Hz)
[H,fh] = freqz(h,1,N/2+1,fs/1e3); %[H,fh] recebe a resposta do filtro 
H = abs(H); %'H' recebe o modulo de 'H'
vo = filter(h,1,v); %vo recebe 'v' filtrado, com filtro descrito por 'h' e '1'

% FFT de v(t) e vo(t)
V = abs(fftshift(fft(v)))/N; %V recebe a FFT do sinal demodulador v(t)
Vo = abs(fftshift(fft(vo)))/N; %Vo recebe a FFT do sinal filtrado vo(t)

% Plot dos sinais V(f) e Vo(f)
figure(); %cria uma janela de figura

subplot(4,1,1); %divide a janela de figura em 4x1 e seleciona a primeira parte para o plot atual
plot(f/1000,S); %plota 'S' versus 'f/1000'
title('Sinal Modulado |S(f)|'); %define o nome do grafico como 'Sinal Modulado |S(f)|' 
xlim([0 50]); %define os limites do eixo X em 0 e 50
grid on; %construcao das linhas de grade

subplot(4,1,2); %divide a janela de figura em 4x1 e seleciona a segunda parte para o plot atual
plot(f/1000,V); %plota 'V' versus 'f/1000'
title('Sinal Demodulado |V(f)|'); %define o nome do grafico como 'Sinal Demodulado |V(f)|'
ylim([0 3e-3]); %define os limites do eixo X em 0 e 0,003
xlim([0 50]); %define os limites do eixo X em 0 e 50
grid on; %construcao das linhas de grade

subplot(4,1,3); %divide a janela de figura em 4x1 e seleciona a teceira parte para o plot atual
plot(fh,H); %plota 'H' versus 'fh'
title('Resposta em frequencia do filtro |H(f)|'); %define o nome do grafico como 'Resposta em frequencia do filtro |H(f)|' 
grid on; %construcao das linhas de grade

subplot(4,1,4); %divide a janela de figura em 4x1 e seleciona a quarta parte para o plot atual
plot(f/1000,Vo); %plota 'Vo' versus 'f/1000'
title('Sinal Recuperado |Vo(f)|'); %define o nome do grafico como 'Sinal Recuperado |Vo(f)|'
xlabel('Frequencia(kHz)'); %define o nome do eixo X como 'Frequencia(kHz)'
ylim([0 3e-3]); %define os limites do eixo X em 0 e 0,003
xlim([0 50]); %define os limites do eixo X em 0 e 50
grid on; %construcao das linhas de grade

sound(m,fs); %reproduz o sinal do vetor 'm', com frequencia de amostragem 'fs'
sound(vo,fs); %reproduz o sinal do vetor 'vo', com frequencia de amostragem 'fs