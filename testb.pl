:- dynamic([xza/1, xprzeciw/1, xnie_wiem/1, xjest/1, xpartia_jest/1, xstos/2]).

%ladna wersja dzialajaca z dodatkami a) i c)

%uzupelniam listy pustym znakiem, inaczej zle sie drukuja
przygotuj :-
	assertz(xza('')),
	assertz(xprzeciw('')),
	assertz(xnie_wiem('')),
	assertz(xjest('')),
	assertz(xpartia_jest('')),
	assertz(xstos('','')).
	

kpartia_jest(X) :-
	partia_jest(X),
	(xpartia_jest(X);
	(assertz(xpartia_jest(X)),
	assertz(xstos('partia_jest', X)))).

partia_jest(korwin) :-
	kjest(wolnosciowiec),
	(kjest(konserwatysta);
	kjest(wolnorynkowiec);
	kjest(minarchista);
	kjest(eurosceptyk)).
	
partia_jest(braun) :-
	kjest(ultrakatolik),
	(kjest(wolnosciowiec);
	kjest(wolnorynkowiec);
	kjest(minarchista)).
	
partia_jest(ruch_narodowy) :-
	kjest(patriota),
	(kjest(konserwatysta);
	kjest(eurosceptyk)).

partia_jest(ruch_kukiza) :-
	kjest(patriota);
	za(jednomandatowe_okregi_wyborcze).

partia_jest(demokracja_bezposrednia) :-
	za(demokracja),
	kjest(minarchista).

partia_jest(pis) :-
	kjest(konserwatysta),
	(kjest(socjalista);
	kjest(ultrakatolik);
	kjest(panstwowiec)).

partia_jest(po) :-
	kjest(zwolennik_bezpieczenstwa),
	(kjest(socjalista);
	kjest(panstwowiec);
	kjest(zwolennik_ue)).
	
partia_jest(sld) :-
	kjest(socjalista),
	kjest(panstwowiec),
	(kjest(zwolennik_bezpieczenstwa);
	kjest(postepowy);
	kjest(sekularysta);
	za(demokracja)).

partia_jest(twoj_ruch) :-
	kjest(sekularysta),
	(kjest(postepowy);
	kjest(wojujacy_ateista);
	kjest(zwolennik_ue)).

partia_jest(zieloni) :-
	kjest(postepowy),
	kjest(ekologiczny).


/*
================================
*/

kjest(X) :-
	assertz(xstos('jest', X)),
	jest(X),
	(xjest(X);
	assertz(xjest(X))).

jest(wolnosciowiec) :-
	przeciw(acta_czyli_ograniczenie_wolnosci_w_internecie),
	przeciw(karanie_za_brak_zapietych_pasow).
	
jest(zwolennik_bezpieczenstwa) :-
	not(jest(wolnosciowiec)).

jest(postepowy) :-
	za(in_vitro),
	za(aborcja),
	za(eutanazja),
	za(legalizacja_zwiazkow_homoseksualnych).

jest(konserwatysta) :-
	przeciw(aborcja),
	przeciw(legalizacja_zwiazkow_homoseksualnych),
	przeciw(ideologia_gender_w_szkolach),
	za(klauzula_sumienia).

%zwolennik_panstwa_minimalnego
jest(minarchista) :- 
	za(proste_podatki),
	za(mala_liczba_urzednikow),
	za(ograniczenie_biurokracji).

jest(panstwowiec) :-
	not(jest(minarchista)).
	
jest(wolnorynkowiec) :-
	przeciw(wysokie_podatki_dla_bogatych),
	przeciw(piecset_zlotych_na_kazde_dziecko).

jest(socjalista) :-
	not(jest(wolnorynkowiec)).
	
jest(patriota) :-
	przeciw(przyjecie_imigrantow_niezaleznie_od_wyznania),
	za(rozliczenie_komunistow).

jest(obojetny_narodowo) :-
	za(przyjecie_imigrantow_niezaleznie_od_wyznania).

jest(ultrakatolik) :-
	jest(konserwatysta),
	za(nauka_religii_w_szkolach),
	przeciw(opodatkowanie_kosciola),
	przeciw(odlaczenie_wladzy_swieckiej_od_duchowej),
	przeciw(in_vitro),
	przeciw(eutanazja).

%zwolennik_panstwa_swieckiego
jest(sekularysta) :-
	przeciw(nauka_religii_w_szkolach),
	za(odlaczenie_wladzy_swieckiej_od_duchowej).
	
jest(wojujacy_ateista) :-
	jest(sekularysta),
	jest(postepowy),
	przeciw(klauzula_sumienia),
	za(opodatkowanie_kosciola),
	za(ideologia_gender_w_szkolach).

jest(zwolennik_ue) :-
	za(wprowadzenie_waluty_euro);
	za(dotacje_europejskie).

jest(eurosceptyk) :-
	not(jest(zwolennik_ue)).

