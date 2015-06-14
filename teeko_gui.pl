:- include('teeko_eval.pl').
:- include('teeko_move.pl').
:- include('getPossibleMovements.pl').

% play
play:-
	write('1: joueur vs joueur'),nl,
	write('2: joueur vs ia'),nl,
	write('3: ia vs ia'),nl,
	ask_i(C,1,3),
	playChoice(C,[],[]).

% playChoice(+Choice,+BoardB, +BoardN)

playChoice(1,B,N):-
	display_board([],[]),
	playerVSplayer([],[],1,0,0).

playChoice(2,B,N):-
	write('choisissez une IA d un niveau entre 1 et 4'),nl,
	ask_i(D,1,4),
	display_board([],[]),
	playerVSia([],[],0,D,0,0).

playChoice(3,B,N):-
	write('choisissez une IA d un niveau entre 1 et 4 pour l ia blanche'),nl,
	ask_i(D0,1,4),
	write('choisissez une IA d un niveau entre 1 et 4 pour l ia noire '),nl,
	ask_i(D1,1,4),
	display_board([],[]),
	iaVSia([],[],0,D0,D1,0,0).


	% ia vs ia
% iaVSia(+BoardJ1,BoardJ2,+NbdeTour,+DepthIa0,+DepthIa1)
iaVSia(_,_,_,_,_,_,_,4):-
	write('L IA blanche gagne !!'),!.
iaVSia(_,_,_,_,_,_,_,5):-
	write('L IA noir gagne !!'),!.
	
iaVSia(_,_,_,_,_,_,4):-
	write('L IA blanche gagne !!'),!.
iaVSia(_,_,_,_,_,_,5):-
	write('L IA noir gagne !!'),!.
	
iaVSia(B,N,NTour,D,D2):-
	NTour =:= 8,
	iaVSia(B,N,NTour,D,D2,1,0,0),!.
	
iaVSia(B,N,NTurn,D0,D1,0,0):-
	write('joueur blanc '),write(NTurn),write(' eme tour'),nl,
	alphaBeta(B,N,D0,B1,_),
	display_board(B1,N),
	NTurn2 is NTurn +1,
	win(B1,W2,4),
	iaVSia(B1,N,NTurn2,D0,D1,1,W2).

iaVSia(B,N,NTurn,D0,D1,1,0):-
	write('joueur noir '),write(NTurn),write(' eme tour'),nl,
	alphaBeta(N,B,D1,N2,_),
	display_board(B,N2),
	NTurn2 is NTurn +1,
	win(N2,W2,5),
	iaVSia(B,N2,NTurn2,D0,D1,0,W2).

iaVSia(B,N,NTurn,D0,D1,1,0,0):-
	write('joueur blanc '),write(NTurn),write(' eme tour'),nl,
	alphaBeta(B,N,D0,To,_),!,
	display_board(To,N),
	NTurn2 is NTurn +1,
	win(To,W2,4),
	iaVSia(To,N1,NTurn2,D0,D1,1,1,W2).

iaVSia(B,N,NTurn,D0,D1,1,1,0):-
	write('joueur noir '),write(NTurn),write(' eme tour'),nl,
	alphaBeta(N,B,D1,To,_),!,
	display_board(B,To),
	NTurn2 is NTurn +1,
	win(To,W2,5),
	iaVSia(B,To,NTurn2,D0,D1,1,0,W2).



% ia vs joueur
% playerVSia(+BoardJ1,BoardJ2,+NbdeTour,+Profondeur)

	


playerVSia(B,N,NTour,D,_,0):-
	NTour =:= 8,
	playerVSia(B,N,NTour,D,1,0,0),!.
	
playerVSia(_,_,_,_,_,4):-
	write('joueur blanc gagne !!'),!.	
playerVSia(_,_,_,_,_,5):-
	write('L IA gagne !!'),!.
playerVSia(_,_,_,_,_,_,4):-
	write('joueur blanc gagne !!'),!.
playerVSia(_,_,_,_,_,_,5):-
	write('L IA gagne !!'),!.	
	
playerVSia(B,N,NTour,D,0,0):-
	write('joueur blanc '),write(NTour),write(' eme tour'),nl,
	initJ(B,N,B2),
	display_board(B2,N),
	NTour2 is NTour + 1,
	win(B2,W2,4),
	playerVSia(B2,N,NTour2,D,1,W2),!.
	
playerVSia(B,N,NTour,D,1,0):-
	alphaBeta(N,B,D,T,_),
	display_board(B,T),
	NTour2 is NTour + 1,
	win(T,W2,5),
	playerVSia(B,T,NTour2,D,0,W2),!.
	

	
playerVSia(B,N,NTour,D,1,0,0):-
	write('joueur blanc '),write(NTour),write(' tour'),nl,
	askFrom(B,N,V),
	askTo(B,N,V,To),
	move(B,V,To,B1),!,
	display_board(B1,N),
	NTour2 is NTour + 1,
	win(B1,W2,4),
	playerVSia(B1,N,NTour2,D,1,1,W2),!.

playerVSia(B,N,NTour,D,1,1,0):-
	alphaBeta(N,B,D,To,_),!,
	display_board(B,To),
	NTour2 is NTour + 1,
	win(To,W2,5),
	playerVSia(B,To,NTour2,D,1,0,W2),!.

