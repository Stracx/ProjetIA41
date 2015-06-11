:- include('getPossibleMovements.pl').
:- include('testons.pl').



% Renvoie en X le dernier élément de la liste (équivalent au prédicat 
tailEqual([X], X).
tailEqual([_|R], A):- tailEqual(R, A).

% count(+List, +Value, -Count) : compte le nombre de Value dans List
count([],_,0).
count([X|T],X,Y):- count(T,X,Z), Y is 1+Z.
count([X1|T],X,Z):- X1\=X,count(T,X,Z).


%getAdv(+X, -Y) ! Y est l'adversaire de X
getAdv(0,1).
getAdv(1,0).

getValP(0,1).
getValP(1,-1).

% eval = nombre des pièces de l'adversaire qui sont bloqué sous les piles du joueur P
% eval(+Board, -Value, +Player)


 
	score(J, Adv, 0, S1), 


% alphaBeta(+Joueur, +Adversaire, +Profondeur +Alpha, +Beta, ?Move, Oj,  +OriginalAdv, ?Value)
% Algorithme de Minmax avec simplification negamax et élagage Alpha-Beta
%	Plus Profondeur est grand, plus le temps de calcul est élevé

% Appel simplifié du prédicat de base
alphaBeta(J, Adv, Depth, Move, OJ, OAdv, Val):- 
	alphaBeta(J, Adv, Depth, -10000, 10000, Move, OJ, OAdv, Val).

% Cas d'arrêt quand la profondeur Depth atteint 0
alphaBeta(J, Adv, 0, _Alpha, _Beta, Move, OJ, OAdv, Val) :-
	!, score(J, Adv, 0, Val).

% Si Board est la Board original avec laquel on a appelé le prédicat, on ne décrémente pas D et on cherche le meilleur mouvement possible
alphaBeta(J, Adv, Depth, Alpha, Beta, Mvmt, OJ, OAdv, Value) :-
	!, getPossibleMovementL(J, Adv, Mvmt),
	Alpha1 is -Beta,
	Beta1 is -Alpha,
	searchBest(Joueur, Moves, Adversaire, Profondeur, Alpha1, Beta1, nil, Adversaire, [Move, Value]),!.

% Si Adversaire et OriginalAdversaire sont différent, on calcul les mouvements possible, on décrémente la profondeur avant de rappeler searchBest
alphaBeta(Joueur, Profondeur, Adversaire, Alpha, Beta, Move, OriginalAdversaire, Value):-
	allMove(Adversaire, Joueur, Moves),
	Alpha1 is -Beta,	%necessaire au fonctionnement du negamax
	Beta1 is -Alpha,
	Profondeur1 is Profondeur - 1,	% on passe au niveau suivant de l'arbre
	searchBest(Joueur, Moves, Adversaire, Profondeur1, Alpha1, Beta1, nil, OriginalAdversaire, [Move, Value]).

% searchBest(+Joueur,+Moves,+Adversaire,+Profondeur,+Alpha,+Beta,+R,?BestMove)
% Retourne le meilleur coup à jouer.
searchBest(_Joueur, [], _Adversaire, _Profondeur, Alpha, _Beta, Move, _, [Move,Alpha]) :- 
	!.
searchBest(Joueur, [[[Fx,Fy],[Tx,Ty],N]|Moves], Adversaire, Profondeur, Alpha, Beta, R, OriginalAdversaire, BestMove) :-
	convert(From, Fx, Fy),
	convert(To, Tx, Ty),
	move(Adversaire, From, To, N, NAdversaire),
	getAdv(Joueur, OtherJoueurR),
	alphaBeta(OtherJoueurR, Profondeur, NAdversaire, Alpha, Beta, _OtherCoup, OriginalAdversaire, Value),
	Value1 is -Value,		% negamax
	cutBranches(Joueur,[[Fx,Fy],[Tx,Ty],N], OriginalAdversaire, Value1,Profondeur,Alpha,Beta,Moves,Adversaire,R,BestMove).


% cutBranches(+Joueur,+Move,+Value,+Profondeur,+Alpha,+Beta,+Moves,+Adversaire,+_R,+BestMove)
% Permet de couper certaines branches de l'arbre lorsqu'elle sort des bornes alpha - beta
cutBranches(Joueur,Move, OriginalAdversaire, Value,Profondeur,Alpha,Beta,ListMoves,Adversaire,_R,BestMove) :-
	Alpha < Value,
	Value < Beta, !,	% structure "si, alors"
	searchBest(Joueur,ListMoves,Adversaire,Profondeur,Value,Beta,Move, OriginalAdversaire, BestMove).
cutBranches(Joueur,_Move, OriginalAdversaire, Value,Profondeur,Alpha,Beta,ListMoves,Adversaire,R,BestMove) :-
	Value =< Alpha, !, % structure "si, alors"
	searchBest(Joueur,ListMoves,Adversaire,Profondeur,Alpha,Beta,R, OriginalAdversaire, BestMove).
cutBranches(_Joueur, Move, _, Value, _Profondeur, _Alpha, _Beta, _ListMoves, _Adversaire, _R, [Move, Value]).


originalAdversaire([0,0,0,0]).

getFrom(B, [X,Y], L):- convert(I,X,Y), nth0(I, B, L).
belongTo(B, [X,Y], P):- getFrom(B, [X,Y], L), tailEqual(L, P), !.

/* Adversaire, Coord, N, List, Joueur */
getPossibleFromAdversaire(B, [X,Y], N, L, P):- belongTo(B,[X,Y], P), getPossibleMovement([X,Y],N,L,P).

