main
  :- generator(X), selector(X), write(X).

% generates pairs of consecutive months list
generator([[M1, D1, S1], [M2, D2, S2]]) :-
    between(1, 12, M1),
    monthndays(M1, D1),
    addWrap(12, M1, 1, M2),
    monthndays(M2, D2),
    between(1, 7, S1),
    T is D1 mod 7,
    addWrap(7, S1, T, S2).
    
% Wrap-around addition
addWrap(Limit, P, Q, R) :-
    R is ((P + Q - 1) mod Limit) + 1.

% provides month names and their lengths.
monthndays(M, 31) :- member(M, [1, 3, 5, 7, 8, 10, 12]).
monthndays(M, 30) :- member(M, [4, 6, 9, 11]).
monthndays(2, 28).
monthndays(2, 29).

% fliters all conditions
selector([[M1, D1, S1], [M2, D2, S2]]) :-
    T1 = D1, U1 = D2,
    monthlen(M1, T2), monthlen(M2, U2),
    primes(D1, T3), primes(D2, U3),
    mondays(D1, S1, X1), length(X1, T4),
    mondays(D2, S2, X2), length(X2, U4),
    primeSaturdays(D1, S1, Y1), length(Y1, T5),
    primeSaturdays(D2, S2, Y2), length(Y2, U5),
    T1 =\= U1, T2 =\= U2, T3 =\= U3, T4 =\= U4, T5 =\= U5,
    prime(T1 + T2 + T3 + T4 + T5),
    prime(U1 + U2 + U3 + U4 + U5).

% provide month names and their lengths
monthlen(Month, Length) :-
    member([Month, Name], [
        [1, "January"], [2, "February"], [3, "March"], [4, "April"],
        [5, "May"], [6, "June"], [7, "July"], [8, "August"],
        [9, "September"], [10, "October"], [11, "November"], [12, "December"]]),
    atom_length(Name, Length).

% prime days in a month
primes(28, 9).
primes(29, 10).
primes(30, 10).
primes(31, 11).

% find all the mondays in a month
mondays(D, S, XS) :-
    T is 7 - S,
    addWrap(7, T, 2, Start),
    findall(M, (between(0, D, N), M is Start + N * 7, M =< D), XS).

% find all the saturdays in a month
saturdays(D, S, XS) :-
    T is 7 - S,
    addWrap(7, T, 0, Start),
    findall(Sat, (between(0, D, N), Sat is Start + N * 7, Sat =< D), XS).

% find all the prime saturdays in a month
primeSaturdays(D, S, US) :- 
    saturdays(D, S, TS),
    intersection(TS, [2 ,3 ,5 ,7 ,11 ,13 ,17 ,19 ,23 ,29 ,31], US).

% check prime number
prime(N) :-
    N > 1,
    N =\= 1,
    \+ has_factor(N, 2).

has_factor(N, F) :-
    F * F =< N,
    (N mod F =:= 0; NextF is F + 1, has_factor(N, NextF)).
