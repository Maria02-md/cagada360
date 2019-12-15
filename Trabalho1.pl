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

membro(X, [X | _]).
membro(X, [_ | C]):-membro(X, C).

el_rep([],[]).
el_rep([X|R],[X|S]):-not(membro(X,R)),el_rep(R,S).
el_rep([X|R],S):-membro(X,R),el_rep(R,S).

lista_s1([X1],[X1]):-simb_prop(X1).
lista_s1([neg X1],[X1]):-simb_prop(X1).
lista_s1([neg X1],E):-not(simb_prop(X1)),lista_s1([X1],L),el_rep(L,E).


lista_s1([X1 e X2],E):-simb_prop(X1),simb_prop(X2),el_rep([X1,X2],E).
lista_s1([X1 e X2],E):-not(simb_prop(X1)),simb_prop(X2),lista_s1([X1],S),concatena([X2],S,L),el_rep(L,E).
lista_s1([X1 e X2],E):-not(simb_prop(X2)),simb_prop(X1),lista_s1([X2],S),concatena([X1],S,L),el_rep(L,E).
lista_s1([X1 e X2],E):-not(simb_prop(X1)),not(simb_prop(X2)),lista_s1([X1],S),lista_s1([X2],R),concatena(S,R,L),el_rep(L,E).


lista_s1([X1 ou X2],E):-simb_prop(X1),simb_prop(X2),el_rep([X1,X2],E).
lista_s1([X1 ou X2],E):-not(simb_prop(X1)),simb_prop(X2),lista_s1([X1],S),concatena(S,[X2],L),el_rep(L,E).
lista_s1([X1 ou X2],E):-not(simb_prop(X2)),simb_prop(X1),lista_s1([X2],S),lista_s1([X1],R),concatena(R,S,L),el_rep(L,E).
lista_s1([X1 ou X2],E):-not(simb_prop(X1)),not(simb_prop(X2)),lista_s1([X1],S),lista_s1([X2],R),concatena(S,R,L),el_rep(L,E).


lista_s1([X1 imp X2],E):-simb_prop(X1),simb_prop(X2),el_rep([X1,X2],E).
lista_s1([X1 imp X2],E):-not(simb_prop(X1)),simb_prop(X2),lista_s1([X1],S),concatena(S,[X2],L),el_rep(L,E).
lista_s1([X1 imp X2],E):-not(simb_prop(X2)),simb_prop(X1),lista_s1([X2],S),lista_s1([X1],R),concatena(R,S,L),el_rep(L,E).
lista_s1([X1 imp X2],E):-not(simb_prop(X1)),not(simb_prop(X2)),lista_s1([X1],S),lista_s1([X2],R),concatena(S,R,L),el_rep(L,E).


lista_s1([X1|F],E):-simb_prop(X1),lista_s1(F,L2),concatena([X1],L2,L),el_rep(L,E).
lista_s1([neg X1|F],E):-simb_prop(X1),lista_s1(F,L2),concatena([X1],L2,L),el_rep(L,E).
lista_s1([neg X1|F],E):-not(simb_prop(X1)),lista_s1([X1],S),lista_s1(F,L2),concatena(S,L2,L),el_rep(L,E).

lista_s1([X1 e X2|F],E):-simb_prop(X1),simb_prop(X2),lista_s1(F,L2),concatena([X1,X2],L2,L),el_rep(L,E).
lista_s1([X1 e X2|F],E):-not(simb_prop(X1)),simb_prop(X2),lista_s1([X1],S),concatena(S,[X2],L2),lista_s1(F,L3),concatena(L2,L3,L),el_rep(L,E).
lista_s1([X1 e X2|F],E):-not(simb_prop(X2)),simb_prop(X1),lista_s1([X2],S),concatena(S,[X1],L2),lista_s1(F,L3),concatena(L2,L3,L),el_rep(L,E).
lista_s1([X1 e X2|F],E):-not(simb_prop(X1)),not(simb_prop(X2)),lista_s1([X1],S),lista_s1([X2],R),concatena(S,R,L2),lista_s1(F,L3),concatena(L2,L3,L),el_rep(L,E).

lista_s1([X1 ou X2|F],E):-simb_prop(X1),simb_prop(X2),lista_s1(F,L2),concatena([X1,X2],L2,L),el_rep(L,E).
lista_s1([X1 ou X2|F],E):-not(simb_prop(X1)),simb_prop(X2),lista_s1([X1],S),concatena(S,[X2],L2),lista_s1(F,L3),concatena(L2,L3,L),el_rep(L,E).
lista_s1([X1 ou X2|F],E):-not(simb_prop(X2)),simb_prop(X1),lista_s1([X2],S),concatena(S,[X1],L2),lista_s1(F,L3),concatena(L2,L3,L),el_rep(L,E).
lista_s1([X1 ou  X2|F],E):-not(simb_prop(X1)),not(simb_prop(X2)),lista_s1([X1],S),lista_s1([X2],R),concatena(S,R,L2),lista_s1(F,L3),concatena(L2,L3,L),el_rep(L,E).


