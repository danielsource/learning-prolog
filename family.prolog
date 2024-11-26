%%% Basic knowledge

% parents('Child', ['Father', 'Mother']).
:- include('local/parents.prolog'). % File containing my actual family.

%%% Rules

father(Child, Father) :- parents(Child, [Father | [_M]]).
mother(Child, Mother) :- parents(Child, [_F | [Mother]]).
sibling(P1, P2)       :- parents(P1, Ps), parents(P2, Ps), P1 \= P2.
siblings(Person, Siblings) :- findall(S, sibling(Person, S), Siblings).
known_child(X)  :- parents(X, _).
known_father(X) :- parents(_, [X|[_]]).
known_mother(X) :- parents(_, [_|[X]]).
person(X) :- known_child(X) ; known_father(X) ; known_mother(X).
