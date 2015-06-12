:- include('ordonner.pl').

%getPossibleMovementL(+Joueur, +Joueur, +Adversaire, -ListeMvmt ).

 getPossibleMovementL([], A, L) :- listeDepart(LD),subtract(LD,A, L2), ldeL(L2, L), ! .
getPossibleMovementL([X1], A, L):- getPossibleMovementX(X1, [X1, X1], A, L, 8),!.
getPossibleMovementL([X1, X2], A, L):- getPossibleMovementX(X1, [X1, X1, X2], A, L1, 8), getPossibleMovementX(X2, [X1, X2, X2], A, L2, 8),
 merge(L1, L2, L),!.
getPossibleMovementL([X1, X2, X3], A, L):- getPossibleMovementX(X1, [X1, X1, X2, X3], A, L1, 8), getPossibleMovementX(X2, [X1, X2, X2, X3], A, L2, 8), getPossibleMovementX(X3, [X1, X2, X3, X3], A, L3, 8),
 merge(L1, L2, L22), merge(L3, L22, L),!.
getPossibleMovementL([X1, X2, X3, X4], A, L) :- 
 getPossibleMovementX(X1, [X1, X2, X3, X4], A, L1, 8), getPossibleMovementX(X2, [X1, X2, X3, X4], A, L2, 8), getPossibleMovementX(X3, [X1, X2, X3, X4], A, L3, 8), getPossibleMovementX(X4,[X1, X2, X3, X4], A, L4, 8),
 merge(L1, L2, L22), merge(L3, L4, L44), merge(L22, L44, L),!.



%getPossibleMovementX(+Depart, +PionsJoueur, +PionsAdversaire, -ListPossibleMovements, +NumeroIteration ) 

getPossibleMovementX(_, _, _, [], 0).

getPossibleMovementX(X, B, N, L, 8):- (d1(B, N, X, _, L2), add(L2, R, L), getPossibleMovementX(X, B, N, R, 7),!);(not(d1(B, N, X, _, _)),getPossibleMovementX(X, B, N, L, 7),!).
getPossibleMovementX(X, B, N, L, 7):- (d2(B, N, X, _, L2), add(L2, R, L), getPossibleMovementX(X, B, N, R, 6),!);(not(d2(B, N, X, _, _)),getPossibleMovementX(X, B, N, L, 6),!).
getPossibleMovementX(X, B, N, L, 6):- (d3(B, N, X, _, L2), add(L2, R, L), getPossibleMovementX(X, B, N, R, 5),!);(not(d3(B, N, X, _, _)),getPossibleMovementX(X, B, N, L, 5),!).
getPossibleMovementX(X, B, N, L, 5):- (d4(B, N, X, _, L2), add(L2, R, L), getPossibleMovementX(X, B, N, R, 4),!);(not(d4(B, N, X, _, _)),getPossibleMovementX(X, B, N, L, 4),!).
getPossibleMovementX(X, B, N, L, 4):- (d5(B, N, X, _, L2), add(L2, R, L), getPossibleMovementX(X, B, N, R, 3),!);(not(d5(B, N, X, _, _)),getPossibleMovementX(X, B, N, L, 3),!).
getPossibleMovementX(X, B, N, L, 3):- (d6(B, N, X, _, L2), add(L2, R, L), getPossibleMovementX(X, B, N, R, 2),!);(not(d6(B, N, X, _, _)),getPossibleMovementX(X, B, N, L, 2),!).
getPossibleMovementX(X, B, N, L, 2):- (d7(B, N, X, _, L2), add(L2, R, L), getPossibleMovementX(X, B, N, R, 1),!);(not(d7(B, N, X, _, _)),getPossibleMovementX(X, B, N, L, 1),!).
getPossibleMovementX(X, B, N, L, 1):- (d8(B, N, X, _, L2), add(L2, R, L), getPossibleMovementX(X, B, N, R, 0),!);(not(d8(B, N, X, _, _)),getPossibleMovementX(X, B, N, L, 0),!).



%test de deplacement  d(+PionsJoueur, +PionsAdversaire, +Depart, ?Arrivee, ?ListeArriveeJoueur)
d1(L1, L2, A, B, L4):-member(A, L1),!, deplacement1(A,B), 
	not(member(B, L1)), not(member(B, L2)), swap(L1, A, B, L3), ordonner(L3,L4),!.
d2(L1, L2, A, B, L4):-member(A, L1),!, deplacement2(A,B), 
	not(member(B, L1)), not(member(B, L2)), swap(L1, A, B, L3), ordonner(L3,L4),!.
d3(L1, L2, A, B, L4):-member(A, L1),!, deplacement3(A,B), 
	not(member(B, L1)), not(member(B, L2)), swap(L1, A, B, L3), ordonner(L3,L4),!.
d4(L1, L2, A, B, L4):-member(A, L1),!, deplacement4(A,B), 
	not(member(B, L1)), not(member(B, L2)), swap(L1, A, B, L3), ordonner(L3,L4),!.
d5(L1, L2, A, B, L4):-member(A, L1),!, deplacement5(A,B), 
	not(member(B, L1)), not(member(B, L2)), swap(L1, A, B, L3), ordonner(L3,L4),!.
d6(L1, L2, A, B, L4):-member(A, L1),!, deplacement6(A,B), 
	not(member(B, L1)), not(member(B, L2)), swap(L1, A, B, L3), ordonner(L3,L4),!.
d7(L1, L2, A, B, L4):-member(A, L1),!, deplacement7(A,B), 
	not(member(B, L1)), not(member(B, L2)), swap(L1, A, B, L3), ordonner(L3,L4),!.
d8(L1, L2, A, B, L4):-member(A, L1),!, deplacement8(A,B), 
	not(member(B, L1)), not(member(B, L2)), swap(L1, A, B, L3), ordonner(L3,L4),!.




%fct de déplacement
deplacement1(A,B):- B is A+1,(B mod 10)<6,(B mod 10)>0,!.
deplacement2(A,B):- B is A+10,B<46,(B mod 10)<6,(B mod 10)>0,!.
deplacement3(A,B):- B is A+11,B<46,(B mod 10)<6,(B mod 10)>0,!.
deplacement4(A,B):- B is A+9,B<46,(B mod 10)<6,(B mod 10)>0,!.
deplacement5(A,B):- B is A-1, B>0,(B mod 10)<6,(B mod 10)>0,!.
deplacement6(A,B):- B is A-10,B>0,(B mod 10)<6,(B mod 10)>0,!.
deplacement7(A,B):- B is A-11,B>0,(B mod 10)<6,(B mod 10)>0,!.
deplacement8(A,B):- B is A-9,B>0,(B mod 10)<6,(B mod 10)>0,!.

deplacement(A,B):-deplacement1(A,B);deplacement2(A,B);deplacement3(A,B);deplacement4(A,B);deplacement5(A,B);deplacement6(A,B);deplacement7(A,B);deplacement8(A,B).

add(X,L, [X|L]).


% fct de swap
swap([C|R1], A, B, [C|R2]):- C\=A,swap(R1, A, B, R2).
swap([A|R], A, B, [B|R]).

ldeL([], []).
ldeL([X|R], [[X]|R2]):-ldeL(R, R2).

listeDepart([1, 2, 3, 4, 5, 11, 12, 13, 14, 15, 21, 22, 23, 24, 25, 31, 32, 33, 34, 35, 41, 42, 43, 44, 45]).