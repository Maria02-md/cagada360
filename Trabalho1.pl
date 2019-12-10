:-op(100, fy, 'neg').
:-op(200, xfy, 'e').
:-op(300, xfy, 'ou').
:-op(400, xfy, 'imp').

/*NOTAS
{p, p → q, q} é representado da seguinte forma: [p, p imp q, q].
SIMBOLO PROPOSICIONAL: p,q, ou seja, são simvolos simples
LITERAL: ~q, q, ou seja, é o simbolo proposicional ou a negação desse
         simbolo.
*/


:-op(100, fy, 'neg').
:-op(200, xfy, 'e').
:-op(300, xfy, 'ou').
:-op(400, xfy, 'imp').

/*NOTAS
{p, p → q, q} é representado da seguinte forma: [p, p imp q, q].
SIMBOLO PROPOSICIONAL: p,q, ou seja, são simvolos simples
LITERAL: ~q, q, ou seja, é o simbolo proposicional ou a negação desse
         simbolo.
*/


/*Execicio1:
   F-formula de L¬,∧,∨,→
   X-simbolo proposicional
   S-lista de simbolos proposicionais
   L-lista de 0's e 1's
   V-valoração da fomula
*/




simb_prop(P):- not(P = neg  X),not(P = X  e  Y), not(P = X ou Y), not(P = X imp Y).
literal( X ):- simb_prop(X) .
literal( neg X ):- simb_prop(X) .
implicações( X  imp  Y ):- literal(X),literal(Y).
conj(X e Y):-literal(X),literal(Y).
disj(X ou Y):-literal(X),literal(Y).

concatena([],L,L).
concatena([X|R],L,[X|S]):-concatena(R,L,S).

el_rep([],[]).
el_rep([X|R],[X|S]):-not(membro(X,R)),el_rep(R,S).
el_rep([X|R],S):-membro(X,R),el_rep(R,S).

lista_s1([X1],[X1]):-simb_prop(X1).
lista_s1([neg X1],[X1]):-simb_prop(X1).
lista_s1([neg X1],L):-not(simb_prop(X1)),lista_s1([X1],L).


lista_s1([X1 e X2],[X1,X2]):-simb_prop(X1),simb_prop(X2).
lista_s1([X1 e X2],L):-not(simb_prop(X1)),simb_prop(X2),lista_s1([X1],S),concatena([X2],S,L).
lista_s1([X1 e X2],L):-not(simb_prop(X2)),simb_prop(X1),lista_s1([X2],S),concatena([X1],S,L).
lista_s1([X1 e X2],L):-not(simb_prop(X1)),not(simb_prop(X2)),lista_s1([X1],S),lista_s1([X2],R),concatena(S,R,L).


lista_s1([X1 ou X2],[X1,X2]):-simb_prop(X1),simb_prop(X2).
lista_s1([X1 ou X2],L):-not(simb_prop(X1)),simb_prop(X2),lista_s1([X1],S),concatena(S,[X2],L).
lista_s1([X1 ou X2],L):-not(simb_prop(X2)),simb_prop(X1),lista_s1([X2],S),lista_s1([X1],R),concatena(R,S,L).
lista_s1([X1 ou X2],L):-not(simb_prop(X1)),not(simb_prop(X2)),lista_s1([X1],S),lista_s1([X2],R),concatena(S,R,L).

lista_s1([X1 imp X2],[X1,X2]):-simb_prop(X1),simb_prop(X2).
lista_s1([X1 imp X2],L):-not(simb_prop(X1)),simb_prop(X2),lista_s1([X1],S),concatena(S,[X2],L).
lista_s1([X1 imp X2],L):-not(simb_prop(X2)),simb_prop(X1),lista_s1([X2],S),lista_s1([X1],R),concatena(R,S,L).
lista_s1([X1 imp X2],L):-not(simb_prop(X1)),not(simb_prop(X2)),lista_s1([X1],S),lista_s1([X2],R),concatena(R,S,L).


lista_s1([X1|F],L):-simb_prop(X1),lista_s1(F,L2),concatena([X1],L2,L).
lista_s1([neg X1|F],L):-simb_prop(X1),lista_s1(F,L2),concatena([X1],L2,L).
lista_s1([neg X1|F],L):-not(simb_prop(X1)),lista_s1([X1],S),lista_s1(F,L2),concatena(S,L2,L).

