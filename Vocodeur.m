%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VOCODEUR : Programme principal réalisant un vocodeur de phase 
% et permettant de :
%
% 1- modifier le tempo (la vitesse de "prononciation")
%   sans modifier le pitch (fréquence fondamentale de la parole)
%
% 2- modifier le pitch 
%   sans modifier la vitesse 
%
% 3- "robotiser" une voix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Récupération d'un signal audio
%--------------------------------

[y,Fs]=audioread('son_RATP.mp3');   %signal utilisé
%[y,Fs]=audioread('Diner.wav');   %signal d'origine
% [y,Fs]=audioread('Extrait.wav');   %signal d'origine
% [y,Fs]=audioread('Halleluia.wav');   %signal d'origine

% Remarque : si le signal est en stéréo, ne traiter qu'une seule voie à la
% fois
y = y(:,1);

% Courbes (évolution au cours du temps, spectre et spectrogramme)
%--------
% Ne pas oublier de créer les vecteurs temps, fréquences...
N = length(y);
t = [0:N-1]/Fs;
f = [0:N-1]*Fs/N; 
f = f-Fs/2;
Y = fftshift(abs((1/N)*fft(y)));

% Figure analyse temporelle
figure(1)
subplot(311) 
plot(t,y) 
grid
title('Visualisation des signaux temporels')
ylabel('Son x1')

% Figure analyse spectrale
figure(2)
subplot(311)
plot(f,Y)
grid
title('Visualisation des spectres')
ylabel('Son x1')

% Spectrogrammes
figure(3),
subplot(311)
spectrogram(y,128,120,128,Fs,'yaxis')
title('Visualisation des spectrogrammes')
ylabel('Son x1')

% Ecoute
soundsc(y, Fs)

%%
%-------------------------------
% 1- MODIFICATION DE LA VITESSE
% (sans modification du pitch)
%-------------------------------
% PLUS LENT
rapp = 2/3;   %peut être modifié
ylent = PVoc(y,rapp);
Nlent = length(ylent);
tlent = [0:Nlent-1]/Fs;
flent = [0:Nlent-1]*Fs/Nlent - Fs/2;
Ylent = fftshift(abs((1/Nlent)*fft(ylent)));

% Ecoute
% A FAIRE !
pause
soundsc(ylent,Fs)

% Courbes
% A FAIRE !
figure(1)% Figure analyse temporelle
subplot(312)
plot(tlent,ylent)
grid
ylabel('Son x0.5')

figure(2),% Figure analyse spectrale
subplot(312)
plot(flent,Ylent)
grid
ylabel('Son x0.5')

figure(3)% Spectrogrammes
subplot(312)
spectrogram(ylent,128,120,128,Fs,'yaxis')
ylabel('Son x0.5')

%
% PLUS RAPIDE
rapp = 3/2;   %peut être modifié
yrapide = PVoc(y,rapp,1024);
Nrapide = length(yrapide);
trapide = [0:Nrapide-1]/Fs;
frapide = [0:Nrapide-1]*Fs/Nrapide - Fs/2;
Yrapide = fftshift(abs((1/Nrapide)*fft(yrapide)));

% Ecoute 
% A FAIRE !
pause
soundsc(yrapide,Fs)


% Courbes
% A FAIRE !
figure(1),% Figure analyse temporelle
subplot(313),plot(trapide,yrapide),grid
ylabel('Son x1.5')

figure(2)% Figure analyse spectrale
subplot(313)
plot(frapide,Yrapide),grid
ylabel('Son x1.5')

figure(3)% Spectrogrammes
subplot(313)
spectrogram(yrapide,128,120,128,Fs,'yaxis')
ylabel('Son x1.5')

%%
%----------------------------------
% 2- MODIFICATION DU PITCH
% (sans modification de vitesse)
%----------------------------------
% Paramètres généraux:
%---------------------
% Nombre de points pour la FFT/IFFT
Nfft = 256;

% Nombre de points (longueur) de la fenêtre de pondération 
% (par défaut fenêtre de Hanning)
Nwind = Nfft;

% Augmentation 
%--------------
a = 2;  b = 3;  %peut être modifié
yvoc = PVoc(y, a/b,Nfft,Nwind);

% Ré-échantillonnage du signal temporel afin de garder la même vitesse
% A FAIRE !
yaug= resample(yvoc, a, b);

%Somme de l'original et du signal modifié
%Attention : on doit prendre le même nombre d'échantillons
%Remarque : vous pouvez mettre un coefficient à ypitch pour qu'il
%intervienne + ou - dans la somme...
% A FAIRE !
yresize = y(1:length(yaug));
ysomme = yresize + yaug ;

% Ecoute
% A FAIRE !
pause
soundsc(yaug, Fs)

% Courbes
% A FAIRE !
%
Naug = length(yaug);
taug = [0:Naug-1]/Fs;
faug = [0:Naug-1]*Fs/Naug - Fs/2;
Yaug = fftshift(abs((1/Naug)*fft(yaug)));

% Courbes temporelles
figure(4)

subplot(311)
plot(t,y)
grid
title('Comparaison des signaux temporels')
ylabel('Son original')

subplot(312)
plot(taug,yaug)
grid
ylabel('Augmentation')

% Spectres
figure(5),

subplot(311)
plot(f,Y)
grid
title('Comparaison des spectres')
ylabel('Son original')

subplot(312)
plot(faug,Yaug)
grid
ylabel('Augmentation')

% Spectrogrammes
figure(6),

subplot(311)
spectrogram(y,128,120,128,Fs,'yaxis')
title('Comparaison des spectrogrammes')
ylabel('Son original')

