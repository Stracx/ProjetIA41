:- include('teeko_eval.pl').

% play
play:-
	
	write('1: joueur vs joueur'),nl,
	write('2: joueur vs ia'),nl,
	write('3: ia vs ia'),nl,
	ask_i(C,1,3),
	playChoice(C,[],[]).

% playChoice(+Choice,+BoardB, +BoardN)

playChoice(1,B,N):-
	display_board(B,N),
	playerVSplayer(B,N,0,0).

playChoice(2,B,N):-
	write('choisissez une IA d un niveau entre 1 et 4'),nl,
	ask_i(D,1,4),
	display_board(B,N),
	playerVSia(B,N,0,D).

playChoice(3,B,N):-
	write('choisissez une IA d un niveau entre 1 et 4 pour l ia0'),nl,
	ask_i(D0,1,4),
	write('choisissez une IA d un niveau entre 1 et 4 pour ia10'),nl,
	ask_i(D1,1,4),
	display_board(B,N),
	iaVSia(B,N,0,D0,D1).


	% ia vs ia
% iaVSia(+BoardJ1,BoardJ2,+NbdeTour,+DepthIa0,+DepthIa1)
iaVSia(B,N,0,D0,D1):-
	write('joueur '),write(0),write(' tour'),nl,
	NTour mod 2 =:= 0,
	alphaBeta(0,D0,B,N,-20000,20000,[[Fx,Fy],[Tx,Ty],N],_,_),
	initO(B,N,C,B1),
	display_board(B1,N1),
	iaVSia(B1,N1,NTurn,D0,D1).

iaVSia(N,B,1,D0,D1):-
	write('joueur '),write(1),write(' tour'),nl,
	NTour mod 2 =:= 1,
	alphaBeta(1,D,N,B,-20000,20000,[[Fx,Fy],[Tx,Ty],N],_,_),
	initO(N,B,C,N2),
	display_board(B,N2),
	iaVSia(B,N2,NTurn,D0,D1).

iaVSia(B,N,0,D0,D1,1):-
	write('joueur '),write(0),write(' tour'),nl,
	NTour mod 2 =:= 0,
	alphaBeta(0,D0,B,N,-20000,20000,[[Fx,Fy],[Tx,Ty],N],_,_),
	move(B,N,From,To,N,B1),
	display_board(B1,N),
	iaVSia(B1,N1,NTurn,D0,D1).

iaVSia(B,N,1,D0,D1,1):-
	write('joueur '),write(1),write(' tour'),nl,
	NTour mod 2 =:= 1,
	alphaBeta(1,D1,B,N,-20000,20000,[[Fx,Fy],[Tx,Ty],N],_,_),
	move(B,N,From,To,N,B1),
	display_board(N,B1),
	iaVSia(N,B1,NTurn,D0,D1).

iaVSia(B,N,NTour,D,D2):-
	NTour =:= 8,
	iaVSia(B,N,NTour,D,D2,1).

% ia vs joueur
% playerVSia(+BoardJ1,BoardJ2,+NbdeTour,+Profondeur)
playerVSia(B,N,NTour,D):-
	NTour<8,
	write('joueur '),write(NTour),write(' tour'),nl,
	NTour mod 2 =:= 0,
	initJ(B,N,C,B2),
	display_board(B1,N),
	NTour2 is NTour + 1,
	playerVSia(B1,N,NTour2,D).

playerVSia(N,B,NTour,D):-
	NTour<8,
	NTour mod 2 =:= 1,
	alphaBeta(1,D,B,-20000,20000,[[Fx,Fy],[Tx,Ty],N],_,_),
	initO(N,B,C,N2),
	display_board(B,N2),
	NTour2 is NTour + 1,
	playerVSia(B,N2,NTour2,D).
	
playerVSia(B,N,NTour,D):-
	NTour =:= 8,
	playerVSia(B,N,NTour,D,1).
	
