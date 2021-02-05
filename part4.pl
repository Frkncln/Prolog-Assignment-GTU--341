% PART 4 %
%compile with swipl -s part4.pl

%element
element(E, [E|_]).
element(E, [_|S]):- element(E, S).

%unions
union(S1,S2,S3) :- unions(S1,S2,X), equivalent(X,S3).
unions([], S2, S2).
unions([E|S1], S2, S3) :- element(E, S2), !, unions(S1, S2, S3). 
unions([E|S1], S2, [E|S3]) :- unions(S1, S2, S3).

%equivalents
equivalent(S1, S2) :- equivalent2(S1,S2), equivalent2(S2,S1).
equivalent2([],_).
equivalent2([E|S1],S2):- element(E,S2), equivalent2(S1,S2).

%intersects
intersect(S1,S2,S3) :- intersects(S1,S2,X), equivalent(X,S3).
intersects([], _, []).
intersects([E|S1], S2, [E|S3]):- element(E, S2), !, intersects(S1, S2, S3).
intersects([_|S1], S2, S3):- intersects(S1, S2, S3).