subplot(312)
spectrogram(yaug,128,120,128,Fs,'yaxis')
ylabel('Augmentation')

% % Ecoute
% pause
% soundsc(ysomme, Fs);

Nsomme = length(ysomme);
tsomme = [0:Nsomme-1]/Fs;
fsomme = [0:Nsomme-1]*Fs/Nsomme - Fs/2;
Ysomme = fftshift(abs((1/Nsomme)*fft(ysomme)));

% Courbe temporelle
% figure(4)
% subplot(313)
% plot(tsomme,ysomme)
% grid
% ylabel('Somme des deux signaux')

% Spectre
% figure(5)
% subplot(313)
% plot(fsomme,Ysomme)
% grid
% ylabel('Somme des deux signaux')

% Spectrogramme
% figure(6)
% subplot(313)
% spectrogram(ysomme,128,120,128,Fs,'yaxis')
% ylabel('Somme des deux signaux')

%Diminution 
%------------

a = 3;  b = 2;   %peut être modifié
yvoc = PVoc(y, a/b,Nfft,Nwind); 

% Ré-échantillonnage du signal temporel afin de garder la même vitesse
% A FAIRE !
ydim = resample(yvoc, a, b);

%Somme de l'original et du signal modifié
%Attention : on doit prendre le même nombre d'échantillons
%Remarque : vous pouvez mettre un coefficient à ypitch pour qu'il
%intervienne + ou - dans la somme...
% A FAIRE !
yresizeprim = y(1:length(ydim));
ysommeprim = yresizeprim + ydim ;

% Ecoute
% A FAIRE !
pause
soundsc(ydim, Fs);

% Courbes
% A FAIRE !
Ndim = length(ydim);
tdim = [0:Ndim-1]/Fs;
fdim = [0:Ndim-1]*Fs/Ndim - Fs/2;
Ydim = fftshift(abs((1/Ndim)*fft(ydim)));

% Courbes temporelles
figure(4)
subplot(313)
plot(tdim,ydim)
grid
ylabel('Diminution')

% Spectres
figure(5),
subplot(313)
plot(fdim,Ydim)
grid
ylabel('Diminution')

% Spectrogrammes
figure(6)
subplot(313)
spectrogram(ydim,128,120,128,Fs,'yaxis')
ylabel('Diminution')

% % Ecoute
% pause
% soundsc(ysomme, Fs);

Nsomme = length(ysomme);
tsomme = [0:Nsomme-1]/Fs;
fsomme = [0:Nsomme-1]*Fs/Nsomme - Fs/2;

Ysomme = fftshift(abs((1/Nsomme)*fft(ysomme)));

% Courbe temporelle
% figure(7)
% subplot(313)
% plot(tsomme,ysomme)
% grid
% ylabel('Somme des deux signaux')

% Spectre
% figure(8)
% subplot(313)
% plot(fsomme,Ysomme)
% grid
% ylabel('Somme des deux signaux')

% Spectrogramme
% figure(9)
% subplot(313)
% spectrogram(ysomme,128,120,128,Fs,'yaxis')
% ylabel('Somme des deux signaux')

%%
%----------------------------
% 3- ROBOTISATION DE LA VOIX
%-----------------------------
% Choix de la fréquence porteuse (2000, 1000, 500, 200)
Fc = 2000;   %peut être modifié

yrob = Rob(y,Fc,Fs);

% Ecoute
% A FAIRE !
pause
soundsc(yrob,Fs)

% Courbes
% A FAIRE !
Nrob = length(yrob);
trob = [0:Nrob-1]/Fs;
frob = [0:Nrob-1]*Fs/Nrob - Fs/2;
Yrob = fftshift(abs((1/Nrob)*fft(yrob)));

% Courbes temporelles
figure(10)

subplot(211)
plot(t,y)
grid
title('Comparaison des signaux temporels')
ylabel('Son original')

subplot(212)
plot(trob,yrob)
grid
ylabel('Robotisation')

% Spectres
figure(11),

subplot(211)
plot(f,Y)
grid
title('Comparaison des spectres')
ylabel('Son original')

subplot(212)
plot(frob,Yrob)
grid
ylabel('Robotisation')

% Spectrogrammes
figure(12),

subplot(211)
spectrogram(y,128,120,128,Fs,'yaxis')
title('Comparaison des spectrogrammes')
ylabel('Son original')

subplot(212)
spectrogram(yrob,128,120,128,Fs,'yaxis')
ylabel('Robotisation')

%%
%----------------------------------
% 3 - Parler en coeur
%----------------------------------
% Paramètres généraux:
%---------------------
% Nombre de points pour la FFT/IFFT
Nfft = 256;

% Nombre de points (longueur) de la fenêtre de pondération 
% (par défaut fenêtre de Hanning)
Nwind = Nfft;

% Augmentation 
%--------------
a = 2;  b = 3;  %peut être modifié
yvoc = PVoc(y, a/b,Nfft,Nwind);

% Ré-échantillonnage du signal temporel afin de garder la même vitesse
% A FAIRE !
yaug= resample(yvoc, a, b);

%Diminution 
a = 3;  b = 2;   %peut être modifié
yvoc = PVoc(y, a/b,Nfft,Nwind); 

% Ré-échantillonnage du signal temporel afin de garder la même vitesse
% A FAIRE !
ydim = resample(yvoc, a, b);

%Variable min length
min_length = min(length(ydim),length(yaug));

%Son original resized
yresizeprim = y(1:min_length);

%Son en tout 
ytout = y(1:min_length) + yaug(1:min_length) + ydim(1:min_length);

%Ecoute 
soundsc(ytout, Fs)
