:- use_module(library(clpfd)).

blocks([], []).
blocks(([Ns1, Ns2, Ns3|Ns4]), Y) :-
    transpose([Ns1, Ns2, Ns3], X),
    block_part(X, Y1),
    blocks(Ns4, Y2),
	append([Y1, Y2], Y).

block_part([], []).
block_part(([Ns1, Ns2, Ns3|Ns4]), X) :-
    block_part(Ns4, Y),
    append([Ns1, Ns2, Ns3], Z),
    append([Y, [Z]], X).

is_soduko(Grid) :-
    transpose(Grid,Y),
    append(Grid, FlatGrid),
    FlatGrid ins 1..9,
    blocks(Grid, Blocks),
    maplist(all_distinct, Grid),
    maplist(all_distinct, Y),
    maplist(all_distinct, Blocks),
    labeling([], FlatGrid).
