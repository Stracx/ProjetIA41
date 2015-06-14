ligne([X|R],[X2|R2],[X3|R3],S,St):-ligne([X|R],[X2|R2],[X3|R3],S,St,0).
ligne(_,_,[],4,S,0) :- S is 2000,ligne(_,_,_,_,_,1),!.
ligne(_,_,[],3,S,0) :- S is 100, ligne(_,_,_,_,_,1),!.
ligne(_,_,[],2,S,0) :- S is 50,ligne(_,_,_,_,_,1),!.
ligne(_,_,[],1,S,0) :- S is 1,ligne(_,_,_,_,_,1),!.
ligne(_,_,[],0,S,0) :- S is 0,ligne(_,_,_,_,_,1),!.
ligne(_,_,[],(-1),S,0) :- S is (-1),ligne(_,_,_,_,_,1),!.
ligne(_,_,[],(-2),S,0) :- S is (-50),ligne(_,_,_,_,_,1),!.
ligne(_,_,[],(-3),S,0) :- S is (-100),ligne(_,_,_,_,_,1),!.
ligne(_,_,[],(-4),S,0) :- S is (-2000),ligne(_,_,_,_,_,1),!.

ligne([],[],_,4,S,0) :- S is 2000, ligne(_,_,_,_,_,1),!.
ligne([],[],_,3,S,0) :- S is 100,ligne(_,_,_,_,_,1),!.
ligne([],[],_,2,S,0) :- S is 50,ligne(_,_,_,_,_,1),!.
ligne([],[],_,1,S,0) :- S is 1,ligne(_,_,_,_,_,1),!.
ligne([],[],_,0,S,0) :- S is 0,ligne(_,_,_,_,_,1),!.
ligne([],[],_,(-1),S,0) :- S is (-1),ligne(_,_,_,_,_,1),!.
ligne([],[],_,(-2),S,0) :- S is (-50),ligne(_,_,_,_,_,1),!.
ligne([],[],_,(-3),S,0) :- S is (-100),ligne(_,_,_,_,_,1),!.
ligne([],[],_,(-4),S,0) :- S is (-2000),ligne(_,_,_,_,_,1),!.

ligne([],[X2|R2],[X3|R3],S,St,0):- X2 is X3, S2 is (S-1), ligne([], R2, R3, S2,St,0),!.
ligne([],[X2|R2],[X3|R3],S,St,0):- X2<X3, ligne([], R2, [X3|R3], S,St,0),!.
ligne([],[X2|R2],[X3|R3],S,St,0):- X2>X3, ligne([], [X2|R2], R3, S,St,0),!.
ligne([X|R],[],[X3|R3],S,St,0):- X =:= X3, S2 is (S+1),ligne(R, [], R3, S2,St,0),!.
ligne([X|R],[],[X3|R3],S,St,0):- X<X3, ligne(R, [], [X3|R3], S,St,0),!.
ligne([X|R],[],[X3|R3],S,St,0):- X>X3, ligne([X|R], [], R3, S,St,0),!.

ligne([X|R],[X2|R2],[X3|R3],S,St,0):- X is X3, X2>X3, S2 is (S+1), ligne(R,[X2|R2],R3,S2,St,0),!.
ligne([X|R],[X2|R2],[X3|R3],S,St,0):- X is X3, X2<X3, S2 is (S+1), ligne(R, R2, R3, S2,St,0),!.
ligne([X|R],[X2|R2],[X3|R3],S,St,0):- X2 is X3, X>X3, S2 is (S-1), ligne([X|R], R2, R3, S2,St,0),!.
ligne([X|R],[X2|R2],[X3|R3],S,St,0):- X2 is X3, X<X3, S2 is (S-1), ligne(R,R2,R3,S2,St,0),!.
ligne([X|R],[X2|R2],[X3|R3],S,St,0):- X>X3, X2>X3, ligne([X|R], [X2|R2], R3, S,St,0),!.
ligne([X|R],[X2|R2],[X3|R3],S,St,0):- X<X3, X2>X3, ligne(R, [X2|R2], [X3|R3], S,St,0),!.
ligne([X|R],[X2|R2],[X3|R3],S,St,0):- X>X3, X2<X3, ligne([X|R], R2, [X3|R3], S,St,0),!.
ligne([X|R],[X2|R2],[X3|R3],S,St,0):- X<X3, X2<X3, ligne(R, R2, [X3|R3], S,St,0),!.


