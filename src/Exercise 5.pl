% use roman_to_decimal/2 and decimal_to_roman/2

toroman(N, _):-
    N < 0,
    !,
    fail.
toroman(0, []).
toroman(N, ['I'|Roman]) :-
    N < 4,
    M is N - 1,
    toroman(M, Roman).
toroman(4, ['IV']).
toroman(5, ['V']).
toroman(N, ['V'|Roman])
    :- N < 9,
    M is N - 5,
    toroman(M, Roman).
toroman(9, ['IX']).
toroman(N, ['X'|Roman]) :-
    N < 40,
    M is N - 10,
    toroman(M, Roman).
toroman(N, ['XL'|Roman]) :-
    N < 50,
    M is N - 40,
    toroman(M, Roman).
toroman(N, ['L'|Roman])
    :- N < 90,
    M is N - 50,
    toroman(M, Roman).
toroman(N, ['XC'|Roman]) :-
    N < 100,
    M is N - 90,
    toroman(M, Roman).
toroman(N, ['C'|Roman]) :-
    N < 400,
    M is N - 100,
    toroman(M, Roman).
toroman(N, ['CD'|Roman]) :-
    N < 500,
    M is N - 400,
    toroman(M, Roman).
toroman(N, ['DD'|Roman]) :-
    N < 900,
    M is N - 500,
    toroman(M, Roman).
toroman(N, ['CM'|Roman]) :-
    N < 1000,
    M is N - 900,
    toroman(M, Roman).
toroman(N, ['M'|Roman]) :-
    N < 4000,
    M is N - 1000,
    toroman(M, Roman).

decimal_to_roman(N, R) :-
    toroman(N, L),
    atomic_list_concat(L, R).

decimal_to_roman(N) :- roman(N, R), write(R).
decimal_to_roman(N):- N < 0, !, fail.

digit(i, 1).
digit(v, 5).
digit(x, 10).
digit(l, 50).
digit(c, 100).
digit(d, 500).
digit(m, 1000).

convert(Roman, Arabic) :-
    convert(Roman, 0, Arabic).

convert([], Acc, Acc).

convert([A], Acc, Arabic) :-
    digit(A, AVal),
    Arabic is Acc + AVal.

convert([A, B | Rest], Acc, Arabic) :-
    digit(A, AVal), digit(B, BVal),
    AVal < BVal,
    NewAcc is Acc + BVal - AVal,
    convert(Rest, NewAcc, Arabic).

convert([A, B | Rest], Acc, Arabic) :-
    digit(A, AVal), digit(B, BVal),
    AVal >= BVal,
    NewAcc is Acc + AVal,
    convert([B | Rest], NewAcc, Arabic).

roman_to_decimal(Roman, Arabic) :-
    string_chars(Roman, RomanList),
    convert(RomanList, Arabic).


% 2
% replace([1,2,3,4,5], 2, 100, L).

replace([_|T], 0, X, [X|T]).
replace([H|T], Index, Element, [H|R]):-
    Index > -1,
    NI is Index-1,
    replace(T, NI, Element, R),
    !.
replace(L, _, _, L).
