main
  :- generator(X), selector(X), write(X).

-- calculates specific day properties in a month
mondays(D, S, X) :-
    findall(Day, (between(1, D, Day), (((Day + S - 2) mod 7) + 1) =:= 1), X).

-- generates pairs of consecutive months list
generator([[M1, D1, S1], [M2, D2, S2]]) :-
    between(1, 12, M1),
    M2 is (M1 mod 12) + 1,
    mnd(M1, D1),
    mnd(M2, D2),
    between(1, 7, S1),
    S2 is (S1 + D1 - 1) mod 7 + 1.
    
-- provides month names and their lengths.
mnd(M, 31) :- member(M, [1, 3, 5, 7, 8, 10, 12]).
mnd(M, 30) :- member(M, [4, 6, 9, 11]).
mnd(2, 28).
mnd(2, 29).

-- fliters all conditions
selector4([[M1, D1, S1], [M2, D2, S2]]) :-
    D1 = T1, D2 = U1,
    monthl(M1, T2), monthl(M2, U2),
    primed(M1, T3), primed(M2, U3),
    cmondays(D1, S1, T4), cmondays(D2, S2, U4),
    psaturdays(D1, S1, T5), psaturdays(D2, S2, U5),
    different([T1, U1]),
    different([T2, U2]),
    different([T3, U3]),
    different([T4, U4]),
    different([T5, U5]),
    prime(T1 + T2 + T3 + T4 + T5),
    prime(U1 + U2 + U3 + U4 + U5).

-- maps month numbers
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

-- provide month names and their lengths
monthl(M, Length) :-
    mn(M, Name),
    atom_length(Name, Length).

-- check if a number is prime
prime(N)
  :- N > 1, \+ factorisable(2, N ).

factorisable(F, N)
  :- F*F =< N,
     0 is N mod F.
factorisable(F, N)
  :- F*F =< N,
     F1 is F + 1,
     factorisable(F1, N).

primed(D, X) :-
    findall(Day, (between(1, D, Day), prime(Day)), Y),
    length(Y, X).

psaturdays(D, S, X) :-
    findall(Day, (between(1, D, Day), prime(Day), (Day + S - 1) mod 7 =:= 6), PS),
    length(PS, X).

cmondays(D, S, X) :-
    mondays(D, S, Y),
    length(Y, X).

different([]).
different([X|XS]) :-
    \+ member(X, XS),
    different(XS).
