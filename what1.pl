jest(a).
jest(b).
jest(c).



odpowiedz(Replay, what):-
	sub_string(Replay, 0, _, _, 'what').

t :- 
	readln([Replay]),
	odpowiedz(Replay, what),
	findall(X, jest(X), L),
	write(L).
