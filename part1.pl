% PART 1 %
%compile with swipl -s part1.pl

% facts


flight(antalya , gaziantep).
flight(antalya , konya).
flight(antalya , istanbul).

flight(konya , antalya).
flight(konya , ankara).

flight(ankara , konya).
flight(ankara , van).
flight(ankara , istanbul).

flight(burdur , ısparta).

flight(edirne , edremit).


flight(edremit , edirne).
flight(edremit , erzincan).

flight(erzincan , edremit).

flight(ısparta , burdur).
flight(ısparta , izmir).

flight(izmir , ısparta).
flight(izmir , istanbul).

flight(istanbul , izmir).
flight(istanbul , antalya).
flight(istanbul , van).
flight(istanbul , gaziantep).
flight(istanbul , rize).
flight(istanbul , ankara).

flight(gaziantep , istanbul).
flight(gaziantep , antalya).

flight(rize , van).
flight(rize , istanbul).

flight(van , istanbul).
flight(van , rize).
flight(van , ankara).


%queries..

route(X, Y) :- routef(X, Y, []).

routef(X, Y, ListVisited) :- flight(X, Z) , not(member(Z, ListVisited)), ( Y = Z; routef(Z, Y, [X | ListVisited])).
