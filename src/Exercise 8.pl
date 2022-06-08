% ex 8.1 - gcd/3, 8.2 - replace/4

gcd(N1, 0, N1) :- !.
gcd(N1, N2, Divider) :-
   Temp is N1 mod N2,
   gcd(N2, Temp, Divider).
 
replace([], _, _, []).
replace([OldNum|T], OldNum, N, [N|T2]) :-
    replace(T, OldNum, N, T2).
replace([H|T], OldNum, N, [H|T2]) :-
    H \= OldNum,
    replace(T, OldNum, N, T2).