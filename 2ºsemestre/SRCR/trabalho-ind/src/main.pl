/**/
%-------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI
%
% André Morais - A83899

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- include("paragens.pl").
:- include("arcos.pl").


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ). % definição de um invariante
:- dynamic paragem/11. % (Gid,Latitude,Longitude,Estado de Conservaçao, TipoAbrigo,AbrigoComPublicidade,Operadora,Carreira,CodigoRua,NomeRua,Freguesia)

%--------------------------------- - - - - - - - - - -  -  Solucoes
% Termo, Predicado, Lista -> {V,F}
solucoes(T,Q,S) :- findall(T,Q,S).

%--------------------------------- - - - - - - - - - -  -
% Predicado nao
nao(Questao) :-
    Questao,!,fail.
nao(_).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicado comprimento
comprimento(S,N) :-
    length(S,N).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicado que da print
escrever([]).
escrever([X|T]) :-
    write(X),
    nl ,
    escrever(T).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicado que adiciona a uma lista
add(X, [], [X]).
add(X, [Y | T], [X,Y | T]) :- X @< Y, !.
add(X, [Y | T1], [Y | T2]) :- add(X, T1, T2).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Alguns predicados

% Devolve todas as paragens
paragens(S) :- solucoes((Gid,Latitude,Longitude,EC,TA,AP,O,C,CodigoRua,NomeRua,Freguesia),paragem(Gid,Latitude,Longitude,EC,TA,AP,O,C,CodigoRua,NomeRua,Freguesia),S).

% Devolve os primeiros X elementos de uma lista
firstn(0,_).
firstn(_,[]).
firstn(X,[H|T]) :-
    X>0,
    write(H),
    nl,
    firstn(X-1,T).

%  Devolve as primeiras X paragens
nrparagens(X,S) :-
    paragens(S),
    firstn(X,S).

% Imprime a carreira do arco Origem
carreira(C,S) :-
    solucoes((O),arco(O,_,_,C),S),
    write(S).

%----------------------------------------------------------------%
%                        NÃO INFORMADA                           %
%----------------------------------------------------------------%

%-------------------------DEPTH FIRST-------------------------

%--------------------------QUERIE 1--------------------------
% Calcular um maior entre dois pontos

% Função adaptada da Ficha11 dada pelo Professor


trajeto(Origem,Destino, [Origem|Caminho], Dist,Carreira) :-                             % funçao principal
    trajetoAux(Origem, Destino,Caminho, Dist,Carreira,[]).                              % Lista de Visitados inicialmente Vazio

trajetoAux(Destino,Destino, [], 0, [],_).                                               % caso de paragem,para quando acontece o "redo"
trajetoAux(Origem,Destino ,[Prox|Caminho], Dist, Carreira,Visitados) :-
    Origem \== Destino,                                                                 % se Origem diferente de Destino
    adjacente(Origem, Prox, Dist1, Carreira1),                                          % procura o arco adjacente
    nao(member(Prox,Visitados)),                                                        % verifica que o Proximo nao está na lista de Visitados
    trajetoAux(Prox, Destino, Caminho, Dist2, Carreira2,[Origem|Visitados]),
    Dist is Dist1 + Dist2,                                                              % somar as distancias
    append([Carreira1],Carreira2, Carreira).                                            % adicionar a cabeça da lista da carreira, pois esta é inserida de tras para a frente

adjacente(Origem, Prox, Dist,Carreira) :-                                               % vai buscar o arco
    arco(Origem,Prox, Dist,Carreira).                                                   % Procura o arco Origem,Destino


todos(Origem,Destino,L):-
    findall((S,Dist,Car),trajeto(Origem,Destino,S,Dist,Car),L),                         % imprime todos
    escrever(L).

% Exemplo todos(21,23,L).


%----------------------------------QUERIE 2-----------------------------------------
% Selecionar apenas algumas das operadoras de transporte para um determinado percurso

operadora(Origem, Dest , [Origem|Caminho], [Operadora],Dist, Carreira) :-
    operadoraProx(Origem, Dest, Caminho, [Operadora], Dist, Carreira, []).

