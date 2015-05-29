:-use_module(library(pce)). 

% Le prédicat de calcul de l expression est très simple
calcule(Atom, A) :-
      term_to_atom(Expr, Atom),
      A is Expr.

% le prédicat principal du programme
calcul :-
	% on crée la boîte de dialogue
	new(D, dialog('Prolog au travail !')),
	% on ajoute d'abord un champ de saisie précédé du
	% libellé 'Saisissez votre calcul' 
	send(D, append,
	     new(ExprItem, text_item('Saisissez votre calcul '))),
	% on ajoute ensuite un champ texte, un label en terme XPCE
	send(D, append, new(Resultat, label(''))),
      % on lui donne la couleur rouge
      send(Resultat, colour, red),
	% il sera écrit en caractères gras de taille 18
	send(Resultat, font, font(times, bold, 18)),
	% On ajoute un bouton de nom calcul, son libellé
	% sera Calcul par défaut, et son action consistera
	% a appelé le prédicat Prolog lance_calcul avec 
	% deux arguments, la saisie effectuée et le composant
	% ou écrire le résultat
	send(D, append,
	     button(calcul, message(@prolog, lance_calcul, 
				ExprItem?selection, Resultat))),
	% on ajoute un bouton de nom cancel dont la fonction 
	% est de détruire la fenêtre
	send(D, append,
	     button(cancel, message(D, destroy))),
	% enfin on ouvre la fenêtre
	send(D, open).

% le prédicat d'interaction entre la fenêtre et le prédicat calcul
lance_calcul(Expr, Resultat) :-
	calcule(Expr, Res),
    % le résultat est écrit dans une chaîne de caractères
    % comme le sprintf du C
	sformat(Str, '~w = ~w', [Expr, Res]),
    % on envoie au label Resultat la chaîne
	send(Resultat, selection, Str).	