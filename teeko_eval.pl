:- include('getPossibleMovements.pl').
:- include('testons.pl').

% display whole lists
%set_prolog_flag(toplevel_print_options, [quoted(true), portray(true), max_depth(100), priority(699)]).


% Renvoie en X le dernier élément de la liste (équivalent au prédicat 
tailEqual([X], X).
tailEqual([_|R], A):- tailEqual(R, A).

% count(+List, +Value, -Count) : compte le nombre de Value dans List
count([],_,0).
count([X|T],X,Y):- count(T,X,Z), Y is 1+Z.
count([X1|T],X,Z):- X1\=X,count(T,X,Z).

%convert(+Pos, -X, -Y) ou convert(-Pos, +X, +Y)
convert(0,0,0).
convert(1,0,1).
convert(2,0,2).
convert(3,1,0).
convert(4,1,1).
convert(5,1,2).
convert(6,2,0).
convert(7,2,1).
convert(8,2,2).

%getAdv(+X, -Y) ! Y est l'adversaire de X
getAdv(0,1).
getAdv(1,0).

getValP(0,1).
getValP(1,-1).

% eval = nombre des pièces de l'adversaire qui sont bloqué sous les piles du joueur P
% eval(+Board, -Value, +Player)


 
	score(J, Adv, 0, S1), 



% alphaBeta(+Player, +Depth, +Board, +Alpha, +Beta, ?Move, +OriginalBoard, ?Value)
% Algorithme de Minmax avec simplification negamax et élagage Alpha-Beta
% Depth est la profondeur de l'arbre qui sera parcouru à l'appel du prédicat
%	Plus Depth est grand, plus le temps de calcul est élevé

% Appel simplifié du prédicat de base
alphaBeta(J, Adv, Depth, Move, OJ, OAdv, Val):- 
	alphaBeta(J, Adv, Depth, -10000, 10000, Move, OJ, OAdv, Val).

% Cas d'arrêt quand la profondeur Depth atteint 0
alphaBeta(J, Adv, 0, _Alpha, _Beta, Move, OJ, OAdv, Val) :-
	!, score(J, Adv, 0, Val).

% Si Board est la Board original avec laquel on a appelé le prédicat, on ne décrémente pas D et on cherche le meilleur mouvement possible
alphaBeta(J, Adv, Depth, Alpha, Beta, Moves, OJ, OAdv, Value) :-
	!, getPossibleMovementL(J, Adv, Moves),
	Alpha1 is -Beta,
	Beta1 is -Alpha,
	searchBest(Player, Moves, Board, Depth, Alpha1, Beta1, nil, Board, [Move, Value]),!.

% Si Board et OriginalBoard sont différent, on calcul les mouvements possible, on décrémente la profondeur avant de rappeler searchBest
alphaBeta(Player, Depth, Board, Alpha, Beta, Move, OriginalBoard, Value):-
	allMove(Board, Player, Moves),
	Alpha1 is -Beta,	%necessaire au fonctionnement du negamax
	Beta1 is -Alpha,
	Depth1 is Depth - 1,	% on passe au niveau suivant de l'arbre
	searchBest(Player, Moves, Board, Depth1, Alpha1, Beta1, nil, OriginalBoard, [Move, Value]).

% searchBest(+Player,+Moves,+Board,+Depth,+Alpha,+Beta,+R,?BestMove)
% Retourne le meilleur coup à jouer.
searchBest(_Player, [], _Board, _Depth, Alpha, _Beta, Move, _, [Move,Alpha]) :- 
	!.
searchBest(Player, [[[Fx,Fy],[Tx,Ty],N]|Moves], Board, Depth, Alpha, Beta, R, OriginalBoard, BestMove) :-
	convert(From, Fx, Fy),
	convert(To, Tx, Ty),
	move(Board, From, To, N, NBoard),
	getAdv(Player, OtherPlayerR),
	alphaBeta(OtherPlayerR, Depth, NBoard, Alpha, Beta, _OtherCoup, OriginalBoard, Value),
	Value1 is -Value,		% negamax
	cutBranches(Player,[[Fx,Fy],[Tx,Ty],N], OriginalBoard, Value1,Depth,Alpha,Beta,Moves,Board,R,BestMove).


% cutBranches(+Player,+Move,+Value,+Depth,+Alpha,+Beta,+Moves,+Board,+_R,+BestMove)
% Permet de couper certaines branches de l'arbre lorsqu'elle sort des bornes alpha - beta
cutBranches(Player,Move, OriginalBoard, Value,Depth,Alpha,Beta,ListMoves,Board,_R,BestMove) :-
	Alpha < Value,
	Value < Beta, !,	% structure "si, alors"
	searchBest(Player,ListMoves,Board,Depth,Value,Beta,Move, OriginalBoard, BestMove).
cutBranches(Player,_Move, OriginalBoard, Value,Depth,Alpha,Beta,ListMoves,Board,R,BestMove) :-
	Value =< Alpha, !, % structure "si, alors"
	searchBest(Player,ListMoves,Board,Depth,Alpha,Beta,R, OriginalBoard, BestMove).
cutBranches(_Player, Move, _, Value, _Depth, _Alpha, _Beta, _ListMoves, _Board, _R, [Move, Value]).


originalBoard([0,0,0,0]).

getFrom(B, [X,Y], L):- convert(I,X,Y), nth0(I, B, L).
belongTo(B, [X,Y], P):- getFrom(B, [X,Y], L), tailEqual(L, P), !.

/* Board, Coord, N, List, Player */
getPossibleFromBoard(B, [X,Y], N, L, P):- belongTo(B,[X,Y], P), getPossibleMovement([X,Y],N,L,P).