jest(ekologiczny) :-
	za(ograniczenie_emisji_co2);
	za(odnawialne_zrodla_energii);
	za(segregowanie_smieci).

jest(obojetny_ekologicznie) :-
	not(jest(ekologiczny)).


	
/*
================================
*/
	
za(X) :-
	assertz(xstos('za', X)),
	xza(X), !;
	xnie_wiem(X), !.

za(X) :-
	not(xprzeciw(X)),
	not(xnie_wiem(X)),
	pytaj(X, tak).

przeciw(X) :-
	assertz(xstos('przeciw', X)),
	xprzeciw(X), !; 
	xnie_wiem(X), !.

przeciw(X) :-
	not(xza(X)),
	not(xnie_wiem(X)),
	pytaj(X, nie).

pytaj(X, K) :-
	!, write('\nCzy jestes za: '), write(X), write('? \n'),
	write('a) Tak \n'), 
	write('b) Nie \n'),
	write('c) Chce pominac to pytanie (odpowiedz nie bedzie miala wplywu na wynik testu)\n\n'),
	
	readln([Replay]),
	not(skoncz(Replay)),
	
	(pamietaj(X, Replay),
	(odpowiedz(Replay, K);
	odpowiedz(Replay, nie_wiem));
	
	(odpowiedz(Replay, what),
	pytaj(X,K));
	
	(odpowiedz(Replay, how),
	pytaj(X,K));
	
	(odpowiedz(Replay, why),
	pytaj(X,K))).

odpowiedz(Replay, tak):-
	sub_string(Replay, 0, _, _, 'a').

odpowiedz(Replay, nie):-
	sub_string(Replay, 0, _, _, 'b').

odpowiedz(Replay, nie_wiem):-
	sub_string(Replay, 0, _, _, 'c').

odpowiedz(Replay, end) :-
	sub_string(Replay, 0, _, _, 'end').
	
odpowiedz(Replay, what):-
	sub_string(Replay, 0, _, _, 'what'),
	podaj_what.

odpowiedz(Replay, how):-
	sub_string(Replay, 0, _, _, 'how'),
	podaj_how.

odpowiedz(Replay, why):-
	sub_string(Replay, 0, _, _, 'why'),
	podaj_why.

pamietaj(X, Replay) :-
	odpowiedz(Replay, tak),
	assertz(xza(X)).

pamietaj(X, Replay) :-
	odpowiedz(Replay, nie),
	assertz(xprzeciw(X)).

pamietaj(X, Replay) :-
	odpowiedz(Replay, nie_wiem),
	assertz(xnie_wiem(X)).


skoncz(Replay) :-
	odpowiedz(Replay, end),
	wyczysc_fakty,
	abort.

podaj_what :-
	write('\n<----- TRACE ----->'),
	
	write('\n\nHipotezy:\n'),
	setof(K1, xpartia_jest(K1), L1),
	drukuj(L1),
	
	write('\n\nFakty posrednie:\n'),
	setof(K2, xjest(K2), L2),
	drukuj(L2),
	
	write('\n\nSymptomy na tak:\n'),
	setof(K3, xza(K3), L3),
	drukuj(L3),
	
	write('\n\nSymptomy na nie:\n'),
	setof(K4, xprzeciw(K4), L4),
	drukuj(L4),
	
	write('\n\nSymptomy na nie wiem:\n'),
	setof(K5, xnie_wiem(K5), L5),
	drukuj(L5),
	
	write('\n\n<----- END ------>\n\n').
	
podaj_why :-
	write('\n<----- TRACE ----->'),
	
	write('\n\nStos zapytan:\n'),
	bagof([K00, K01], xstos(K00,K01), L0),
	drukuj(L0),
	
	write('\n\n<----- END ------>\n\n').
	
wyczysc_fakty :-
	write('\n\nNacisnij enter aby zakonczyc\n'),
	retractall(xza(_)),
	retractall(xprzeciw(_)),
	retractall(xnie_wiem(_)),
	retractall(xjest(_)),
	retractall(xpartia_jest(_)),
	retractall(xstos(_,_)),
	readln(_).

%funkcja drukuje liste bez pierwszego elementu
drukuj( [_|Y]) :-
	xdrukuj(Y).

xdrukuj([]).
xdrukuj( [X|Y] ) :- 
	write('- '), write(X), write(',\n'), xdrukuj(Y).

t :-
	przygotuj,
	%kpartia_jest(ruch_kukiza),
	%kpartia_jest(demokracja_bezposrednia), 
	%write('\n Partia Kukiz'),
	setof(A, kpartia_jest(A), B),
	setof(X, kjest(X), Z), 
	write('\nMasz nastepujace poglady polityczne:\n'), drukuj(Z), nl, nl,
	write('\nMozesz zaglosowac na nastepujace partie:\n'), drukuj(B), 
	wyczysc_fakty.	


t :-
	write('\nNie jestem w stanie ustalic'),
	write(' twoich preferencji wyborczych.\n\n'), 
	wyczysc_fakty.