lista_s1([X1 e X2|F],L):-simb_prop(X1),simb_prop(X2),lista_s1(F,L2),concatena([X1,X2],L2,L).
lista_s1([X1 e X2|F],L):-not(simb_prop(X1)),simb_prop(X2),lista_s1([X1],S),concatena(S,[X2],L2),lista_s1(F,L3),concatena(L2,L3,L).
lista_s1([X1 e X2|F],L):-not(simb_prop(X2)),simb_prop(X1),lista_s1([X2],S),concatena(S,[X1],L2),lista_s1(F,L3),concatena(L2,L3,L).
lista_s1([X1 e X2|F],L):-not(simb_prop(X1)),not(simb_prop(X2)),lista_s1([X1],S),lista_s1([X2],R),concatena(S,R,L2),lista_s1(F,L3),concatena(L2,L3,L).

lista_s1([X1 ou X2|F],L):-simb_prop(X1),simb_prop(X2),lista_s1(F,L2),concatena([X1,X2],L2,L).
lista_s1([X1 ou X2|F],L):-not(simb_prop(X1)),simb_prop(X2),lista_s1([X1],S),concatena(S,[X2],L2),lista_s1(F,L3),concatena(L2,L3,L).
lista_s1([X1 ou X2|F],L):-not(simb_prop(X2)),simb_prop(X1),lista_s1([X2],S),concatena(S,[X1],L2),lista_s1(F,L3),concatena(L2,L3,L).
lista_s1([X1 ou  X2|F],L):-not(simb_prop(X1)),not(simb_prop(X2)),lista_s1([X1],S),lista_s1([X2],R),concatena(S,R,L2),lista_s1(F,L3),concatena(L2,L3,L).


lista_s1([X1 imp X2|F],L):-simb_prop(X1),simb_prop(X2),lista_s1(F,L2),concatena([X1,X2],L2,L).
lista_s1([X1 imp X2|F],L):-not(simb_prop(X1)),simb_prop(X2),lista_s1([X1],S),concatena(S,[X2],L2),lista_s1(F,L3),concatena(L2,L3,L).
lista_s1([X1 imp  X2|F],L):-not(simb_prop(X2)),simb_prop(X1),lista_s1([X2],S),concatena([X1],S,L2),lista_s1(F,L3),concatena(L2,L3,L).
lista_s1([X1 imp  X2|F],L):-not(simb_prop(X1)),not(simb_prop(X2)),lista_s1([X1],S),lista_s1([X2],R),concatena(S,R,L2),lista_s1(F,L3),concatena(L2,L3,L).


/*tem o valor verdadeiro se N é
um número natural (positivo) e X é o elemento que está na posiç˜ao
N da lista L*/
enesimo(1,[X|L],X).
enesimo(N,[X|L],Y):-enesimo(N1,L,Y), N is N1+1.


valor_log(F,S,L,V):-enesimo(N,S,F),enesimo(N,L,V). /*Se F é o elemento que esta na posição N da lista S, então o valor lógico de F é o valor que esta na posição N da lista L*/
valor_log(neg X,S,L,0):-valor_log(X,S,L,1).
valor_log(neg X,S,L,1):-valor_log(X,S,L,0).
valor_log(X imp Y,S,L,0):-valor_log(X,S,L,1),valor_log(Y,S,L,0).
valor_log(X imp Y,S,L,1):-valor_log(X,S,L,0).
valor_log(X imp Y,S,L,1):-valor_log(Y,S,L,1).
valor_log(X e Y,S,L,1):-valor_log(X,S,L,1),valor_log(Y,S,L,1).
valor_log(X e Y,S,L,0):-valor_log(X,S,L,0).
valor_log(X e Y,S,L,0):-valor_log(Y,S,L,0).
valor_log(X ou Y,S,L,1):-valor_log(X,S,L,1).
valor_log(X ou Y,S,L,1):-valor_log(Y,S,L,1).
valor_log(X ou Y,S,L,0):-valor_log(X,S,L,0),valor_log(Y,S,L,0).


/*val_sat_list_form(F,S,V):-enesimo(N,S,F),enesimo(N,F,V).ACABEI DE REPARAR QUE ESTA LINHA DE CODIGO NÃO ESTA AQUI A FAZER NADA*/
val_sat_list_form(F,S,V):- valor_log(F,S,V,1).
val_sat_list_form2([],S,V).
val_sat_list_form2([F|T],S,V):-val_sat_list_form(F,S,V),val_sat_list_form2(T,S,V).




/*
list_vals_sat_list_form([F],S,R):-val_sat_list_form(F,S,R),write(R).
list_vals_sat_list_form2([F|T],S,R):-val_sat_list_form(F,S,R),list_vals_sat_list_form2(T,S,R).
*/

















