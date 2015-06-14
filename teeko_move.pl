:- include('ordonner.pl').
:- include('possibilty.pl').

%move(+Joueur,+From,+To,-Joueur1Bis)
move(B,From,To,B2):- enlever(From,B,Bbis),ordonner([To|Bbis],B2),!.


%enlever(+From,+Joueur,-JoueurBis)
enlever(F,[F|R],R).
enlever(F,[X|R],[X|R2]):-enlever(F,R,R2).

%win(+Board,-Win,+J)
win(B,W,J):-possibility(B),!,W is J .
win(B,W,J):-W is 0,!.