:- dynamic([xza/1, xprzeciw/1, xnie_wiem/1]).
 
partia_jest(korwin) :-
	jest(wolnosciowiec),
	(jest(konserwatysta);
	jest(wolnorynkowiec);
	jest(minarchista);
	jest(eurosceptyk)).
 
partia_jest(braun) :-
	jest(ultrakatolik),
	(jest(wolnosciowiec);
	jest(wolnorynkowiec);
	jest(minarchista)).
 
partia_jest(ruch_narodowy) :-
	jest(patriota),
	(jest(konserwatysta);
	jest(eurosceptyk)).
 
partia_jest(ruch_kukiza) :-
	jest(patriota);
	za(jednomandatowe_okregi_wyborcze).
 
partia_jest(demokracja_bezposrednia) :-
	za(demokracja),
	jest(minarchista).
 
partia_jest(pis) :-
	jest(konserwatysta),
	(jest(socjalista);
	jest(ultrakatolik);
	jest(panstwowiec)).
 
partia_jest(po) :-
	jest(zwolennik_bezpieczenstwa),
	(jest(socjalista);
	jest(panstwowiec);
	jest(zwolennik_ue)).
 
partia_jest(sld) :-
	jest(socjalista),
	jest(panstwowiec),
	(jest(zwolennik_bezpieczenstwa);
	jest(postepowy);
	jest(sekularysta);
	za(demokracja)).
 
partia_jest(twoj_ruch) :-
	jest(sekularysta),
	(jest(postepowy);
	jest(wojujacy_ateista);
	jest(zwolennik_ue)).
 
partia_jest(zieloni) :-
	jest(postepowy),
	jest(ekologiczny).
 
 
/*
================================
*/
 
 
jest(wolnosciowiec) :-
	przeciw(acta_czyli_ograniczenie_wolnosci_w_internecie),
	przeciw(karanie_za_brak_zapietych_pasow).
 
jest(zwolennik_bezpieczenstwa) :-
	not(jest(wolnosciowiec)).
 
jest(postepowy) :-
	za(in_vitro),
	za(aborcja),
	za(eutanazja),
	za(pary_homoseksualne).
 
jest(konserwatysta) :-
	przeciw(aborcja),
	przeciw(pary_homoseksualne),
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
	xza(X), !;
	xnie_wiem(X), !.
 
za(X) :-
	not(xprzeciw(X)),
	not(xnie_wiem(X)),
	pytaj(X, tak).
 
przeciw(X) :-
	xprzeciw(X), !; 
	xnie_wiem(X), !.
 
przeciw(X) :-
	not(xza(X)),
	not(xnie_wiem(X)),
	pytaj(X, nie).
 
pytaj(X, tak) :-
	!, write('\nCzy jestes za: '), write(X), write('? \n'),
	write('a) Tak \n'), 
	write('b) Nie \n'),
	write('c) Chce pominac to pytanie (odpowiedz nie bedzie miala wplywu na wynik testu)\n\n'),
	readln([Replay]),
	pamietaj(X, Replay),
	(odpowiedz(Replay, tak);
	odpowiedz(Replay, nie_wiem)).
 
 
pytaj(X, nie) :-
	!, write('\nCzy jestes za: '), write(X), write('? \n'),
	write('a) Tak \n'), 
	write('b) Nie \n'),
	write('c) Chce pominac to pytanie (odpowiedz nie bedzie miala wplywu na wynik testu)\n\n'),
	readln([Replay]),
	pamietaj(X, Replay),
	(odpowiedz(Replay, nie);
	odpowiedz(Replay, nie_wiem)).   
 
odpowiedz(Replay, tak):-
	sub_string(Replay, 0, _, _, 'a').
 
odpowiedz(Replay, nie):-
	sub_string(Replay, 0, _, _, 'b').
 
odpowiedz(Replay, nie_wiem):-
	sub_string(Replay, 0, _, _, 'c');
	not(odpowiedz(Replay, tak)),
	not(odpowiedz(Replay, nie)).
 
pamietaj(X, Replay) :-
	odpowiedz(Replay, tak),
	assertz(xza(X)).
 
pamietaj(X, Replay) :-
	odpowiedz(Replay, nie),
	assertz(xprzeciw(X)).
 
pamietaj(X, Replay) :-
	odpowiedz(Replay, nie_wiem),
	assertz(xnie_wiem(X)).
 
wyczysc_fakty :-
	write('\n\nNacisnij enter aby zakonczyc\n'),
	retractall(xza(_)),
	retractall(xprzeciw(_)),
	retractall(xnie_wiem(_)),
	readln(_).
 
drukuj([]).
drukuj( [X|Y] ):- write('- '), write(X), write(',\n'), drukuj(Y).
 
wykonaj :-
	setof(X, jest(X), Z), 
	setof(A, partia_jest(A), B),
	write('\nMasz nastepujace poglady polityczne:\n'), drukuj(Z), nl, nl,
	write('\nMozesz zaglosowac na nastepujace partie:\n'), drukuj(B), 
	wyczysc_fakty.	
 
 
wykonaj  :-
	write('\nNie jestem w stanie ustalic'),
	write(' twoich preferencji wyborczych.\n\n'), 
	wyczysc_fakty.