operadoraProx(Dest, Dest, [], _ , 0 , [], _).
operadoraProx(Origem, Dest, [Prox|Caminho], Operadora, Dist, Carreira, Visitados) :-
    Origem \== Dest,                                                                     % se Origem diferente de Destino
    getPara(Origem,Prox,Operadora1,Dist1,Carreira1),                                        % Procura arco adjacente
    nao(member(Prox,Visitados)),                                                            % Verifica que o proximo nao esta na lista de Visitados
    member(Operadora1,Operadora),                                                           % Verificar se a operadora da paragem Prox corresponde as Operadoras dadas como inputs
    operadoraProx(Prox, Dest, Caminho, Operadora , Dist2, Carreira2,[Origem | Visitados]),
    Dist is Dist1 + Dist2,                                                                  % somar as distancias
    append([Carreira1],Carreira2, Carreira).                                                % adicionar a cabeça da lista da carreira, pois esta é inserida de tras para a frente

getPara(Origem,Prox,Operadora,Dist,Carreira):-
    arco(Origem,Prox,Dist,Carreira),                                                        % Procura o arco Origem,Destino
    paragem(Prox,_,_,_,_,_,Operadora,Carreiras,_,_,_),                                      % Procura paragem Prox e guarda a Operadora e as Carreiras
    member(Carreira,Carreiras).                                                             % Verifica se a Carreira do arco pertence as Carreiras da paragem


todosPara(Origem,Destino,[Operadora]):-
    findall((S,Dist,Car),operadora(Origem,Destino,S,[Operadora],Dist,Car),L),
    escrever(L).% print listas

% Exemplo todosPara(21,23,["Carris"]).


%----------------------------------QUERIE 3-----------------------------------------
% Excluir um ou mais operadores de transporte para o percurso


naoOperadora(Origem, Dest , [Origem|Caminho], [Operadora],Dist, Carreira) :-
    naoOperadoraProx(Origem, Dest, Caminho, [Operadora], Dist, Carreira, []).

naoOperadoraProx(Dest, Dest, [], _ , 0 , [], _).                                                   % Quando encontra o objetivo, este continua a preencher de tras para a frente
naoOperadoraProx(Origem, Dest, [Prox|Caminho], Operadora, Dist, Carreira, Visitados) :-
    Origem \== Dest,                                                                               % Se Origem diferente de Destino
    getNaoPara(Origem,Prox,Operadora1,Dist1,Carreira1),                                            % Procura o arco adjacente
    nao(member(Prox,Visitados)),                                                                   % Verifica se o Proximo ja foi visitado
    nao(member(Operadora1,Operadora)),                                                             % Verificar se a operadora da paragem Prox ñ corresponde as Operadoras dadas
    naoOperadoraProx(Prox, Dest, Caminho, Operadora , Dist2, Carreira2,[Origem | Visitados]),
    Dist is Dist1 + Dist2,                                                                         % somar as distancias
    append([Carreira1],Carreira2, Carreira).                                                % adicionar a cabeça da lista da carreira, pois esta é inserida de tras para a frente

getNaoPara(Origem,Prox,Operadora,Dist,Carreira):-
    arco(Origem,Prox,Dist,Carreira),                                                               % Procura o arco Origem,Destino
    paragem(Prox,_,_,_,_,_,Operadora,Carreiras,_,_,_),                                             % Procura paragem Prox e guarda a Operadora e as Carreiras
    nao(member(Carreira,Carreiras)).                                                               % Verifica se a Carreira do arco pertence as Carreiras da paragem


%Função Principal
todosNaoPara(Origem,Destino,[Operadora]):-
    findall((S,Dist,Car),naoOperadora(Origem,Destino,S,[Operadora],Dist,Car),L),
    escrever(L).                                                                                   % print listas

% Exemplo todosNaoPara(21,23,["Carris"]).


%----------------------------------QUERIE 4-----------------------------------------
% Identificar quais as paragens com o maior número de carreiras num determinado percurso


