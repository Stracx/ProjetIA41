:- include('ordonner.pl').

%getPossibleMovementL(+Joueur, +Joueur, +Adversaire, -ListPossibleMovements ) 

getPossibleMovementL(J, [X1, X2, X3, X4], A, L) :- 
	getPossibleMovementX(X1, J, A, L1, 8), getPossibleMovementX(X2, J, A, L2, 8), getPossibleMovementX(X3, J, A, L3, 8), getPossibleMovementX(X4, J, A, L4, 8),
	merge(L1, L2, L22), merge(L3, L4, L44), merge(L22, L44, L).





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
deplacement1(A,B):- B is A+1,(B mod 11)<6,!.
deplacement2(A,B):- B is A+10,B<46,(B mod 11)<6,!.
deplacement3(A,B):- B is A+11,B<46,(B mod 11)<6,!.
deplacement4(A,B):- B is A+9,B<46,(B mod 11)<6,!.
deplacement5(A,B):- B is A-1, B>0,(B mod 11)<6,!.
deplacement6(A,B):- B is A-10,B>0,(B mod 11)<6,!.
deplacement7(A,B):- B is A-11,B>0,(B mod 11)<6,!.
deplacement8(A,B):- B is A-9,B>0,(B mod 11)<6,!.


add(X,L, [X|L]).


% fct de swap
swap([C|R1], A, B, [C|R2]):- C\=A,swap(R1, A, B, R2).
swap([A|R], A, B, [B|R]).