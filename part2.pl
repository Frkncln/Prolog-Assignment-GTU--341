% PART 2 %
%compile with swipl -s part2.pl

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


distance(ankara,konya,227).

distance(ankara,istanbul,352).

distance(ankara,van,920).

distance(antalya,istanbul,483).

distance(antalya,konya,192).

distance(antalya,gaziantep,592).

distance(edirne,edremit,235).

distance(edremit,edirne,235).

distance(edremit,erzincan,1060).

distance(erzincan,edremit,1060).

distance(burdur,ısparta,25).

distance(ısparta,burdur,25).

distance(ısparta,izmir,309).

distance(izmir,ısparta,309).

distance(izmir,istanbul,329).

distance(istanbul,izmir,329).

distance(istanbul,antalya,483).

distance(istanbul,gaziantep,847).

distance(istanbul,ankara,352).

distance(istanbul,van,1262).

distance(istanbul,rize,373).

distance(gaziantep,istanbul,847).

distance(gaziantep,antalya,592).

distance(konya,antalya,192).

distance(konya,ankara,227).

distance(rize,van,373).

distance(rize,istanbul,373).

distance(van,ankara,920).

distance(van,istanbul,1262).

distance(van,rize,373).





%queries..



sroute(F1,F2,D) :- flight(F1,F2), distance(F1,F2,D).



sroute(F1,F2,D) :- flight(F1,F3), flight(F3,F2)

					,distance(F1,F3,D1)

					,distance(F3,F2,D2), D is D1+D2.