maior(Origem,Destino, [Origem|Caminho], Dist,Carreira, S) :-                                   % funçao principal
    nrCarreiras(Origem,K),
    maiorAux(Origem, Destino,Caminho, Dist,Carreira,[], Maior),                                % Lista de Visitados inicialmente Vazio
    append([K],Maior,S).

maiorAux(Destino,Destino, [], 0, [],_,[]).                                                     % Quando encontra o objetivo, este continua a preencher de tras para a frente
maiorAux(Origem,Destino ,[Prox|Caminho], Dist, Carreira,Visitados,Maior) :-
    Origem \== Destino,                                                                        % se Origem diferente de Destino
    adjacenteCar(Origem, Prox, Dist1, Carreira1,Maior1),
    nao(member(Prox,Visitados)),                                                               % verifica que o Proximo nao está na lista de Visitados
    maiorAux(Prox, Destino, Caminho, Dist2, Carreira2,[Origem|Visitados],Maior2),
    Dist is Dist1 + Dist2,                                                                     % somar as distancias
    append([Carreira1],Carreira2, Carreira),                                                   % adicionar a cabeça da lista da carreira, pois esta é inserida de tras para a frente
    append([Maior1],Maior2,Maior).


nrCarreiras(Gid,(Gid,L)) :-                                                                    % Retorna o tamanho da lista de para carreiras de uma paragem
    paragem(Gid,_,_,_,_,_,_,X,_,_,_),
    comprimento(X,L).

adjacenteCar(Origem, Prox, Dist,Carreira,Maior) :-                                             % Vai verificar o proximo arco
    arco(Origem,Prox, Dist,Carreira),
    nrCarreiras(Prox,Maior).                                                                   % Nr de carreiras da proxima paragem

maiores(Origem,Destino):-
    findall((Maior,Car),maior(Origem,Destino,_,_,Car,Maior),L),                                % imprime todos
    escrever(L).


% Exemplo maiores(21,23).
%
%----------------------------------QUERIE 5-----------------------------------------
% Escolher o menor percurso (usando critério menor número de paragens)


% Imprime o tamanho da lista dos nr de paragens
tamanho([],[]).
tamanho([(H,E)],[((X,H),E)]) :-
    comprimento(H,X).
tamanho([(H,E)|T],[((X,H),E)|S]) :-
    comprimento(H,X),
    tamanho(T,S).


% Imprime o minimo de todas as listas

minimo([((P,_),_)],P).
minimo([((Px,_),_)|L],Py):- minimo(L,Py), Py =< Px.
minimo([((Px,_),_)|L],Px):- minimo(L,Py), Px < Py.


% Faz filter através do filter
filter([],_,[]).
filter([((X,_),_)|T],Min,R) :-
    Min \== X ,
    filter(T,Min,R).
filter([((X,D),E)|T],Min,K) :-
    Min == X,
    filter(T,Min,R),
    append([((X,D),E)],R,K).


%função principal
menorPercurso(Origem,Destino):-
    findall((S,Car),trajeto(Origem,Destino,S,_,Car),L),
    tamanho(L,X),
    minimo(X,M),
    filter(X,M,R),
    escrever(R).


% Exemplo menorPercurso(21,23).

%----------------------------------QUERIE 6-----------------------------------------
% Escolher o percurso mais rápido (usando critério da distância)


% Imprime o minimo de todas as listas
minimo6([(_,Y)],Y) :-
    !,
    true.
minimo6([(_,Y)|Xs], M):-
    minimo6(Xs, M),
    M =< Y.
minimo6([(_,Y)|Xs], Y):-
    minimo6(Xs, M),
    Y <  M.


% Filtra para ver qual é a Menor através do filter
filter6([],_,[]).
filter6([(_,D)|T],Min,R) :-
    Min \== D ,
    filter6(T,Min,R).
filter6([(X,D)|T],Min,K) :-
    Min == D,
    filter6(T,Min,R),
    append([(X,D)],R,K).

%função principal
maisRapido(Origem,Destino):-
    findall((S,Dist),trajeto(Origem,Destino,S,Dist,_),L),
    minimo6(L,Dist),
    filter6(L,Dist,R),
    escrever(R).


