% 9.1 - matches/3, 9.2 - logic_product/3

matches([X], [Y], Res):-
    X \= Y,
    Res is 1.
    
matches([], [], Res):-
    Res is 0.
    
matches(L, L, Res):-
    Res is 0.
    
matches([H|T], [H2|T2], Res):-
    H \= H2,
    matches(T,T2,Res1),
    Res is Res1 + 1.
    
matches([H|T], [H|T2], Res):-
    matches(T,T2,Res).
 
 
logic_product([],[],[]).
logic_product([X],[X],[1]).
logic_product([X],[Y],[R]):-
    X \= Y,
    R is 0.
logic_product([H|T1], [H|T2], [Hr|Tr]):-
    Hr is 1,
    logic_product(T1,T2,Tr).
logic_product([H1|T1], [H2|T2], [Hr|Tr]):-
    H1 \= H2,
    Hr is 0,
    logic_product(T1,T2,Tr).