ligne(_,_,_,_,_,1).

%44 conditions de victoires 
score([],[],_,0).
score(A,[],_,0).

score(B,N,_,St):-ligne(B,N,[1, 2, 3, 4],0,S0),
ligne(B,N,[2, 3, 4, 5],0,S1),!,
ligne(B,N,[11, 12, 13, 14],0,S2),
ligne(B,N,[12, 13, 14, 15],0,S3),
ligne(B,N,[21, 22, 23, 24],0,S4),
ligne(B,N,[22, 23, 24, 25],0,S5),

ligne(B,N,[31, 32, 33, 34],0,S6),
ligne(B,N,[32, 33, 34, 35],0,S7),
ligne(B,N,[41, 42, 43, 44],0,S8),
ligne(B,N,[42, 43, 44, 45],0,S9),

ligne(B,N,[1, 11, 21, 31],0,S10),
ligne(B,N,[11, 21, 31, 41],0,S11),
ligne(B,N,[2, 12, 22, 32],0,S12),
ligne(B,N,[12, 22, 32, 42],0,S13),
ligne(B,N,[3, 13, 23, 33],0,S14),
ligne(B,N,[13, 23, 33, 43],0,S15),
ligne(B,N,[4, 14, 24, 34],0,S16),
ligne(B,N,[14, 24,4 34, 44],0,S17),
ligne(B,N,[5, 15, 25, 35],0,S18),
ligne(B,N,[15, 25, 35, 45],0,S19),

ligne(B,N,[1, 12, 23, 34],0,S20),
ligne(B,N,[12, 23, 34, 45],0,S21),
ligne(B,N,[2, 13, 24, 35],0,S22),
ligne(B,N,[11, 22, 33, 44],0,S23),
ligne(B,N,[4, 13, 22, 31],0,S24),
ligne(B,N,[5, 14, 23, 32],0,S25),
ligne(B,N,[14, 23, 32, 41],0,S26),
ligne(B,N,[15, 24, 33, 42],0,S27),

ligne(B,N,[1, 2, 11, 12],0,S28),
ligne(B,N,[2, 3, 12, 13],0,S29),
ligne(B,N,[3, 4, 13, 14],0,S30),
ligne(B,N,[4, 5, 14, 15],0,S31),
ligne(B,N,[11, 12, 21, 22],0,S32),
ligne(B,N,[12, 13, 22, 23],0,S33),
ligne(B,N,[13, 14, 23, 24],0,S34),
ligne(B,N,[14, 15, 24, 25],0,S35),
ligne(B,N,[21, 22, 31, 32],0,S36),
ligne(B,N,[22, 23, 32, 33],0,S37),
ligne(B,N,[23, 24, 33, 34],0,S38),
ligne(B,N,[24, 25, 34, 35],0,S39),
ligne(B,N,[31, 32, 41, 42],0,S40),
ligne(B,N,[32, 33, 42, 43],0,S41),
ligne(B,N,[33, 34, 43, 44],0,S42),
ligne(B,N,[34, 35, 44, 45],0,S43),
S45 is (S0+S1+S2+S3+S4+S5+S6+S7+S8+S9+S10+S11+S12+S13+S14+S15+S16+S17+S18+S19+S20+S21+S22+S23+S24+S25+S26+S27+S28+S29+S30+S31+S32+S33+S34+S35+S36+S37+S38+S39+S40+S41+S42+S43),
score(0,0,S45,St),!.

score(0,0,S,S).