% joueur contre joueur
% playerVSplayer(+BoardJ1,+BoardJ2,+NbdeTour,+TourDuJoueur,+CdtDeVictoire)

playerVSplayer(_,_,_,_,4):-
	write('joueur blanc gagne !!'),!.
playerVSplayer(_,_,_,_,5):-
	write('joueur noir gagne !!'),!.
	
playerVSplayer(B,N,NTour,0,W):-
	W<4,
	NTour<9,
	write('joueur blanc '),write(NTour),write(' eme tour'),nl,
	initJ(B,N,B2),
	display_board(B2,N),
	NTour2 is (NTour + 1),
	win(B2,W2,4),
	playerVSplayer(N,B2,NTour2,2,W2).
	playerVSplayer(B,N,NTour,0,W):-
	NTour is 9,
	playerVSplayer(B,N,NTour,1,W).
	
playerVSplayer(B,N,NTour,2,W):-
	W<4,
	NTour<9,
	write('joueur noir '),write(NTour),write(' eme tour'),nl,
	initJ(B,N,B2),
	display_board(N,B2),
	NTour2 is (NTour + 1),
	win(B2,W2,5),
	playerVSplayer(N,B2,NTour2,0,W2).

	playerVSplayer(B,N,NTour,2,W):-
	NTour is 9,
	playerVSplayer(B,N,NTour,1,W).
	
	
playerVSplayer(B,N,NTour,1,0):-
	write('joueur blanc '),write(NTour),write(' eme tour'),nl,
	askFrom(B,N,F),
	askTo(B,N,F,To),
	move(B,F,To,B2),
	display_board(B2,N),
	NTour2 is (NTour + 1),
	win(B2,W2,4),
	playerVSplayer(N,B2,NTour2,3,W2).
	
playerVSplayer(B,N,NTour,3,0):-
	write('joueur noir '),write(NTour),write(' eme tour'),nl,
	askFrom(B,N,F),
	askTo(B,N,F,To),
	move(B,V,To,B2),
	display_board(N,B2),
	NTour2 is (NTour + 1),
	win(B2,W2,5),
	playerVSplayer(N,B2,NTour2,1,W2).

% demande la position de depart
% askFrom(+BoardJ1,+BoardJ2,-From)
askFrom(B,N,From):-
	write('entrez le numéro de la ligne'),nl,
	ask_i(L,1,5),
	write('entrez le numéro de la colonne'),nl,
	ask_i(C,1,5),
	LT1 is ((L*10)-10),
	T is (LT1+C),
	not(member(T,N)),
	member(T,B),!,
	From is T.

askFrom(B,N,From):-
	write('Mauvaise position de depart'),nl,
	askFrom(B,N,From),!.
	

%init pour les 8 premiers tours pour un joueur initJ et pour l'ia initO
initJ(B,N,B2):- 
write('entrez le numéro de la ligne voulue'),nl,
	ask_i(L,1,5),
	write('entrez le numéro de la colonne voulue'),nl,
	ask_i(C,1,5),
	LT1 is ((L*10)-10),
	T is (LT1+C),
	not(member(T,N)),
	not(member(T,B)),
	ordonner([T|B],B2),!.

initJ(B,N,B2):-
	write('Mauvaise position '),nl,
	askFrom(B,N,B2).

	
% demande la position d'arrivé
% askTo(B,N,+From,-To)
askTo(B,N,From,To):-
	write('entrez le numéro de la ligne voulue'),nl,
	ask_i(L1,1,5),
	write('entrez le numéro de la colonne voulue'),nl,
	ask_i(C1,1,5),
	LT1 is ((L1*10)-10),	
	T is (LT1+C1),
	not(member(T,N)),
	not(member(T,B)),
	deplacement(From,T),
	To is T,!.

askTo(B,N,From,To):-
	write('mauvaise position darrive'),nl,
	askTo(B,N,From,To),!.
	
% demande un entier entre Min et Max
% ask_i(-I,+Min,+Max)
ask_i(I,Min,Max):-
	read(R),
	integer(R),
	between(Min, Max, R),!,
	I is R.
	
ask_i(I,Min,Max):-
	writeln('Choix invalideeeee. Reprecisez.'),
	ask_i(I,Min,Max).
	
	
% affiche le plateau de jeu
% display_board(+BoardBlanc,+BoardNoir)

display_board(B,N):-
	write('---------------'),nl,
	display_line(B,N),
	write('---------------'),nl,!.
	

% affiche les lignes du tableau
% diplay_line(+Case1,+Case2)

display_line(B,N):-display_line(B,N,1,0).

display_line([X|R],N,NBC,NBL):- 
	NBC\=6,NBL\=50,X is (NBC + NBL),write(' B '),NBC2 is (NBC+1), display_line( R , N , NBC2 , NBL),!.
display_line(B,[X|R],NBC,NBL):- 
	NBC\=6,NBL\=50,X is (NBC + NBL),write(' N '),NBC2 is (NBC+1), display_line( B , R , NBC2 , NBL),!.
display_line(B,N,NBC,NBL):- 
	NBC\=6,NBL\=50,write(' X '),NBC2 is (NBC+1), display_line(B,N , NBC2 , NBL),!.

display_line(B,N,6,NBL):- write(''),nl, NBL2 is (NBL + 10),!, display_line( B , N , 1 , NBL2),!.
display_line(_,_,1,50).


