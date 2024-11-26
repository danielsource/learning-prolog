%%% Basic knowledge

% parents('Child', ['Father', 'Mother']).
:- include('local/parents.prolog'). % File containing my actual family.

%%% Rules

father(Child, Father) :- parents(Child, [Father | [_M]]).
mother(Child, Mother) :- parents(Child, [_F | [Mother]]).

sibling(P1, P2)       :- parents(P1, Ps), parents(P2, Ps), P1 \= P2.
half_sibling(P1, P2)  :-
    father(P1, F1),
    mother(P1, M1),
    father(P2, F2),
    mother(P2, M2),
    ((F1 = F2, M1 \= M2) ; (F1 \= F2, M1 = M2)),
    P1 \= P2.

siblings(Person, Siblings) :- findall(S, sibling(Person, S), Siblings).
half_siblings(Person, Siblings) :- findall(S, half_sibling(Person, S), Siblings).

person(X) :-
    (father(X, _) ; mother(X, _)) ;
    father(_, X) ;
    mother(_, X).

people(AllSorted, Count) :-
    findall(P, person(P), People),
    sort(People, AllSorted),
    length(AllSorted, Count).

write_indent(Term, 0) :- write(Term), !.
write_indent(Term, NInd) :-
    NInd > 0,
    write('    '),
    N is NInd - 1,
    write_indent(Term, N).

tree(Person) :- tree(Person, 0).
tree(Person, Depth) :-
    D is Depth + 1,
    write_indent([Person], Depth),
    forall(sibling(Person, S), (write('; '), write(S))),
    forall(half_sibling(Person, S), (write(' / '), write(S))),
    nl,
    father(Person, F),
    mother(Person, M),
    (parents(F, _) ->
        tree(F, D)
    ; write_indent([F], D), nl),
    (parents(M, _) ->
        tree(M, D)
    ; write_indent([M], D), nl)
    .
