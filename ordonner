% Objectif : mettre les listes dans l'ordre croissant

% ordonner(L,O)	qui ordonne la liste L dans l'ordre croissant et donne O

ordonner([],[]).
ordonner(L,[Min|RO]):- minimum(L,Min), enlever(Min, L, S2), ordonner(S2,RO).	%A chaque etape, enleve le minimum de sa place dans L et l'enleve de la 1ere place dans O

%minimum(L,E)	trouve le minimum E d'une liste L

minimum([E|R],Min):-minimum(R,E,Min).
minimum([],Min,Min).
minimum([E|R],Mintemp,Min):- Min1 is min(E,Mintemp), minimum(R, Min1, Min).

%enlever(E,L1,L2) enleve l'element E de la liste L1 et renvoie L2

enlever(_,[],[]).
enlever(X,[X|R],L2):-enlever(X,R,L2).
enlever(X,[T|R1],[T|R2]):- X\=T, enlever(X,R1,R2).