% Exemplo maisRapido(21,23).

%----------------------------------QUERIE 7-----------------------------------------
% Escolher o percurso que passe apenas por abrigos com publicidade

publicidade(Origem, Dest , [Origem|Caminho], Publi, Dist, Carreira) :-
    publicidadeProx(Origem, Dest, Caminho, Publi, Dist, Carreira, []).

publicidadeProx(Dest, Dest, [], _ , 0 , [], _).                                                 % Quando encontra o objetivo, este continua a preencher de tras para a frente
publicidadeProx(Origem, Dest, [Prox|Caminho], Publi, Dist, Carreira, Visitados) :-
    Origem \== Dest,
    getPubli(Origem,Prox,Publi1,Dist1,Carreira1),
    nao(member(Prox,Visitados)),                                                                % Verifica se o Prox ja esta nos Visitados
    Publi1 == "Yes",                                                                            % Verificar se a Publicidade é igual a "Yes"
    publicidadeProx(Prox, Dest, Caminho, Publi , Dist2, Carreira2,[Origem | Visitados]),        % recursividade para o resto
    Dist is Dist1 + Dist2,                                                                      % Soma das distancias
    append([Carreira1], Carreira2, Carreira).                                                   % Da Append do Carreira2 na lista Carreira1 e guarda na Lista Carreira

getPubli(Origem,Prox,Publi,Dist,Carreira):-
    arco(Origem,Prox,Dist,Carreira),                                                            % Retorna o arco
    paragem(Prox,_,_,_,_,Publi,_,Carreiras,_,_,_),                                              % Retorna a Publicidade  e as Carreiras da paragem Prox
    member(Carreira,Carreiras).                                                                 % Verifica se a Carreira do arco está na lista de Carreira da paragem


% Função Principal
todosPubli(Origem,Destino,L):-
    findall((S,Dist,Car),publicidade(Origem,Destino,S,_,Dist,Car),L),
    escrever(L).


% Exemplo todosPubli(21,23,L).
% Exemplo toodsPubli(460,486,L).
%
%----------------------------------QUERIE 8-----------------------------------------
% Escolher o percurso que passe apenas por paragens abrigadas

abrigo(Origem, Dest , [Origem|Caminho], Abrigo,Dist, Carreira) :-
    abrigoProx(Origem, Dest, Caminho, Abrigo, Dist, Carreira, []).

abrigoProx(Dest, Dest, [], [] , 0 , [], _).                                                % Quando encontra o objetivo, este continua a preencher de tras para a frente
abrigoProx(Origem, Dest, [Prox|Caminho], Abrigo, Dist, Carreira, Visitados) :-
    Origem \== Dest,
    getAbrigo(Origem,Prox,Abrigo1,Dist1,Carreira1),
    nao(member(Prox,Visitados)),                                                           % Verifica se o Prox ja esta nos Visitados
    Abrigo1\=="Sem Abrigo",                                                                % verificar se a operadora da paragem Prox corresponde as Operadoras dadas como inputs
    abrigoProx(Prox, Dest, Caminho, Abrigo2 , Dist2, Carreira2,[Origem | Visitados]),      % recursividade para o resto
    Dist is Dist1 + Dist2,                                                                 % Soma das Distancias
    append([Carreira1], Carreira2, Carreira),                                              % Da Append do Carreira2 na lista Carreira1 e guarda na Lista Carreira
    append([Abrigo1],Abrigo2,Abrigo).                                                      % Da Append do Abrigo2 na lista Abrigo1 e guarda na Lista Abrigo

getAbrigo(Origem,Prox,Abrigo,Dist,Carreira):-
    arco(Origem,Prox,Dist,Carreira),                                                       % Retorna o arco
    paragem(Prox,_,_,_,Abrigo,_,_,Carreiras,_,_,_),                                        % Retorna o Abrigo e as Carreiras da paragem Prox
    member(Carreira,Carreiras).                                                            % Verifica se a Carreira do arco está na lista de Carreira da paragem


