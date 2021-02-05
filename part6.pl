% Part 6 %
%compile with swipl -s part6.pl
% ?- test('test1').   --for testing

puzz(RowNums,ColNums,Solution,Opt) :-
   length(RowNums,NRows),
   length(ColNums,NCols),
   takerectangle(NRows,NCols,Rows,Cols),
   append(Rows,Cols,Lines),
   append(RowNums,ColNums,LineNums),
   maplist(takeruns,LineNums,LineRuns),
   combine(Lines,LineRuns,LineTasks),
   optimize(Opt,LineTasks,OptimizedLineTasks),
   solve(OptimizedLineTasks),
   Solution = Rows.
 
combine([],[],[]).
combine([L1|Ls],[N1|Ns],[task(L1,N1)|Ts]) :- combine(Ls,Ns,Ts).

solve([]).
solve([task(Line,LineRuns)|Tasks]) :- 
   putruns(LineRuns,Line),
   solve(Tasks).
%-------------------------------------------------------1
takerectangle(NRows,NCols,Rows,Cols) :-
   NRows > 0, NCols > 0,
   length(Rows,NRows),
   Pred1 =.. [invlen, NCols],
   checklist(Pred1,Rows),
   length(Cols,NCols),
   Pred2 =.. [invlen, NRows],
   checklist(Pred2,Cols),
   combrectangle(Rows,Cols).

invlen(Len,List) :- length(List,Len).

combrectangle(_,[]).
combrectangle([],_).
combrectangle([[X|Row1]|Rows],[[X|Col1]|Cols]) :-
   combrow(Row1,Cols,ColsR), 
   combrectangle(Rows,[Col1|ColsR]).   

combrow([],[],[]).
combrow([X|Row],[[X|Col1]|Cols],[Col1|ColsR]) :- combrow(Row,Cols,ColsR).

%-------------------------------------------------2
takeruns([],[]) :- !.
takeruns([Len1|Lens],[Run1-T|Runs]) :- 
   put_x(Len1,Run1,T),
   takeruns2(Lens,Runs).

takeruns2([],[]).
takeruns2([Len1|Lens],[[' '|Run1]-T|Runs]) :- 
   put_x(Len1,Run1,T),
   takeruns2(Lens,Runs).

put_x(0,T,T) :- !.
put_x(N,['x'|Xs],T) :- N > 0, N1 is N-1, put_x(N1,Xs,T).


putruns([],[]).
putruns([Line-Rest|Runs],Line) :- putruns(Runs,Rest).
putruns(Runs,[' '|Rest]) :- putruns(Runs,Rest).
 

%--------------------------------------------------3 

optimize(1,LineTasks,OptimizedLineTasks) :- 
   label(LineTasks,LabelledLineTasks),
   sort(LabelledLineTasks,SortedLineTasks),
	unlabel(SortedLineTasks,OptimizedLineTasks).
   
label([],[]).
label([task(Line,LineRuns)|Tasks],[task(Count,Line,LineRuns)|LTasks]) :- 
   length(Line,N),   
   findall(L,(length(L,N), putruns(LineRuns,L)),Ls),
   length(Ls,Count),
   label(Tasks,LTasks).

unlabel([],[]).
unlabel([task(_,Line,LineRuns)|LTasks],[task(Line,LineRuns)|Tasks]) :- 
   unlabel(LTasks,Tasks).

%--------------------------------------------------printing part


printpuzzle([],ColNums,[]) :- printcols(ColNums).
printpuzzle([RowNums1|RowNums],ColNums,[Row1|Rows]) :-
   printrow(Row1),
   printrows(RowNums1),
   printpuzzle(RowNums,ColNums,Rows).

printrow([]) :- write('  ')
			,open('output.txt',append,OS),write(OS,'  '),close(OS)
				.



printrow([X|Xs]) :- printrepl(X,Y), write(' '), write(Y),
				
				open('output.txt',append,OS)
				,write(OS,' '), write(OS,Y),close(OS), 				
				printrow(Xs).
   
printrepl(' ',' ') :- !.
printrepl(x,'X').

printrows([]) :- nl.

printrows([N|Ns]) :- write(N), write(' ')
				,open('output.txt',append,OS)
				, write(OS,' \n'),close(OS), printrows(Ns).



printcols(ColNums) :-
   maxlength(ColNums,M,0),
	printcols(ColNums,ColNums,1,M).

maxlength([],M,M).
maxlength([L|Ls],M,A) :- length(L,N), B is max(A,N), maxlength(Ls,M,B). 

printcols(_,[],M,M) :- !, nl.
printcols(ColNums,[],K,M) :- K < M, !, nl,
   K1 is K+1, printcols(ColNums,ColNums,K1,M).
printcols(ColNums,[Col1|Cols],K,M) :- K =<  M, 
   writek(K,Col1), printcols(ColNums,Cols,K,M).
   
writek(K,List) :- nth1(K,List,X), !, writef('%2r',[X]).

writek(_,_) :- write('  ')
				,open('output.txt',append,OS),write(OS,'  '), close(OS).


%*********************test part***************

test(Name) :- 
   puzzle(Name,Rs,Cs),
   puzz(Rs,Cs,Solution,1), nl,
   printpuzzle(Rs,Cs,Solution).

puzzle(
	'test1',
	[[3], [2,1], [3,2], [2,2], [6], [1,5], [6], [1], [2]],
	[[1,2], [3,1], [1,5], [7,1], [5], [3], [4], [3]]
	).

