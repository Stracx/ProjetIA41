:- include('ordonner.pl').
:- include('possibilty.pl').

%move(+Joueur,+From,+To,-Joueur1Bis)
move(B,From,To,B2):- d(B, From, To, B2),!. 

%test de deplacement  d(+PionsJoueur, +PionsAdversaire, +Depart, ?Arrivee, ?ListeArriveeJoueur)
d(L1, A, B, L4):-d1(L1, A, B, L4);d2(L1, A, B, L4);d3(L1, A, B, L4);d4(L1, A, B, L4);d5(L1, A, B, L4);d6(L1, A, B, L4);d7(L1, A, B, L4);d8(L1, A, B, L4),!.
d1(L1, A, B, L4):- deplacement1(A,B), swap(L1, A, B, L3), ordonner(L3,L4),!.
d2(L1, A, B, L4):- deplacement2(A,B), swap(L1, A, B, L3), ordonner(L3,L4),!.
d3(L1, A, B, L4):-deplacement3(A,B), swap(L1, A, B, L3), ordonner(L3,L4),!.
d4(L1, A, B, L4):-deplacement4(A,B), swap(L1, A, B, L3), ordonner(L3,L4),!.
d5(L1, A, B, L4):- deplacement5(A,B), swap(L1, A, B, L3), ordonner(L3,L4),!.
d6(L1, A, B, L4):- deplacement6(A,B),  swap(L1, A, B, L3), ordonner(L3,L4),!.
d7(L1, A, B, L4):-deplacement7(A,B), swap(L1, A, B, L3), ordonner(L3,L4),!.
d8(L1, A, B, L4):-deplacement8(A,B), swap(L1, A, B, L3), ordonner(L3,L4),!.



%fct de déplacement
deplacement(A,B):-deplacement1(A,B);deplacement2(A,B);deplacement3(A,B);deplacement4(A,B);deplacement5(A,B);deplacement6(A,B);deplacement7(A,B);deplacement8(A,B).
deplacement1(A,B):- B is A+1,(B mod 10)<6,(B mod 10)>0,!.
deplacement2(A,B):- B is A+10,B<46,(B mod 10)<6,(B mod 10)>0,!.
deplacement3(A,B):- B is A+11,B<46,(B mod 10)<6,(B mod 10)>0,!.
deplacement4(A,B):- B is A+9,B<46,(B mod 10)<6,(B mod 10)>0,!.
deplacement5(A,B):- B is A-1, B>0,(B mod 10)<6,(B mod 10)>0,!.
deplacement6(A,B):- B is A-10,B>0,(B mod 10)<6,(B mod 10)>0,!.
deplacement7(A,B):- B is A-11,B>0,(B mod 10)<6,(B mod 10)>0,!.
deplacement8(A,B):- B is A-9,B>0,(B mod 10)<6,(B mod 10)>0,!.


%fonction d'ajout
%add(+ElementAAjouter, +Liste, ?ListeAvecAjout)
add(X,L, [X|L]).

% fonction de swap
%swap(+ListeAChanger, +ElementAChanger, +Element, ?ListeChangee)
swap([C|R1], A, B, [C|R2]):- C\=A,swap(R1, A, B, R2).
swap([A|R], A, B, [B|R]).


%enlever(+From,+Joueur,-JoueurBis)
enlever(F,[F|R],R).
enlever(F,[X|R],[X|R2]):-enlever(F,R,R2).

%win(+Board,-Win,+J)
win(B,W,J):-possibility(B),!,W is J .
win(B,W,J):-W is 0,!.