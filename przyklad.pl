:- dynamic([xpozytywne/2, xnegatywne/2]).

zwierze_jest(gepard) :-
	jest_to(ssak),
	jest_to(miesozerny),
	pozytywne(ma, brunatny_kolor),
	pozytywne(ma, ciemne_plamy).

zwierze_jest(tygrys) :-
	jest_to(ssak),
	jest_to(miesozerny),
	pozytywne(ma, brunatny_kolor),
	pozytywne(ma, czarne_pasy).

zwierze_jest(zyrafa) :-
	jest_to(kopytonogi),
	pozytywne(ma, dluga_szyja),
	pozytywne(ma, dlugie_nogi),
	pozytywne(ma, ciemne_plamy).

zwierze_jest(zebra) :-
	jest_to(kopytonogi),
	pozytywne(ma, czarne_pasy).

zwierze_jest(strus) :-
	jest_to(ptak),
	negatywne(czy, lata),
	pozytywne(ma, dluga_szyja),
	pozytywne(ma, dlugie_nogi),
	pozytywne(ma, biale_i_czarne_kolory).

zwierze_jest(pingwin) :-
	jest_to(ptak),
	negatywne(czy, lata),
	pozytywne(czy, plywa),
	pozytywne(ma, biale_i_czarne_kolory).

zwierze_jest(albatros) :-
	jest_to(ptak),
	pozytywne(czy, lata_dobrze).

jest_to(ssak) :-
	pozytywne(ma, siersc).

jest_to(ssak) :-
	pozytywne(czy, daje_mleko).

jest_to(ptak) :-
	pozytywne(ma, piora).

jest_to(ptak) :-
	pozytywne(czy, lata),
	pozytywne(czy, znosi_jajka).

jest_to(miesozerny) :-
	pozytywne(czy, je_mieso).

jest_to(miesozerny) :-
	pozytywne(ma, ostre_zeby),
	pozytywne(ma, pazury),
	pozytywne(ma, wysuniete_do_przodu_oczy).

jest_to(kopytonogi) :-
	jest_to(ssak),
	pozytywne(ma, kopyta).

jest_to(kopytonogi) :-
	jest_to(ssak),
	pozytywne(czy, przezuwa_pokarm).

pozytywne(X, Y) :-
	xpozytywne(X, Y), !.

pozytywne(X, Y) :-
	not(xnegatywne(X, Y)),
	pytaj(X, Y, tak).

negatywne(X, Y) :-
	xnegatywne(X, Y), !.

negatywne(X, Y) :-
	not(xpozytywne(X, Y)),
	pytaj(X, Y, nie).

pytaj(X, Y, tak) :-
	!, write(X), write(' to_zwierze '), write(Y), write(' ? (t/n)\n'),
	readln([Replay]),
	pamietaj(X, Y, Replay), 
	odpowiedz(Replay, tak).


pytaj(X, Y, nie) :-
	!, write(X), write(' to_zwierze '), write(Y), write(' ? (t/n)\n'),
	readln([Replay]),
	pamietaj(X, Y, Replay),
	odpowiedz(Replay, nie).    

odpowiedz(Replay, tak):-
	sub_string(Replay, 0, _, _, 't').

odpowiedz(Replay, nie):-
	sub_string(Replay, 0, _, _, 'n').

pamietaj(X, Y, Replay) :-
	odpowiedz(Replay, tak),
	assertz(xpozytywne(X, Y)).

pamietaj(X, Y, Replay) :-
	odpowiedz(Replay, nie),
	assertz(xnegatywne(X, Y)).

wyczysc_fakty :-
	write('\n\nNacisnij enter aby zakonczyc\n'),
	retractall(xpozytywne(_, _)),
	retractall(xnegatywne(_, _)),
	readln(_).

wykonaj :-
	zwierze_jest(X), !,
	write('Twoim zwierzeciem moze byc '), write(X), nl,
	wyczysc_fakty.

wykonaj :-
	write('\nNie jestem w stanie odgadnac, '),
	write('jakie zwierze masz na mysli.\n\n'), wyczysc_fakty.


	