playerVSia(B,N,NTour,D,1):-
	write('joueur '),write(NTour),write(' tour'),nl,
	NTour mod 2 =:= 0,
	askTo(B,N,V),
	move(B,V,To,N,B1),
	display_board(B1,N),
	NTour2 is NTour + 1,
	playerVSia(B1,N,NTour2,D).

playerVSia(N,B,NTour,D,1):-
	NTour mod 2 =:= 1,
	alphaBeta(1,D,B,-20000,20000,[[Fx,Fy],[Tx,Ty],N],_,_),
	askTo(B,N,V),
	move(N,V,To,B,N1),
	display_board(B,N1),
	NTour2 is NTour + 1,
	playerVSia(B1,N,NTour2,D).

% joueur contre joueur
% playerVSplayer(+BoardJ1,BoardJ2,+NbdeTour)

playerVSplayer(B,N,NTour,0):-
	NTour<8,
	write('joueur blanc '),write(NTour),write(' eme tour'),nl,
	initJ(B,N,B2),
	display_board(B2,N),
	NTour2 is (NTour + 1),
	playerVSplayer(N,B2,NTour2,2).

	playerVSplayer(B,N,NTour,0):-
	NTour is 8,
	playerVSplayer(B,N,NTour,1).
	
playerVSplayer(B,N,NTour,2):-
	NTour<8,
	write('joueur noir'),write(NTour),write(' eme tour'),nl,
	initJ(B,N,B2),
	display_board(N,B2),
	NTour2 is (NTour + 1),
	playerVSplayer(N,B2,NTour2,0).

	playerVSplayer(B,N,NTour,2):-
	NTour is 8,
	playerVSplayer(B,N,NTour,1).
	
playerVSplayer(B,N,NTour,1):-
	write('joueur blanc '),write(NTour),write(' eme tour'),nl,
	askFrom(B,N,F),
	askTo(B,N,V),
	move(B,V,To,N,B2),
	display_board(B2,N)B2),
	NTour2 is (NTour + 1),
	playerVSplayer(N,B2,NTour2,3).
	
playerVSplayer(B,N,NTour,3):-
	write('joueur noir '),write(NTour),write(' eme tour'),nl,
	askFrom(B,N,F),
	askTo(B,N,V),
	move(B,V,To,N,B2),
	display_board(N,B2),
	NTour2 is (NTour + 1),
	playerVSplayer(N,B2,NTour2,1).

% demande la position de depart
% askFrom(+BoardJ1,+BoardJ2,-From)
askFrom(B,N,From):-
	write('entrez le numéro de la ligne'),nl,
	ask_i(L,1,5),
	write('entrez le numéro de la colonne'),nl,
	ask_i(C,1,5),
	LT1 is ((L1*10)-10),
	T is (LT1+C1),!,
	not(member(T,N)),
	not(member(T,B)),
	From = T.

askFrom(B,N,From):-
	write('Mauvaise position'),nl,
	askFrom(B,N,From).
	

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
	write('Mauvaise position'),nl,
	askFrom(B,N,B2).
	
initO(B,N,B2):- 
	%alphaBéta
	ordonner([B|T],B2).


	
% demande la position d'arrivé
% askTo(+From,+Adv,-To)
askTo(From,Adv,To):-
	write('entrez le numéro de la ligne voulue'),nl,
	ask_i(L1,1,5),
	write('entrez le numéro de la colonne voulue'),nl,
	ask_i(C1,1,5),
	getPossibleMovement(From,N,Pos),
	LT1 is ((L1*10)-10),
	T is (LT1+C1),
	member(T,Pos),!,
	To = T .

askTo(From,N,To):-
	write('mauvaise position'),nl,
	askTo(From,N,To).
	
% demande un entier entre Min et Max
% ask_i(-I,+Min,+Max)
ask_i(I,Min,Max):-
	read(R),
	integer(R),
	between(Min, Max, R), !,
	I is R.
	
ask_i(I,Min,Max):-
	writeln('Choix invalide. Reprecisez.'),
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


