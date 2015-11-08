potomek(P, O):-rodzic(O,P). 
potomek(P, O):-rodzic(O, X), potomek(P, X). 
rodzic(tomek, adam). 
rodzic(adam, ola). 
rodzic(adam, ela).