lista_s1([X1 imp X2|F],E):-simb_prop(X1),simb_prop(X2),lista_s1(F,L2),concatena([X1,X2],L2,L),el_rep(L,E).
lista_s1([X1 imp X2|F],E):-not(simb_prop(X1)),simb_prop(X2),lista_s1([X1],S),concatena(S,[X2],L2),lista_s1(F,L3),concatena(L2,L3,L),el_rep(L,E).
lista_s1([X1 imp  X2|F],E):-not(simb_prop(X2)),simb_prop(X1),lista_s1([X2],S),concatena([X1],S,L2),lista_s1(F,L3),concatena(L2,L3,L),el_rep(L,E).
lista_s1([X1 imp  X2|F],E):-not(simb_prop(X1)),not(simb_prop(X2)),lista_s1([X1],S),lista_s1([X2],R),concatena(S,R,L2),lista_s1(F,L3),concatena(L2,L3,L),el_rep(L,E).


/*tem o valor verdadeiro se N é
um número natural (positivo) e X é o elemento que está na posiç˜ao
N da lista L*/
enesimo(1,[X|L],X).
enesimo(N,[X|L],Y):-enesimo(N1,L,Y), N is N1+1.

/*i*/
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

/*ii*/
val_sat_list_form(F,S,V):- valor_log(F,S,V,1).
val_sat_list_form2([],S,V).
val_sat_list_form2([F|T],S,V):-val_sat_list_form(F,S,V),val_sat_list_form2(T,S,V).

/*iii*/
/*Acrescentar uma lista, V (de valorações) á lista L*/
acrescenta([],[],[]).
acrescenta([],[X1|R],[X1|S]):-acrescenta([],R,S).
acrescenta([X1|R],L,[X1|S]):-acrescenta(R,L,S).

elimina([],R).
elimina([X1|R],R).

/*tem lista de formulas e une-as com e*/
junta_form([X|[]],X).
junta_form([R|L],S):-junta_form(L,P), S= R e P.

/*programa que permita obter, para um qualquer
n´umero inteiro n˜ao negativo N dado, uma lista formada por todas as
listas de comprimento N que s˜ao compostas apenas por zeros e uns.*/
lista_n_0s_e_1s(0,[]). /* Dado um inteiro não negativo N, esta função tem um valor verdadeiro se e so se L for uma lista de comprimento N composta apenas por 0 e por 1.*/
lista_n_0s_e_1s(N,[0|R]):-N>0, N1 is N-1, lista_n_0s_e_1s(N1,R).
lista_n_0s_e_1s(N,[1|R]):-N>0, N1 is N-1, lista_n_0s_e_1s(N1,R).

todas_listas_n_0s_e_1s(N,T):-findall(L,lista_n_0s_e_1s(N,L),T). /*Sendo N um numero inteiro não negativo o output é uma lista de listas com comprimento N que são compostas apenas por 0s e 1s.*/

/*Dá o comprimento de uma lista l*/
comprimento([],0).
comprimento([_|X],N):-comprimento(X,N1),N is N1+1.

/*Dá todas as valorações possíveis para uma determinada lista de simbolos proposicionais, de acordo com o seu tamanho*/
lista_val([X|Y],T):-comprimento([X|Y],N),todas_listas_n_0s_e_1s(N,T).

/*Recebe a lista de todas as valorações, a formula, a lista de simbolos proposicionais e retorna a lista com as valorações que satisfazer a formula*/
aux_lista_val_12([],F,S,[]).
aux_lista_val_12([X1|L],F,S,[X1|L2]):-valor_log(F,S,X1,1),aux_lista_val_12(L,F,S,L2).
aux_lista_val_12([X1|L],F,S,L2):-not(valor_log(F,S,X1,1)),aux_lista_val_12(L,F,S,L2).

elimina_listas2(H,S):-H=[P|T], S=[P|T].
elimina_listas([L|T],H):-L=[R|S], H=[R|S], elimina_listas2(H,P).

/*Serve para que se possa gerar a lista com todas as valorações possíveis sendo que retorna as que verificam*/

lista_val_1(F,S,V):-lista_val(S,T),aux_lista_val_12(T,F,S,V).

lista_val_12(F,S,L):-findall(V,lista_val_1(F,S,V),N),el_rep(N,L).

final([]).
final(L):-lista_s1(L,S),junta_form(L,F),lista_val_12(F,S,M),elimina_listas(M,R),write(S),nl,write(R).



