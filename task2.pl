% Задание 2 (N = 24)
:- encoding(utf8).
:- ['one.pl'].


% ^_^----- 1. Средний балл по каждому предмету -----^_^
get_averenge_mark :-
    findall(Code, subject(Code, _), Codes),
    forall(member(Code, Codes),
        (
            findall(Grade, grade(_, Code, Grade), Grades),
            sum_list(Grades, Sum),
            length(Grades, Count),
            Avg is Sum / Count,
            subject(Code, Name),
            format('~w (~w): average mark = ~2f~n', [Code, Name, Avg])
        )
    ).

% ----- 2. Количество несдавших по каждой группе -----
get_bad_for_group :-
    findall(Group, student(Group, _), GroupsAll),
    sort(GroupsAll, Groups),
    forall(member(G, Groups),
        (
            findall(Name, student(G, Name), Students),
            include(has_failed, Students, Failed),
            length(Failed, N),
            format('Group ~w: fatal students = ~d~n', [G, N])
        )
    ).

% вспомогательная
has_failed(Name) :-
    grade(Name, _, Grade),
    Grade =< 2, !.

% ----- 3. Количество несдавших по предмету -----
get_bad_for_subj :-
    findall(Code, subject(Code, _), Codes),
    forall(member(Code, Codes),
        (
            findall(Name, (grade(Name, Code, Grade), Grade =< 2), Failed),
            length(Failed, N),
            subject(Code, NameFull),
            format('~w (~w): fatal students = ~d~n', [Code, NameFull, N])
        )
    ).
