:- include('getPossibleMovements.pl').
:- include('testons.pl').
:- include('possibilty.pl').


% alphaBeta(+Joueur, +Adversaire, +Profondeur +Alpha, +Beta, ?Deplacement, +OriginalJoueur, ?Val)
% Algorithme de Minmax avec simplification negamax et élagage Alpha-Beta
%	Plus Profondeur est grand, plus le temps de calcul est élevé

% Appel simplifié du prédicat de base
alphaBeta(J, Adv, Prof, Depl, Val):- 
	alphaBeta(J, Adv, Prof, -10000, 10000, Depl, J, Val).

% Cas d'arrêt quand la profondeur Prof atteint 0
alphaBeta(J, Adv, 0, _Alpha, _Beta, _Depl, _OJ, Val) :-
	!, score(J, Adv, 0, Val).

alphaBeta(J, Adv, _, _Alpha, _Beta, _Depl, _OJ, Val) :- (possibility(J);possibility(Adv)),
	!, score(J, Adv, 0, Val).

% Si Joueur est le Joueur original avec lequel on a appelé le prédicat, on ne décrémente pas D et on cherche le meilleur mouvement possible
alphaBeta(J, Adv, Prof, Alpha, Beta, Depl, J, Val) :-
	!, getPossibleMovementL(J, Adv, Mvmt),
	Alpha1 is -Beta,
	Beta1 is -Alpha,
	searchBest(J, Adv, Mvmt, Prof, Alpha1, Beta1, nil, J, [Depl, Val]),!.

% Si Joueur et OriginalJoueur sont différents, on calcule les mouvements possible, on décrémente la profondeur avant de rappeler searchBest
alphaBeta(J, Adv, Prof, Alpha, Beta, Depl, OJ, Val):-
	getPossibleMovementL(J, Adv, Mvmt),
	Alpha1 is -Beta,	%necessaire au fonctionnement du negamax
	Beta1 is -Alpha,
	Prof1 is Prof - 1,	% on passe au niveau suivant de l'arbre
	searchBest(J, Adv, Mvmt, Prof1, Alpha1, Beta1, nil, OJ, [Depl, Val]),!.


% searchBest(+Joueur, +Adversaire, +Mouvement, +Profondeur,+Alpha,+Beta,+R, +OriginalAdversaire, ?MeilleurDeplacement)
% Retourne le meilleur coup à jouer.
searchBest(_J, _Adv, [], _Prof, Alpha, _Beta, Depl, _, [Depl,Alpha]) :- !.

searchBest(J, Adv, [[X1]|Mvmt], Prof, Alpha, Beta, R, OJ, BestDepl) :-
	alphaBeta(Adv, [X1], Prof, Alpha, Beta, _AutreCoup, OJ, Val),!,
	Val1 is -Val,		% negamax
	cutBranches(J,Adv, [X1], OJ, Val1,Prof,Alpha,Beta,Mvmt,R,BestDepl),!.

searchBest(J, Adv, [[X1, X2]|Mvmt], Prof, Alpha, Beta, R, OJ, BestDepl) :-
	alphaBeta(Adv, [X1, X2], Prof, Alpha, Beta, _AutreCoup, OJ, Val),!,
	Val1 is -Val,		% negamax
	cutBranches(J,Adv, [X1, X2], OJ, Val1,Prof,Alpha,Beta,Mvmt,R,BestDepl),!.

searchBest(J, Adv, [[X1, X2, X3]|Mvmt], Prof, Alpha, Beta, R, OJ, BestDepl) :-
	alphaBeta(Adv, [X1, X2, X3], Prof, Alpha, Beta, _AutreCoup, OJ, Val),!,
	Val1 is -Val,		% negamax
	cutBranches(J,Adv, [X1, X2, X3], OJ, Val1,Prof,Alpha,Beta,Mvmt,R,BestDepl),!.

searchBest(J, Adv, [[X1, X2, X3, X4]|Mvmt], Prof, Alpha, Beta, R, OJ, BestDepl) :-
	alphaBeta(Adv, [X1, X2, X3, X4], Prof, Alpha, Beta, _AutreCoup, OJ, Val),!,
	Val1 is -Val,		% negamax
	cutBranches(J,Adv, [X1, X2, X3, X4], OJ, Val1,Prof,Alpha,Beta,Mvmt,R,BestDepl),!.



% cutBranches(+Joueur, +Adversaire, +Deplacement,+OriginalJoueur,+Valeur,+Profondeur,+Alpha,+Beta,+Mouvements,+_R,+MeilleurDeplacement)
% Permet de couper certaines branches de l'arbre lorsqu'elle sort des bornes alpha - beta
cutBranches(J, Adv, Depl, OJ, Val,Prof,Alpha,Beta,Mvmt,_R,BestDepl) :-
	Alpha < Val,
	Val < Beta, !,	% structure "si, alors"
	searchBest(J, Adv, Mvmt,Prof,Val,Beta,Depl, OJ, BestDepl),!.

cutBranches(J, Adv, _Depl, OJ, Val,Prof,Alpha,Beta,Mvmt,R,BestDepl) :-
	Val =< Alpha, !, % structure "si, alors"
	searchBest(J, Adv, Mvmt,Prof,Alpha,Beta,R, OJ, BestDepl),!.

cutBranches(_J, _, Depl, _OJ, Val, _Prof, _Alpha, _Beta, _Mvmt, _R, [Depl, Val]). 


