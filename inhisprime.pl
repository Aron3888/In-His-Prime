main
  :- generator(X), selector(X), write(X).

mondays(D, S, X) :-
    findall(Day, (between(1, D, Day), (((Day + S - 2) mod 7) + 1) =:= 1), X).
    
mnd(M, 31) :- member(M, [1, 3, 5, 7, 8, 10, 12]).
mnd(M, 30) :- member(M, [4, 6, 9, 11]).
mnd(2, 28).
mnd(2, 29).

generator([[M1, D1, S1], [M2, D2, S2]]) :-
    between(1, 12, M1),
    M2 is (M1 mod 12) + 1,
    mnd(M1, D1),
    mnd(M2, D2),
    between(1, 7, S1),
    S2 is (S1 + D1 - 1) mod 7 + 1.

mn(1, "January").
mn(2, "February").
mn(3, "March").
mn(4, "April").
mn(5, "May").
mn(6, "June").
mn(7, "July").
mn(8, "August").
mn(9, "September").
mn(10, "October").
mn(11, "November").
mn(12, "December").

monthl(M, Length) :-
    mn(M, Name),
    atom_length(Name, Length).

prime(N)
  :- N > 1, \+ factorisable(2, N ).

factorisable(F, N)
  :- F*F =< N,
     0 is N mod F.
factorisable(F, N)
  :- F*F =< N,
     F1 is F + 1,
     factorisable(F1, N).
