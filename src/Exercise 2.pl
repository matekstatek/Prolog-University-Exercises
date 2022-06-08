% move(-1, [a,b,c,d], L). <- w lewo
% move(1, [a,b,c,d], L). <- w prawo
 
% 1
rotate(right, L, [T|H]) :-
    append(H, [T], L).
rotate(left, [H|T], L) :-
    append(T, [H], L).
 
move(0, L, L) :- !.
move(N, L1, L2) :-
  N < 0,
  rotate(right, L1, L),
  N1 is N+1,
  move(N1, L, L2).
move(N, L1, L2) :-
  N > 0,
  rotate(left, L1, L),
  N1 is N-1,
  move(N1, L, L2).

% 2
remove_it([X|T], N, [X|T2]) :-
    N1 is N - 1,
    remove_it(T, N1, T2).
remove_it([_|T], 1, T).