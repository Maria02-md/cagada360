/*Exercicio 1:*/

/*L¬,∧,∨,→*/

:-op(100, fy, 'neg').
:-op(200, xfy,'e').
:-op(300, xfy,'ou').
:-op(400, xfy,'imp').

/*tem o valor verdadeiro se N ´e
um n´umero natural (positivo) e X ´e o elemento que est´a na posi¸c˜ao
N da lista L*/
enesimo(1,[X|L],X).
enesimo(N,[X|L],Y):-enesimo(N1,L,Y), N is N1+1.

/*F- Formula de L¬,∧,∨,→*
  X-simbolo proposicional
  S-lista de simbolos proposicionais
  L-lista de 0's e 1's
  O calc_valor serve para obter as valorações da formula F
*/
calc_valor(F,S,L,V):-enesimo(N,S,F),enesimo(N,L,V).
calc_valor(neg X,S,L,0):-calc_valor(X,S,L,1).
calc_valor(neg X,S,L,1):-calc_valor(X,S,L,0).
calc_valor(X imp Y,S,L,0):-calc_valor(X,S,L,1),calc_valor(Y,S,L,0).
calc_valor(X imp Y,S,L,1):-calc_valor(X,S,L,0).
calc_valor(X imp Y,S,L,1):-calc_valor(Y,S,L,1).
calc_valor(X e Y,S,L,1):-calc_valor(X,S,L,1),calc_valor(Y,S,L,1).
calc_valor(X e Y,S,L,0):-calc_valor(X,S,L,0).
calc_valor(X e Y,S,L,0):-calc_valor(Y,S,L,0).
calc_valor(X ou Y,S,L,1):-calc_valor(X,S,L,1).
calc_valor(X ou Y,S,L,1):-calc_valor(Y,S,L,1).
calc_valor(X ou Y,S,L,0):-calc_valor(X,S,L,0),calc_valor(Y,S,L,0).

concatena([],L,L).
concatena([X|R],L,[X|S]):-concatena(R,L,S).

literal(F):-simb_prop(F).
literal(neg F):- simb_prop(F).

simb_prop(F):-not(F= neg X), not(F = X e Y), not(F= X ou Y),not(F=X imp Y).
simb_prop(neg A, A):- literal(neg A).

simb_prop(A e B, [A|B],L3,L4):- simb_prop(A),simb_prop(B),concatena([A|B],L3,L4).
simb_prop(A e B, [B|S]):- not(simb_prop(A)),simb_prop(B),simb_prop(A,[B|S]).
simb_prop(A e B, [A|S]):- simb_prop(A),not(simb_prop(B)),simb_prop(B,[A|S]).
simb_prop(A e B, S):- not(simb_prop(A)),not(simb_prop(B)),simb_prop(A,S),simb_prop(B,S).

simb_prop(A imp B, [A|B]):-simb_prop(A),simb_prop(B).
simb_prop(A imp B, [B|S]):- not(simb_prop(A)),simb_prop(B),simb_prop(A,[B|S]).
simb_prop(A imp B, [A|S]):- simb_prop(A),not(simb_prop(B)),simb_prop(B,[A|S]).
simb_prop(A imp B, S):- not(simb_prop(A)),not(simb_prop(B)),simb_prop(A,S),simb_prop(B,S).

simb_prop(A ou B, [A|B]):-simb_prop(A),simb_prop(B).
simb_prop(A ou B, [B|S]):- not(simb_prop(A)),simb_prop(B),simb_prop(A,[B|S]).
simb_prop(A ou B, [A|S]):- simb_prop(A),not(simb_prop(B)),simb_prop(B,[A|S]).
simb_prop(A ou B, S):- not(simb_prop(A)),not(simb_prop(B)),simb_prop(A,S),simb_prop(B,S).



exercicio1([F|R],L2):-
