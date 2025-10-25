% Задание 2 (N = 24)
:- encoding(utf8).
:- ['one.pl'].

% --- Средний балл по каждой группе ---
group_avg(Group, Avg) :-
    student(Group, _),
    findall(Grade,
        (student(Group, Name), grade(Name, _, Grade)),
        Grades),
    sum_list(Grades, Sum),
    length(Grades, Count),
    Count > 0,
    Avg is Sum / Count.

print_group_avg :-
    nl, write('Group | Average'), nl,
    write('----------------'), nl,
    forall(group_avg(G, A),
           (format('~w~t~8|~2f~n', [G, A]))).

% Список студентов, не сдавших экзамен (grade = 2) по каждому предмету
failed_students(SubjectCode, Students) :-
    findall(Name,
        grade(Name, SubjectCode, 2),
        Students).

% Количество не сдавших студентов в каждой группе
failed_count_by_group(Group, Count) :-
    student(Group, _),
    findall(Name,
        (student(Group, Name), grade(Name, _, 2)),
        FailedList),
    sort(FailedList, UniqueFailed),
    length(UniqueFailed, Count).

% Таблица
print_failed_count :-
    nl, write('Group | Failed Students'), nl,
    write('---------------------------'), nl,
    forall(failed_count_by_group(G, C),
           (format('~w~t~8|~d~n', [G, C]))).

