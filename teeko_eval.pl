:- include('getPossibleMovements.pl').
:- include('testons.pl').

% alphaBeta(+Joueur, +Adversaire, +Profondeur +Alpha, +Beta, ?Deplacement, +OriginalAdv, ?Val)
% Algorithme de Minmax avec simplification negamax et élagage Alpha-Beta
%	Plus Profondeur est grand, plus le temps de calcul est élevé

% Appel simplifié du prédicat de base
alphaBeta(J, Adv, Prof, Depl, Val):- 
	alphaBeta(J, Adv, Prof, -10000, 10000, Depl, Adv, Val).

% Cas d'arrêt quand la profondeur Depth atteint 0
alphaBeta(J, Adv, 0, _Alpha, _Beta, _Depl, _OAdv, Val) :-
	!, score(J, Adv, 0, Val).

% Si Board est la Board original avec laquel on a appelé le prédicat, on ne décrémente pas D et on cherche le meilleur mouvement possible
alphaBeta(J, Adv, Prof, Alpha, Beta, Depl, Adv, Val) :-
	!, getPossibleMovementL(J, Adv, Mvmt),
	Alpha1 is -Beta,
	Beta1 is -Alpha,
	searchBest(J, Adv, Mvmt, Prof, Alpha1, Beta1, nil, Adv, [Depl, Val]),!.

% Si Adversaire et OriginalAdversaire sont différent, on calcul les mouvements possible, on décrémente la profondeur avant de rappeler searchBest
alphaBeta(J, Adv, Prof, Alpha, Beta, Depl, OAdv, Val):-
	getPossibleMovementL(J, Adv, Mvmt),
	Alpha1 is -Beta,	%necessaire au fonctionnement du negamax
	Beta1 is -Alpha,
	Prof1 is Prof - 1,	% on passe au niveau suivant de l'arbre
	searchBest(J, Adv, Mvmt, Prof1, Alpha1, Beta1, nil, OAdv, [Depl, Val]).


% searchBest(+Joueur, +Adv, +Mvmt, +Profondeur,+Alpha,+Beta,+R, +OriginalAdversaire, ?BestDepl)
% Retourne le meilleur coup à jouer.
searchBest(_J, _Adv, [], _Prof, Alpha, _Beta, Depl, _, [Depl,Alpha]) :- !.

searchBest(J, Adv, [[X1, X2, X3, X4]|Mvmt], Prof, Alpha, Beta, R, OAdv, BestDepl) :-
	alphaBeta(Adv, [X2, X2, X3, X4], Prof, Alpha, Beta, _AutreCoup, OAdv, Val),
	Val1 is -Val,		% negamax
	cutBranches(J,Adv, [X1, X2, X3, X4], OAdv, Val1,Prof,Alpha,Beta,Mvmt,R,BestDepl).


% cutBranches(+Joueur, +Adversaire, +Depl,+OriginalAdversaire,+Val,+Profondeur,+Alpha,+Beta,+Mouvements,+_R,+BestDepl)
% Permet de couper certaines branches de l'arbre lorsqu'elle sort des bornes alpha - beta
cutBranches(J, Adv, Depl, OAdv, Val,Prof,Alpha,Beta,Mvmt,_R,BestDepl) :-
	Alpha < Val,
	Val < Beta, !,	% structure "si, alors"
	searchBest(J, Adv, Mvmt,Prof,Val,Beta,Depl, OAdv, BestDepl).

cutBranches(J, Adv, _Depl, OAdv, Val,Prof,Alpha,Beta,Mvmt,R,BestDepl) :-
	Val =< Alpha, !, % structure "si, alors"
	searchBest(J, Adv, Mvmt,Prof,Alpha,Beta,R, OAdv, BestDepl).

cutBranches(_J, _, Depl, _OAdv, Val, _Prof, _Alpha, _Beta, _LMvmt, _R, [Depl, Val]). 


