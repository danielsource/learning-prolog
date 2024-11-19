% 'zero' é Natural:
nat(zero).
% Se N é natural, seu sucessor é Natural:
nat(s(N)) :- nat(N).

even(zero).                        % 'zero' é par;
even(s(N)) :- nat(N), odd(N).      % se N é ímpar, seu sucessor é par.
odd(N)     :- nat(N), \+ even(N).  % ímpar é "não par".

add(zero, N, N) :- nat(N).
add(s(N0), N1, s(N)) :- add(N0, N1, N).

% Conversão de Natural para Inteiro:
to_int(zero, 0).
to_int(s(N), I) :- nat(N), to_int(N, 1, I).
to_int(zero, Sum, Sum).
to_int(s(N), Sum, I) :-
	Sum1 is Sum + 1,
	to_int(N, Sum1, I).

% zero          <=> 0
% s(zero)       <=> 1
% s(s(zero))    <=> 2
% s(s(s(zero))) <=> 3
% ...

% Exemplo de soma entre Naturais (4 + 6 = 10):
% ?- to_int(N0, 4), to_int(N1, 6), add(N0, N1, N), to_int(N, I).
% N0 = s(s(s(s(zero)))),
% N1 = s(s(s(s(s(s(zero)))))),
% N  = s(s(s(s(s(s(s(s(s(s(zero)))))))))),
% I  = 10 .

% Encontre todos os Naturais que somam 4:
% ?- findall([N0, N1], add(N0, N1, s(s(s(s(zero))))), A4).
