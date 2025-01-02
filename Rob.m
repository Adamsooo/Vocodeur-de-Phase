function y_rob = Rob(x,Fs,Fc)
%ROB fonction qui permet de robotiser le signal x passé en
%   paramètre

%x : signal voix à robotiser
% Fs : frequence du signal x
% Fc : degré de robotisation
N=length(x);
t = ([0:N-1]/Fs).';
y_rob = real(x.*exp(-j*2*pi*Fc*t));

end