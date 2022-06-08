% run it with: resolve(S,E,N,D,M,O,R,Y).
resolve(S,E,N,D,M,O,R,Y) :-
        numbers([S,E,N,D,M,O,R,Y], [0,1,2,3,4,5,6,7,8,9]),
        M > 0, 
        S > 0,
        (   
        1000 * S + 100 * E + 10 * N + D + 
        1000 * M + 100 * O + 10 * R + E =:=
        10000 * M + 1000 * O + 100 * N + 10 * E + Y
        ).

select(X, [X|T], T).
select(X, [H|T1], [H|T2]):- 
    	select(X, T1, T2).

numbers([], _).
numbers([H|T], L):-
        select(H, L, NewL),
        numbers(T, NewL).