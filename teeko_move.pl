:- include('ordonner.pl').

%move(+Joueur,+From,+To,-Joueur1Bis)
move(B,From,To,B2):- enlever(From,B,Bbis),ordonner([To|Bbis],B2),!.


%enlever(+From,+Joueur,-JoueurBis)
enlever(F,[F|R],R).
enlever(F,[X|R],[X|R2]):-enlever(F,R,R2).