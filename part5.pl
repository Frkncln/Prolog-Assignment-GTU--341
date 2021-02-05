%PART 5 %
%compile with swipl -s part5.pl

% Run with 'main.'      like  '?- main.'
%If you want to enter with REPL mode ?- do([2,3,5,7,11]).
%     FL is fromleft ,FR fromright,L is our number list
%    left-hand term FL and right-hand term FR

operation(FL,FR,FL+FR).
operation(FL,FR,FL/FR) :- FR =\= 0.   % Handling for zero division
operation(FL,FR,FL*FR).
operation(FL,FR,FL-FR).

split(L,L1,L2) :- append(L1,L2,L),L1 = [_|_], L2 = [_|_].

% evaluating list for input from file
evalstream(In, L) :-
    read_line_to_codes(In, Line),
    (   Line == end_of_file
    ->  L = []
    ;   append(Line, Oth, L),
        evalstream(In, Oth) ).

%expressions operations        
expr([X],X).    
expr(L,T) :-split(L,LL,RL),              
   expr(RL,FR),expr(LL,FL),                                  
   operation(FL,FR,T).


eq(L,FL,FR) :- split(L,LL,RL),
   expr(RL,FR),expr(LL,FL),                    
   FL =:= FR.      


last([_| Tail]) :-
        last(Tail).


main:-
    open('input.txt', read, In), %filename is here ,must change from there if wanted
    evalstream(In, Nums),
    close(In),
    reps(Nums, List),append(_,_,List),
    do(List).



reps(Nums, Result) :-
    atom_codes(Ato0, Nums),
    format(atom(Ato1), '[~w]', Ato0),
    read_term_from_atom(Ato1, Result, []).


do(L) :- 
    	 write("input L ="), writeln(L),  
   		eq(L,FL,FR),
   		
   % openda can change to append ıf we want to print all processes to the file
   writef('%w == %w \n',[FL,FR]),
   % Writing to file
   open('output5.txt',write,OS),write(OS,FL=FR),write(OS,'\n'),close(OS), 
   
   fail.
do(_).
