:- include('teeko_eval.pl').

% play
play:-
	originalBoard(B),
	originalBoard(N),
	write('1: joueur vs joueur'),nl,
	write('2: joueur vs ia'),nl,
	write('3: ia vs joueur'),nl,
	write('4: ia vs ia'),nl,
	ask_i(C,1,4),
	playChoice(C,B,N).

% playChoice(+Choice,+BoardB, +BoardN)

playChoice(1,B,N):-
	display_board(B,N),
	playerVSplayer(B,N,0).

playChoice(2,B,N):-
	write('choisissez une IA d un niveau entre 1 et 4'),nl,
	ask_i(D,1,4),
	display_board(B,N),
	playerVSia(B,N,0,D).

playChoice(3,B,N):-
	write('choisissez une IA d un niveau entre 1 et 4'),nl,
	ask_i(D,1,4),
	display_board(B,N),
	iaVSplayer(B,N,0,D).

playChoice(4,B,N):-
	write('choisissez une IA d un niveau entre 1 et 4 pour l ia0'),nl,
	ask_i(D0,1,4),
	write('choisissez une IA d un niveau entre 1 et 4 pour ia10'),nl,
	ask_i(D1,1,4),
	display_board(B,N),
	iaVSia(B,N,0,D0,D1).


	% ia vs ia
% iaVSia(+Board,+FirstPlayer,+DepthIa0,+DepthIa1)

iaVSia(B,N,0,D0,D1):-
	write('player '),write(0),write(' turn'),nl,
	alphaBeta(0,D0,B,N,-20000,20000,[[Fx,Fy],[Tx,Ty],N],_,_),
	move(B,N,From,To,N,B1),
	display_board(B1,N1),
	changeTurn(0,NTurn),
	allMove(B1,N,NTurn,M),
	M \= [],
	iaVSia(B1,N1,NTurn,D0,D1).

iaVSia(B,N,1,D0,D1):-
	write('player '),write(1),write(' turn'),nl,
	alphaBeta(1,D1,B,N,-20000,20000,[[Fx,Fy],[Tx,Ty],N],_,_),
	convert(From,Fx,Fy),
	convert(To,Tx,Ty),
	move(B,N,From,To,N,B1),
	display_board(B1,N),
	changeTurn(1,NTurn),
	allMove(B,N,NTurn,M),
	M \= [],
	iaVSia(B1,NTurn,D0,D1).


% ia vs joueur
% iaVSplayer(+Board,+FirstPlayer;+Depth)
iaVSplayer(B,N,1,D):-
	write('joueur '),write(1),write(' tour'),nl,
	askFrom(B,N,[FX,FY],1),
	askN(B,N,[FX,FY],N),
	askTo([FX,FY],N,[TX,TY]),
	convert(From,FY,FX),
	convert(To,TY,TX),
	move(B,N,From,To,N,B1),
	display_board(B1,N),
	changeTurn(1,NTurn),
	iaVSplayer(B1,NTurn,D).

iaVSplayer(B,0,D):-
	alphaBeta(0,D,B,-20000,20000,[[Fx,Fy],[Tx,Ty],N],_,_),
	move(B,From,To,N,B1),
	display_board(B1,N),
	changeTurn(0,NTurn),
	iaVSplayer(B1,NTurn,D).

% joueur vs ia
% playerVSia(+BoardJ1,BoardJ2,+FirstPlayer,+D)

playerVSia(B,N,0,D):-
	write('joueur '),write(0),write(' tour'),nl,
	askFrom(B,N,F,0),
	askTo([FX,FY],N,[TX,TY]),
	move(B,From,To,N,B1),
	display_board(B1,N),
	changeTurn(0,NTurn),
	playerVSia(B1,NTurn,D).

playerVSia(B,1,D):-
	alphaBeta(1,D,B,-20000,20000,[[Fx,Fy],[Tx,Ty],N],_,_),
	move(B,From,To,N,B1),
	display_board(B1,N),
	changeTurn(1,NTurn),
	playerVSia(B1,NTurn,D).

	% joueur contre joueur
% playerVSplayer(+Board,+FirstPlayer)

playerVSplayer(B,Turn):-
	write('joueur '),write(Turn),write(' tour'),nl,
	askFrom(B,[FX,FY],Turn),
	askN(B,[FX,FY],N),
	askTo([FX,FY],N,[TX,TY]),
	convert(From,FY,FX),
	convert(To,TY,TX),
	move(B,From,To,N,B1),
	display_board(B1,N),
	changeTurn(Turn,NTurn),
	allMove(B,NTurn,M),
	M \= [],
	playerVSplayer(B1,NTurn).

% demande la position de depart
% askFrom(+BoardJ1,+BoardJ2,-From,+PlayerTurn)
askFrom(B,N,From,Turn):-
	write('entrez le numéro de la ligne'),nl,
	ask_i(L,1,5),
	write('entrez le numéro de la colonne'),nl,
	ask_i(C,1,5),
	LT1 is ((L1*10)-10),
	T is (LT1+C1),!,
	not(member(T,N)),
	not(member(T,B)),
	From = T.

askFrom(B,From,Turn):-
	write('Mauvaise position'),nl,
	askFrom(B,N,From,Turn)
	
% change le tour du joueur
	changeTurn(1,0).
	changeTurn(0,1).
	
% demande la position d'arrivé
% askTo(+From,-To)

askTo(From,To):-
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
	write('the position is not good'),nl,
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
	write('---------------'),nl,!,
	display_line(B,N),!,
	write('---------------'),nl,!.
	

% affiche une ligne de case
% diplay_line(+Case1,+Case2)

display_line(B,N):-display_line(B,N,1,0).

display_line([X|R],N,NBC,NBL):- 
	NBC\=6,NBL\=50,X is (NBC + NBL),write(' B '),NBC2 is (NBC+1),!, display_line( R , N , NBC2 , NBL),!.
display_line(B,[X|R],NBC,NBL):- 
	NBC\=6,NBL\=50,X is (NBC + NBL),write(' N '),NBC2 is (NBC+1),!, display_line( B , R , NBC2 , NBL),!.
display_line(B,N,NBC,NBL):- 
	NBC\=6,NBL\=50,write(' X '),NBC2 is (NBC+1),!, display_line(B,N , NBC2 , NBL),!.

display_line(B,N,6,NBL):- write(''),nl, NBL2 is (NBL + 10),!, display_line( B , N , 1 , NBL2),!.
display_line(_,_,1,50):-!.


