% I put here polish comments cause the program parses numbers to Polish and I think grammar is so specific that it does not works for other languages

% jednosci - jesli pojawia sie 0 to nie wypisujemy, zeby nie bylo
% sytuacji typu 1023 - tysiac zero dwadziescia trzy
% zero bedziemy wypisywac tylko w sytuacji, gdy wpiszemy 0 - ale to
% zrobimy w osobnym miejscu
jednosci(0).
jednosci(1) :- write(jeden).
jednosci(2) :- write(dwa).
jednosci(3) :- write(trzy).
jednosci(4) :- write(cztery).
jednosci(5) :- write(piec).
jednosci(6) :- write(szesc).
jednosci(7) :- write(siedem).
jednosci(8) :- write(osiem).
jednosci(9) :- write(dziewiec).
% tu biore pod uwage wpisanie pojedynczej liczby - jesli wpiszemy np 1,
% to program otrzyma nie 1, a [1], dlatego tutaj zrobimy konwersje
% z jednoelementowej listy do elementu
jednosci([X]) :- jednosci(X).

% numbers between 10 and 19
kilkanascie(0) :- write(dziesiec).
kilkanascie(1) :- write(jedenascie).
kilkanascie(2) :- write(dwanascie).
kilkanascie(3) :- write(trzynascie).
kilkanascie(4) :- write(czternascie).
kilkanascie(5) :- write(pietnascie).
kilkanascie(6) :- write(szesnascie).
kilkanascie(7) :- write(siedemnascie).
kilkanascie(8) :- write(osiemnascie).
kilkanascie(9) :- write(dziewietnascie).

% numbers divisible by 10
pelne_dziesiatki(2) :- write(dwadziescia).
pelne_dziesiatki(3) :- write(trzydziesci).
pelne_dziesiatki(4) :- write(czterdziesci).
pelne_dziesiatki(5) :- write(piecdziesiat).
pelne_dziesiatki(6) :- write(szescdziesiat).
pelne_dziesiatki(7) :- write(siedemdziesiat).
pelne_dziesiatki(8) :- write(osiemdziesiat).
pelne_dziesiatki(9) :- write(dziewiecdziesiat).


% zlaczenie dwoch liczb

% jesli mamy w dziesiatkach 0, to wypisujemy tylko jednosc
wypisz_2cyfrowe([0, C]) :-
    !, 
    jednosci(C).

% jesli mamy w dziesiatkach 1, to wypisujemy jedna z liczb 11-19
wypisz_2cyfrowe([1, C]) :-
    !, 
    kilkanascie(C).

% jesli wsrod jednosci mamy 0, to wypisujemy same dziesiatki
wypisz_2cyfrowe([B, 0]) :-
    !, 
    pelne_dziesiatki(B).

% kazdy inny przypadek to wypisanie dziesiatek + jednosci
wypisz_2cyfrowe([B, C]) :-
    pelne_dziesiatki(B), 
    write(' '), 
    jednosci(C).


% zlaczenie 3 liczb

% analogicznie jak wyzej
% jak same zera to nic nie wypisujesz
wypisz_3cyfrowe([0, 0, 0]).

% jak zero + 2 jakiekolwiek liczby to zero opuszczamy i wypisujemy te 2 liczby
wypisz_3cyfrowe([0, B, C]) :-
    !, 
    wypisz_2cyfrowe([B, C]).

wypisz_3cyfrowe([1, 0, 0]) :-
    !, 
    write('sto').
wypisz_3cyfrowe([1, B, C]) :-
    !, 
    write('sto '), 
    wypisz_2cyfrowe([B, C]).

wypisz_3cyfrowe([2, 0, 0]) :-
    !, 
    write(' dwiescie').
wypisz_3cyfrowe([2, B, C]) :-
    !, 
    write(' dwiescie '), 
    wypisz_2cyfrowe([B, C]).

% jesli mamy 300 lub 400 to wpisujemy cyfre + "sta"
wypisz_3cyfrowe([A, 0, 0]) :-
    A > 2, 
    A < 5, 
    !, 
    jednosci(A), 
    write('sta').
wypisz_3cyfrowe([A, B, C]) :-
    A > 2, 
    A < 5, 
    !, 
    jednosci(A), 
    write('sta '), 
    wypisz_2cyfrowe([B, C]).

% jesli mamy 500 + to wpisujemy cyfre + "set"
wypisz_3cyfrowe([A, 0, 0]) :-
    A > 4, 
    !, 
    jednosci(A), 
    write('set').
wypisz_3cyfrowe([A, B, C]) :-
    A > 4, 
    !, 
    jednosci(A), 
    write('set '), 
    wypisz_2cyfrowe([B, C]).



% zlaczenie 4 liczb

% jesli mamy jeden tysiac to po prostu piszemy tysiac
wypisz_4cyfrowe([1, A, B, C]) :-
    !,
    write('tysiac '),
    wypisz_3cyfrowe([A, B, C]).

% jesli mamy 2,3 lub 4 to piszemy liczbe + "tysiace"
wypisz_4cyfrowe([A, B, C, D]) :-
    A > 1, 
    A < 5, 
    !, 
    jednosci(A), 
    write(' tysiace '), 
    wypisz_3cyfrowe([B, C, D]).

% jesli mamy 5+ to piszemy cyfre + "tysiecy"
wypisz_4cyfrowe([A, B, C, D]) :-
    A > 4, 
    jednosci(A), 
    write(' tysiecy '), 
    wypisz_3cyfrowe([B, C, D]).

% teraz trzeba stwierdzic, jak wielka liczbe mamy. wywolujemy to jako wypisz(Liczba)
% np. wypisz(1234). Program sprowadza to do tablicy 4-elementowej od konca
% (niezaleznie od wielkosci liczby, czyli 1234 -> [4,3,2,1], 123 - [3,2,1,0], 1 -> [1,0,0,0])
% za pomoca predykatu transform/3, potem robimy reverse/2 ktore obraca nam liste.
% teraz musimy okreslic, jak wielka jest liczba - w sensie ile miejsc zawiera.
% ile_zer/2 liczy zera przed pierwsza liczba niezerowa, czyli:
% [0,0,1,0] -> 2 zera
% [0,0,0,0] -> 4 zera
% [1,2,3,4] -> 0 zer
% ta wartosc jest zapisana pod N. Teraz wykorzystujemy trim/3, ktory ucina nam te zera
% i na podstawie N wysylamy te tablice do predykatu obslugujacego odpowiednia dlugosc
% liczby.
wypisz(X) :-
    transform(X, 4, L),
    reverse(L, D),
    ile_zer(D, N),
    trim(D, N, List),
    (
        N = 0 -> wypisz_4cyfrowe(List);
        N = 1 -> wypisz_3cyfrowe(List);
        N = 2 -> wypisz_2cyfrowe(List);
        N = 3 -> jednosci(List);
        N = 4 -> write(zero)
    ).

trim([], 0, []).
trim([H|T], 0, [H|T]).
trim([_|T], N, R) :- 
    N > 0,
    N1 is N-1, 
    trim(T, N1, R).

transform(_, 0, []) :- !.
transform(X, N, L) :-
    Q is X // 10,
    R is X mod 10,
    N1 is N - 1,
    transform(Q, N1, L1),
    L = [R|L1].

ile_zer([],0).
ile_zer([H|_], N):-
    not(H=0),
    ile_zer([],N).
ile_zer([H|Tail], N) :-
    H = 0,
    ile_zer(Tail, N1),
    (  
        H = 0 -> N is N1 + 1;  
        N = N1
    ).