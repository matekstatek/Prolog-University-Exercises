% ex 1

fib(0, [0]).
fib(1, [0,1]).
fib(N, Result) :-
   N > 1,
   fib_(N, Numbers, 1, [1,0]),
   reverse(Numbers, Result).

fib_(N, Numbers, N, Numbers) :- 
    !.

fib_(N, Numbers, N0, [H1,H2|Fs]) :-
   N > N0,
   N1 is N0 + 1,
   NewH is H2 + H1,
   fib_(N, Numbers, N1, [NewH, H1, H2|Fs]).

% ex 2

del([H|T], N, [H|T2]) :- 
    N1 is N - 1,
    del(T, N1, T2).

del([_|T], 1, T).