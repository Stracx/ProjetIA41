%ligne([],[X2|R2],[X3|R3],S,St):-ligne([],[X2|R2],[X3|R3],S)

ligne(_,_,[],S,S).
ligne([],[],_,S,S).

ligne([],[X2|R2],[X3|R3],S,St):- X2 is X3, S2 is S-1, ligne([], R2, R3, S2,St),!.
ligne([],[X2|R2],[X3|R3],S,St):- X2<X3, ligne([], R2, [X3|R3], S,St),!.
ligne([],[X2|R2],[X3|R3],S,St):- X2>X3, ligne([], [X2|R2], R3, S,St),!.
ligne([X|R],[],[X3|R3],S,St):-  X is X3, S2 is (S+1),ligne(R, [], R3, S2,St),!.
ligne([X|R],[],[X3|R3],S,St):- X<X3, ligne(R, [], [X3|R3], S,St),!.
ligne([X|R],[],[X3|R3],S,St):- X>X3, ligne([X|R], [], R3, S,St),!.

ligne([X|R],[X2|R2],[X3|R3],S,St):- X  is  X3, X2>X3, S2 is S+1,!, ligne(R,[X2|R2],R3,S2,St),!.
ligne([X|R],[X2|R2],[X3|R3],S,St):- X  is  X3, X2<X3, S2 is S+1,!, ligne(R, R2, R3, S2,St),!.
ligne([X|R],[X2|R2],[X3|R3],S,St):- X2  is  X3, X>X3, S2 is S-1,!, ligne([X|R], R2, R3, S2,St),!.
ligne([X|R],[X2|R2],[X3|R3],S,St):- X2  is  X3, X<X3, S2 is S-1,!, ligne(R,R2,R3,S2,St),!.
ligne([X|R],[X2|R2],[X3|R3],S,St):- X>X3, X2>X3,!, ligne([X|R], [X2|R2], R3, S,St),!.
ligne([X|R],[X2|R2],[X3|R3],S,St):- X<X3, X2>X3,!, ligne(R, [X2|R2], [X3|R3], S,St),!.
ligne([X|R],[X2|R2],[X3|R3],S,St):- X>X3, X2<X3,!, ligne([X|R], R2, [X3|R3], S,St),!.
ligne([X|R],[X2|R2],[X3|R3],S,St):- X<X3, X2<X3,!, ligne(R, R2, [X3|R3], S,St),!.