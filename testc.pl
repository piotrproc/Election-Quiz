:- dynamic([xza/1, xprzeciw/1, xnie_wiem/1, xjest/1, xpartia_jest/1, xwhy/2, xhow/4]).

%uzupelniam listy pustym znakiem, inaczej zle sie drukuja
przygotuj :-
	assertz(xza('')),
	assertz(xprzeciw('')),
	assertz(xnie_wiem('')),
	assertz(xjest('')),
	assertz(xpartia_jest('')),
	assertz(xwhy('','')),
	assertz(xhow('','','','')).
	

kpartia_jest(X) :-
	partia_jest(X),
	(xpartia_jest(X);
	(assertz(xpartia_jest(X)),
	assertz(xwhy('partia_jest', X)))).

partia_jest(korwin) :-
	kjest(korwin, wolnosciowiec),
	(kjest(korwin, konserwatysta);
	kjest(korwin, wolnorynkowiec);
	kjest(korwin, minarchista);
	kjest(korwin, eurosceptyk)).
	
partia_jest(braun) :-
	kjest(braun, ultrakatolik),
	(kjest(braun, wolnosciowiec);
	kjest(braun, wolnorynkowiec);
	kjest(braun, minarchista)).
	
partia_jest(ruch_narodowy) :-
	kjest(ruch_narodowy, patriota),
	(kjest(ruch_narodowy, konserwatysta);
	kjest(ruch_narodowy, eurosceptyk)).

partia_jest(ruch_kukiza) :-
	kjest(ruch_kukiza, patriota),
	za(ruch_kukiza, demokrata, jednomandatowe_okregi_wyborcze).

partia_jest(demokracja_bezposrednia) :-
	za(demokracja_bezposrednia, demokrata, demokracja),
	kjest(demokracja_bezposrednia, minarchista).

partia_jest(pis) :-
	kjest(pis, konserwatysta),
	(kjest(pis, socjalista);
	kjest(pis, ultrakatolik);
	kjest(pis, panstwowiec)).

partia_jest(po) :-
	kjest(po, zwolennik_bezpieczenstwa),
	(kjest(po, socjalista);
	kjest(po, panstwowiec);
	kjest(po, zwolennik_ue)).
	
partia_jest(sld) :-
	kjest(sld, socjalista),
	kjest(sld, panstwowiec),
	(kjest(sld, zwolennik_bezpieczenstwa);
	kjest(sld, postepowy);
	kjest(sld, sekularysta);
	za(sld, demokrata, demokracja)).

partia_jest(twoj_ruch) :-
	kjest(twoj_ruch, sekularysta),
	(kjest(twoj_ruch, postepowy);
	kjest(twoj_ruch, wojujacy_ateista);
	kjest(twoj_ruch, zwolennik_ue)).

partia_jest(zieloni) :-
	kjest(zieloni, postepowy),
	kjest(zieloni, ekologiczny).


/*
================================
*/

kjest(X, Y) :-
	assertz(xwhy('partia_jest', X)),
	assertz(xwhy('jest', Y)),
	jest(X, Y),
	(xjest(Y);
	assertz(xjest(Y))).

jest(X, wolnosciowiec) :-
	przeciw(X, wolnosciowiec, acta_czyli_ograniczenie_wolnosci_w_internecie),
	przeciw(X, wolnosciowiec, karanie_za_brak_zapietych_pasow).
	
jest(X, zwolennik_bezpieczenstwa) :-
	not(jest(X, wolnosciowiec)).

jest(X, postepowy) :-
	za(X, postepowy, in_vitro),
	za(X, postepowy, aborcja),
	za(X, postepowy, eutanazja),
	za(X, postepowy, legalizacja_zwiazkow_homoseksualnych).

jest(X, konserwatysta) :-
	przeciw(X, konserwatysta, aborcja),
	przeciw(X, konserwatysta, legalizacja_zwiazkow_homoseksualnych),
	przeciw(X, konserwatysta, ideologia_gender_w_szkolach),
	za(X, konserwatysta, klauzula_sumienia).

%zwolennik_panstwa_minimalnego
jest(X, minarchista) :- 
	za(X, minarchista, proste_podatki),
	za(X, minarchista, mala_liczba_urzednikow),
	za(X, minarchista, ograniczenie_biurokracji).

jest(X, panstwowiec) :-
	not(jest(X, minarchista)).
	
jest(X, wolnorynkowiec) :-
	przeciw(X, wolnorynkowiec, wysokie_podatki_dla_bogatych),
	przeciw(X, wolnorynkowiec, piecset_zlotych_na_kazde_dziecko).

jest(X, socjalista) :-
	not(jest(X, wolnorynkowiec)).
	
jest(X, patriota) :-
	przeciw(X, patriota, przyjecie_imigrantow_niezaleznie_od_wyznania),
	za(X, patriota, rozliczenie_komunistow).

jest(X, obojetny_narodowo) :-
	za(X, obojetny_narodowo, przyjecie_imigrantow_niezaleznie_od_wyznania).

jest(X, ultrakatolik) :-
	jest(X, konserwatysta),
	za(X, ultrakatolik, nauka_religii_w_szkolach),
	przeciw(X, ultrakatolik, opodatkowanie_kosciola),
	przeciw(X, ultrakatolik, odlaczenie_wladzy_swieckiej_od_duchowej),
	przeciw(X, ultrakatolik, in_vitro),
	przeciw(X, ultrakatolik, eutanazja).

%zwolennik_panstwa_swieckiego
jest(X, sekularysta) :-
	przeciw(X, sekularysta, nauka_religii_w_szkolach),
	za(X, sekularysta, odlaczenie_wladzy_swieckiej_od_duchowej).
	
