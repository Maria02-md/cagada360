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


val_sat_list_form(F,S,V):-enesimo(N,S,F),enesimo(N,F,V).
val_sat_list_form(F,S,V):- valor_log(F,S,V,1).


val_sat_list_form2([],S,V).
val_sat_list_form2([F|T],S,V):-val_sat_list_form(F,S,V),val_sat_list_form2(T,S,V).




