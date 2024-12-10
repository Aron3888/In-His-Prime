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
    T is P + Q,
    (T > Limit -> R is T - Limit; R is T).

% provides month names and their lengths.
monthndays(M, 31) :- member(M, [1, 3, 5, 7, 8, 10, 12]).
monthndays(M, 30) :- member(M, [4, 6, 9, 11]).
monthndays(2, 28).
monthndays(2, 29).

% fliters all conditions
selector([[M1, D1, S1], [M2, D2, S2]]) :-
    measure(M1, D1, S1, T1, T2, T3, T4, T5),
    measure(M2, D2, S2, U1, U2, U3, U4, U5),
    T1 =\= U1, T2 =\= U2, T3 =\= U3, T4 =\= U4, T5 =\= U5,
    prime(T1 + T2 + T3 + T4 + T5),
    prime(U1 + U2 + U3 + U4 + U5).

measure(M, D, S, D, V2, V3, V4, V5)
  :- monthlen(M, V2),
     primes(D, V3),
     mondays(D, S, TS), length(TS, V4),
     primeSaturdays(D, S, US), length(US, V5).

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

% prime days in a month
primes(28, 9).
primes(29, 10).
primes(30, 10).
primes(31, 11).

mondays(D, S, TS)
  :- T is 7 - S,
     addWrap(7, T, 2, I),
     fromToStep(I, D, 7, TS).

saturdays(D, S, TS)
  :- T is 7 - S,
     addWrap(7, T, 0, I),
     fromToStep(I, D, 7, TS).

fromToStep(I, D, _, [])
  :- I > D.
fromToStep(I, D, S, [I |IS])
  :- I =< D,
     I1 is I + S,
     fromToStep(I1, D, S, IS).

primeSaturdays(D, S, US)
  :- saturdays(D, S, TS),
     intersection(TS, [2 ,3 ,5 ,7 ,11 ,13 ,17 ,19 ,23 ,29 ,31], US).

% check if a number is prime
prime(N)
  :- N > 1, \+ factorisable(2, N).

factorisable(F, N)
  :- F*F =< N,
     0 is N mod F.
factorisable(F, N)
  :- F*F =< N,
     F1 is F + 1,
     factorisable(F1, N).