jest(X, wojujacy_ateista) :-
	jest(X, sekularysta),
	jest(X, postepowy),
	przeciw(X, wojujacy_ateista, klauzula_sumienia),
	za(X, wojujacy_ateista, opodatkowanie_kosciola),
	za(X, wojujacy_ateista, ideologia_gender_w_szkolach).

jest(X, zwolennik_ue) :-
	za(X, zwolennik_ue, wprowadzenie_waluty_euro);
	za(X, zwolennik_ue, dotacje_europejskie).

jest(X, eurosceptyk) :-
	not(jest(X, zwolennik_ue)).

jest(X, ekologiczny) :-
	za(X, ekologiczny, ograniczenie_emisji_co2);
	za(X, ekologiczny, odnawialne_zrodla_energii);
	za(X, ekologiczny, segregowanie_smieci).

jest(X, obojetny_ekologicznie) :-
	not(jest(X, ekologiczny)).


	
/*
================================
*/
	
za(_, _, Z) :-
	assertz(xwhy('za', Z)),
	xza(Z), !;
	xnie_wiem(Z), !.

za(X, Y, Z) :-
	not(xprzeciw(Z)),
	not(xnie_wiem(Z)),
	pytaj(X, Y, Z, tak).

przeciw(_, _, Z) :-
	assertz(xwhy('przeciw', Z)),
	xprzeciw(Z), !; 
	xnie_wiem(Z), !.

przeciw(X, Y, Z) :-
	not(xza(Z)),
	not(xnie_wiem(Z)),
	pytaj(X, Y, Z, nie).

pytaj(X, Y, Z, K) :-
	!, write('\nCzy jestes za: '), write(Z), write('? \n'),
	write('a) Tak \n'), 
	write('b) Nie \n'),
	write('c) Chce pominac to pytanie (odpowiedz nie bedzie miala wplywu na wynik testu)\n\n'),
	
	readln([Replay]),
	not(skoncz(Replay)),
	
	(pamietaj(X, Y, Z, Replay),
	(odpowiedz(Replay, K);
	odpowiedz(Replay, nie_wiem));
	
	(odpowiedz(Replay, what),
	pytaj(X, Y, Z, K));
	
	(odpowiedz(Replay, how),
	pytaj(X, Y, Z, K));
	
	(odpowiedz(Replay, why),
	pytaj(X, Y, Z, K));
	
	(odpowiedz(Replay, help),
	pytaj(X, Y, Z, K))).

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

odpowiedz(Replay, why):-
	sub_string(Replay, 0, _, _, 'why'),
	podaj_why.
	
odpowiedz(Replay, how):-
	sub_string(Replay, 0, _, _, 'how'),
	podaj_how.

odpowiedz(Replay, help) :-
	sub_string(Replay, 0, _, _, 'help'),
	help.

help :-
	write('\n<------- MANUAL ---------->\n\n'),
	write('help - wyswietla pomoc\n'),
	write('what - lista dotychczas ustalonych faktow (symptomy, fakty posrednie, hipoteza)\n'),
	write('how - lista what poszerzona o sposob w jaki uzyskano dany fakt (odpowiedz na symptom, reguly)\n'),
	write('why - dlaczego system pyta o dany symptom (stos regul przetwarzanych, ktore wygenerowaly pytanie)\n'),
	write('end - zakonczenie testu, usuwane zostaja wszystkie odpowiedzi uzytkownika\n'),
	write('\n<-------- END --------->\n\n').
	
skoncz(Replay) :-
	odpowiedz(Replay, end),
	wyczysc_fakty,
	abort.
	
pamietaj(X, Y, Z, Replay) :-
	odpowiedz(Replay, tak),
	assertz(xza(Z)),
	assertz(xhow(X, Y, Z, 'tak')).

pamietaj(X, Y, Z, Replay) :-
	odpowiedz(Replay, nie),
	assertz(xprzeciw(Z)),
	assertz(xhow(X, Y, Z, 'nie')).

pamietaj(X, Y, Z, Replay) :-
	odpowiedz(Replay, nie_wiem),
	assertz(xnie_wiem(Z)),
	assertz(xhow(X, Y, Z, 'nie_wiem')).

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
	bagof([K00, K01], xwhy(K00,K01), L00),
	drukuj(L00),
	
	write('\n\n<----- END ------>\n\n').	

podaj_how :-
	podaj_what,
	write('\n<----- TRACE ----->'),
	
	write('\n\nSkad sie wziely fakty posrednie:\n'),
	setof([K000, K001, K002, K003], (xhow(K000, K001, K002, K003), xjest(K001)), L000),
	drukuj(L000),
	
	write('\n\nSkad sie wziely partie:\n'),
	setof([K0000, K0001, K0002, K0003], (xhow(K0000, K0001, K0002, K0003), xpartia_jest(K0000)), L0000),
	drukuj(L0000),
	
	write('\n\n<----- END ------>\n\n').
	
wyczysc_fakty :-
	write('\n\nNacisnij enter aby zakonczyc\n'),
	retractall(xza(_)),
	retractall(xprzeciw(_)),
	retractall(xnie_wiem(_)),
	retractall(xjest(_)),
	retractall(xpartia_jest(_)),
	retractall(xwhy(_,_)),
	retractall(xhow(_,_,_,_)),
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
	setof(Y, kjest(_, Y), Z), 
	write('\nMasz nastepujace poglady polityczne:\n'), drukuj(Z), nl, nl,
	write('\nMozesz zaglosowac na nastepujace partie:\n'), drukuj(B), 
	wyczysc_fakty.	


t :-
	write('\nNie jestem w stanie ustalic'),
	write(' twoich preferencji wyborczych.\n\n'), 
	wyczysc_fakty.

