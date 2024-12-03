main
  :- generator(X), selector(X), write(X).

% calculates specific day properties in a month
mondays(D, S, X) :-
    findall(Day, (between(1, D, Day), ((Day + S - 2) mod 7) =:= 0), X).

% generates pairs of consecutive months list
generator([[M1, D1, S1], [M2, D2, S2]]) :-
    between(1, 12, M1),
    M2 is (M1 mod 12) + 1,
    monthndays(M1, D1),
    monthndays(M2, D2),
    between(1, 7, S1),
    S2 is (S1 + D1 - 1) mod 7 + 1.
    
% provides month names and their lengths.
monthndays(M, 31) :- member(M, [1, 3, 5, 7, 8, 10, 12]).
monthndays(M, 30) :- member(M, [4, 6, 9, 11]).
monthndays(2, 28).
monthndays(2, 29).

% fliters all conditions
selector([[M1, D1, S1], [M2, D2, S2]]) :-
    D1 = T1, D2 = U1,
    monthlen(M1, T2), monthlen(M2, U2),
    primeday(M1, T3), primeday(M2, U3),
    mondaysinmonth(D1, S1, T4), mondaysinmonth(D2, S2, U4),
    primesaturdays(D1, S1, T5), primesaturdays(D2, S2, U5),
    T1 \= U1, T2 \= U2, T3 \= U3, T4 \= U4, T5 \= U5,
    prime(T1 + T2 + T3 + T4 + T5),
    prime(U1 + U2 + U3 + U4 + U5).

% maps month numbers
monthnumbers(1, "January").
monthnumbers(2, "February").
monthnumbers(3, "March").
monthnumbers(4, "April").
monthnumbers(5, "May").
monthnumbers(6, "June").
monthnumbers(7, "July").
monthnumbers(8, "August").
monthnumbers(9, "September").
monthnumbers(10, "October").
monthnumbers(11, "November").
monthnumbers(12, "December").

% provide month names and their lengths
monthlen(M, Length) :-
    monthnumbers(M, Name),
    atom_length(Name, Length).

% check if a number is prime
prime(N)
  :- N > 1, \+ factorisable(2, N ).

factorisable(F, N)
  :- F*F =< N,
     0 is N mod F.
factorisable(F, N)
  :- F*F =< N,
     F1 is F + 1,
     factorisable(F1, N).

% finds all the prime days in a month
primeday(D, X) :-
    findall(Day, (between(1, D, Day), prime(Day)), Y),
    length(Y, X).

% finds all the prime saturdays in a month
primesaturdays(D, S, X) :-
    findall(Day, (between(1, D, Day), prime(Day), (Day + S - 1) mod 7 =:= 6), PS),
    length(PS, X).

% finds all the mondays in a month
mondaysinmonth(D, S, X) :-
    mondays(D, S, Y),
    length(Y, X).
