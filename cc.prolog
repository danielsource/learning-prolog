%
% DISCIPLINAS DO CURSO
%

% Disciplina: <sigla>, <período>.

disciplina(icc,   1).
disciplina(ip,    1).
disciplina(cid_1, 1).
disciplina(ga,    1).
disciplina(md,    1).
disciplina(mc,    1).

disciplina(plp,   2).
disciplina(si,    2).
disciplina(cid_2, 2).
disciplina(fcc_1, 2).
disciplina(al,    2).
disciplina(lcc,   2).
disciplina(adm,   2).

disciplina(aed_1, 3).
disciplina(poo,   3).
disciplina(bd_1,  3).
disciplina(fcc_2, 3).
disciplina(eb,    3).
disciplina(cd,    3).
disciplina(pgecc, 3).

disciplina(aed_2, 4).
disciplina(rc,    4).
disciplina(bd_2,  4).
disciplina(aa,    4).
disciplina(lfa,   4).
disciplina(aoc,   4).
disciplina(epcc,  4).

disciplina(ia,    5).
disciplina(comp,  5).
disciplina(cod,   5).
disciplina(dni,   5).
disciplina(so,    5).
disciplina(nt,    5).

disciplina(cida,  6).
disciplina(es,    6).
disciplina(sd,    6).
disciplina(de1,   6).
disciplina(de2,   6).
disciplina(op1,   6).
disciplina(op2,   6).

disciplina(tcc_1, 7).
disciplina(psc,   7).
disciplina(ihc,   7).
disciplina(op3,   7).
disciplina(op4,   7).
disciplina(op5,   7).
disciplina(de3,   7).

disciplina(tcc_2, 8).
disciplina(est,   8).
disciplina(atv,   8).

%
% PRÉ-REQUISITOS
%

% Requisito: <disc1>, <disc2>.
% <disc1> tem o pré-requisito <disc2>.

% Período 2
requisito(cid_2, cid_1).
requisito(al, ga).
requisito(lcc, md).

% Período 3
requisito(aed_1, ip).
requisito(poo, ip).
requisito(fcc_2, fcc_1).
requisito(cd, icc).
requisito(cd, lcc).

% Período 4
requisito(aed_2, aed_1).
requisito(rc, icc).
requisito(bd_2, bd_1).
requisito(aa, aed_1).
requisito(aa, lcc).
requisito(aa, cid_1).
requisito(lfa, md).
requisito(aoc, cd).
requisito(epcc, pgecc).

% Período 5
requisito(ia, lcc).
requisito(comp, lfa).
requisito(cod, lcc).
requisito(cod, lfa).
requisito(dni, epcc).
requisito(so, aoc).
% nt?

% Período 6
requisito(cida, ia).
requisito(cida, eb).
requisito(sd, rc).
requisito(sd, so).
% op1?
% op2?

% Período 7
% tcc_1?
requisito(psc, bd_2).
requisito(psc, poo).
requisito(psc, es).
% op3?
% op4?
% op5?

% Período 8
requisito(tcc_2, tcc_1).

%
% DISCIPLINAS QUE CURSEI
%

% Cursada: <disciplina>, <nota>.

cursada(icc,    8.5).
cursada(ip,    10.0).
cursada(cid_1,  8.2).
cursada(ga,     9.1).
cursada(md,     8.0).
cursada(mc,     9.4).
cursada(plp,    8.6).
cursada(si,     7.8).

%
% DISCIPLINAS QUE ESTOU CURSANDO
%

cursando(cid_2).
cursando(fcc_1).
cursando(al).
cursando(lcc).
cursando(adm).

% 
% REGRAS
%

% O aluno está aprovado em <X>?
aprovado(X) :-
    disciplina(X, _),
    cursada(X, Nota),
    Nota >= 7.0.

% É possível se matricular em <X>?
matricula(X) :-
    disciplina(X, _),  % X é uma disciplina de algum período.
    \+ aprovado(X),    % O aluno não foi aprovado em X.
    \+ cursando(X),    % O aluno não está cursando X.
    % Para todo pré-requisito X0, o aluno está aprovado em X0:
    forall((disciplina(X0, _), requisito(X, X0)),
        aprovado(X0)).
% Em notação de primeira ordem:
%   domínio: disciplinas do curso
%   M(x): ~A(x) ^ ~C(x) ^ (Ay)[R(x, y) => A(y)]
