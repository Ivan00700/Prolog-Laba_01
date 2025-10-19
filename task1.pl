% Первая часть задания - предикаты работы со списками

length_s([],0).
length_s([_ | A], N) :- length_s(A, N1), N is N1+1.

member_s(A, [A|_]).
member_s(A, [_ | B]) :- member_s(A, B).

append_s([], X, X).
append_s([Head | Tail], Elem, [Head | NTail]) :- append_s(Tail, Elem, NTail).


remove_s(X, [X | T], T).
remove_s(X, [Y | T], [Y | T1]) :- remove_s(X, T, T1).

permutation_s([], []).
permutation_s(L, [X | T]) :- remove_s(X, L, R), permutation_s(R, T).

sublist_s(S, L) :- append_s(_, L1, L), append_s(S, _, L1).


% ╰(*°▽°*)╯-----Задание 1-----╰(*°▽°*)╯
% Удаление N последних элементов списка (N = 24)

% ----- С использованием стандартных предикатов -----
remove_last_n(List, N, Result) :-
    length(List, Len),
    K is Len - N,
    K >= 0,
    length(Result, K),
    append(Result, _, List).

% ----- Без стандартных предикатов -----
remove_last_n_no_std(List, N, Result) :-
    length_no_std(List, Len),
    K is Len - N,
    take_first_k(List, K, Result).

length_no_std([], 0).
length_no_std([_|T], N) :-
    length_no_std(T, N1),
    N is N1 + 1.

take_first_k(_, 0, []) :- !.
take_first_k([], _, []) :- !.
take_first_k([H|T], K, [H|R]) :-
    K1 is K - 1,
    take_first_k(T, K1, R).


% ㄟ(≧◇≦)ㄏ-----Задание 2-----ㄟ(≧◇≦)ㄏ
% Лексикографическое сравнение 2 списков (N = 24)

% способ 1 без стандартных предикатов
lex_compare([], [], '=') :- !.
lex_compare([], [_|_], '<') :- !.
lex_compare([_|_], [], '>') :- !.

lex_compare([H1|T1], [H2|T2], Result) :-
    ( H1 < H2 -> Result = '<', ! ;
      H1 > H2 -> Result = '>', ! ;
      lex_compare(T1, T2, Result)
    ).

% способ 2 с применением встроенных предикатов
lex_compare_std(L1, L2, R) :-
    (   L1 == L2 -> R = '='
    ;   append(L1, _, L2) -> R = '<'
    ;   append(L2, _, L1) -> R = '>'
    ;   lex_compare(L1, L2, R)
    ).
