:- include('getPossibleMovements.pl').
:- include('testons.pl').

% alphaBeta(+Joueur, +Adversaire, +Profondeur +Alpha, +Beta, ?Move, +OriginalAdv, ?Value)
% Algorithme de Minmax avec simplification negamax et élagage Alpha-Beta
%	Plus Profondeur est grand, plus le temps de calcul est élevé

% Appel simplifié du prédicat de base
alphaBeta(J, Adv, Depth, Move, OAdv, Val):- 
	alphaBeta(J, Adv, Depth, -10000, 10000, Move, OJ, OAdv, Val).

% Cas d'arrêt quand la profondeur Depth atteint 0
alphaBeta(J, Adv, 0, _Alpha, _Beta, Move, OAdv, Val) :-
	!, score(J, Adv, 0, Val).

% Si Board est la Board original avec laquel on a appelé le prédicat, on ne décrémente pas D et on cherche le meilleur mouvement possible
alphaBeta(J, Adv, Prof, Alpha, Beta, Mvmt, Adv, Value) :-
	!, getPossibleMovementL(J, Adv, Mvmt),
	Alpha1 is -Beta,
	Beta1 is -Alpha,
	searchBest(J, Adv, Mvmt, Prof, Alpha1, Beta1, nil, OAdv, [Move, Value]),!.

% Si Adversaire et OriginalAdversaire sont différent, on calcul les mouvements possible, on décrémente la profondeur avant de rappeler searchBest
alphaBeta(J, Adv, Prof, Alpha, Beta, Mvmt, OAdv, Value):-
	getPossibleMovementL(J, Adv, Mvmt),
	Alpha1 is -Beta,	%necessaire au fonctionnement du negamax
	Beta1 is -Alpha,
	Profr1 is Prof - 1,	% on passe au niveau suivant de l'arbre
	searchBest(Joueur, Mvmt, Adv, Prof1, Alpha1, Beta1, nil, OAdv, [Move, Value]).

% searchBest(+Joueur, +Adv, +Mvmt, +Profondeur,+Alpha,+Beta,+R,?BestMove)
% Retourne le meilleur coup à jouer.
searchBest(_J, _Adv, [], _Prof, Alpha, _Beta, Move, _, [Move,Alpha]) :- 
	!.
searchBest(J, Adv, [[X1, X2, X3, X4]|Mvmt], Prof, Alpha, Beta, R, OAdv, BestMove) :-
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

getFrom(B, [X,Y], L):- convert(I,X,Y), nth0(I, B, L).
belongTo(B, [X,Y], P):- getFrom(B, [X,Y], L), tailEqual(L, P), !.

/* Adversaire, Coord, N, List, Joueur */
getPossibleFromAdversaire(B, [X,Y], N, L, P):- belongTo(B,[X,Y], P), getPossibleMovement([X,Y],N,L,P).

