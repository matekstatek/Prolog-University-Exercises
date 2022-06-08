% run it with e.g. "start(20)."
sum_digits(X, Sum):-
    A is X mod 10,
    X1 is floor(X / 10),
    B is X1 mod 10,
    X2 is floor(X1 / 10),
    C is X2 mod 10,
    X3 is floor(X2 / 10),
    D is X3 mod 10,
    X4 is floor(X3 / 10),
    E is X4 mod 10,
    Sum is A + B + C + D + E.

num_to_list(N,[L]):-
   N < 10,
   L is N,
   !.
num_to_list(N,L):-
   P is N // 10,
   num_to_list(P,L1),
   END is (N mod 10), 
   append(L1,[END] ,L).

numbers(_, 99999).
numbers(L, X):-
    X < 100000,
    sum_digits(X, Sum),  
   	L =:= Sum, !,
    num_to_list(X, List),
    write(List), nl,
    X1 is X + 1,
    numbers(L, X1).

numbers(L, X):-
    X < 100000,
    X1 is X + 1,
    numbers(L, X1).

start(45):-
    num_to_list(99999, L),
    write(L).
start(L):-
    X is 10000,
    numbers(L,X).