% Função Principal
todosAbrigo(Origem,Destino,L):-
    findall((S,Dist,Car,Abrigo),abrigo(Origem,Destino,S,Abrigo,Dist,Car),L),
    escrever(L).

% Exemplo todosAbrigo(21,23,L).
% Exemplo toodsAbrigo(460,486,L).

%----------------------------------QUERIE 9-----------------------------------------
% Escolher um ou mais pontos intermédios por onde o percurso deverá passar.

%verifica se um elemento pertence a uma  lista
temElem(_,[]).
temElem(L,[H|T]):- member(H,L), temElem(L,T).                                           % Se a H pertence a L

% Aplica a temElem a cabeça da lista e verefica se tem os elementos todos
check([],_,[]).
check([(X,_,_)|T],L,R) :- check(T,L,R), nao(temElem(X,L)).                              % Caso não pertença
check([(X,D,C)|T],L,R) :- check(T,L,K), temElem(X,L), append([(X,D,C)],K,R).            % Caso pertença


todosEntre(Origem,Destino,Pontos):-
    findall((S,Dist,Car),trajeto(Origem,Destino,S,Dist,Car),L),
    check(L,Pontos,R),
    escrever(R).


% Exemplo todosEntre(21,23,[11,650]).






%----------------------------------------------------------------%
%                         INFORMADA                              %
%----------------------------------------------------------------%

%-----------------------------A Estrela----------------------------------
% Adaptada da Ficha12
% Querie 1 e 6


resolve_aestrela(Origem, Destino, Caminho/Custo) :-
    distancia(Origem, Destino, X),                                                    % Em que X é a estimativa da distancia entre Origem e Destino
    aestrela([[(Origem, Destino)]/0/X], InvCaminho/Custo/_),
    inverso(InvCaminho, Caminho).

aestrela(Caminhos, Caminho) :-
    obtem_melhor(Caminhos, Caminho),
    Caminho = [(Nodo, Destino)|_]/_/_,
    Nodo == Destino.

aestrela(Caminhos, SolucaoCaminho) :-
    obtem_melhor(Caminhos, MelhorCaminho),
    seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
    expande_aestrela(MelhorCaminho, ExpCaminhos),
    append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
        aestrela(NovoCaminhos, SolucaoCaminho).


obtem_melhor([Caminho], Caminho) :- !.
obtem_melhor([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho) :-
    Custo1 + Est1 =< Custo2 + Est2, !,
    obtem_melhor([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).
obtem_melhor([_|Caminhos], MelhorCaminho) :-
    obtem_melhor(Caminhos, MelhorCaminho).


expande_aestrela(Caminho, ExpCaminhos) :-
    findall(NovoCaminho, adjacente(Caminho,NovoCaminho), ExpCaminhos).


adjacente([(Nodo,Destino)|Caminho]/Custo/_, [(ProxNodo,Destino),(Nodo,Destino)|Caminho]/NovoCusto/Est) :-
    arco(Nodo, ProxNodo, PassoCusto,_),
    \+ member(ProxNodo, Caminho),
    NovoCusto is Custo + PassoCusto,
    distancia(ProxNodo, Destino, Est).

% Obtem a distancia euclidiana entre dois pontos
distancia(Origem, Destino, X) :-
    getCoord(Origem,LatO,LongO),
    getCoord(Destino,LatD,LongD),
    X is sqrt((LatO-LatD)^2 + (LongO-LongD)^2).

% Retorna as coordenadas de Latitude e Longitude de uma paragem
getCoord(Ori,Lat,Long):-
    paragem(Ori,Lat,Long,_,_,_,_,_,_,_,_).


% Retira o elemento selecionado (E) da lista
seleciona(E, [E|Xs], Xs).
seleciona(E, [X|Xs], [X|Ys]) :- seleciona(E, Xs, Ys).

% Aplica o inverso a uma lista
inverso(Xs, Ys):-
	inverso(Xs, [], Ys).
inverso([], Xs, Xs).
inverso([X|Xs],Ys, Zs):-
	inverso(Xs, [X|Ys], Zs).

% Exemplo resolve_aestrela(21,23,C).
