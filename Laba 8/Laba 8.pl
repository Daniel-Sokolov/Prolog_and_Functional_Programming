read_str(A,N,Flag):-get0(X),r_str(X,A,[],N,0,Flag).
r_str(-1,A,A,N,N,1):-!.
r_str(10,A,A,N,N,0):-!.
r_str(X,A,B,N,K,Flag):-K1 is K+1,append(B,[X],B1),get0(X1),r_str(X1,A,B1,N,K1,Flag).

read_list_str(List, LengthList):-read_str(A,N,Flag),read_list_str([A],List,[N],LengthList,Flag).
read_list_str(List,List,LengthList, LengthList,1):-!.
read_list_str(Cur_list,List,CurLengthList,LengthList,0):-
read_str(A,N,Flag),append(Cur_list,[A],C_l),
append(CurLengthList, [N], NewLengthList),read_list_str(C_l,List,NewLengthList,LengthList,Flag).

max(List, MaxEl):- max(List, 0, MaxEl).
max([],CurMax, CurMax):- !.
max([H|T], CurMax, X):- H > CurMax, NewMax is H, max(T,NewMax,X), !.
max([_|T], CurMax, X):- max(T, CurMax, X).

append1([],List2,List2).
append1([H1|T1],List2,[H1|T3]):-append1(T1,List2,T3).

write_str([]):-!.
write_str([H|Tail]):-put(H),write_str(Tail).

write_list_str([]):-!.
write_list_str([H|T]):-write_str(H),nl,write_list_str(T).

in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

reverse(A, Z) :- reverse(A,Z,[]).
reverse([],Z,Z).
reverse([H|T],Z,Acc) :- reverse(T,Z,[H|Acc]).

%__1_1__
pr8_1:- see('c:/Users/Daniel/Documents/GitHub/Prolog/Lab_8/lab.txt'),read_list_str(List, Lenght),seen,max(Lenght, Max), write(Max).

%__1_2__
pr8_2:- see('c:/Users/Daniel/Documents/GitHub/Prolog/Lab_8/lab.txt'),read_list_str(List,_), seen, space(List, 0, Kolvo),write(Kolvo).
space([],K,K):-!.
space([H|T], K, Kolvo):-not(in_list(H,32)),K1 is K+1, space(T, K1, Kolvo),!.
space([_|T], K, Kolvo):-space(T, K, Kolvo),!.

%__1_3__
pr8_3:- see('c:/Users/Daniel/Documents/GitHub/Prolog/Lab_8/lab.txt'),read_list_str(List,N),seen,all_symbol(N,0,K),write("Number of all symbols  "),write(K), nl,symbols(List,0,Kol),write("Number of symbols A-a  "),write(Kol),nl, Sr is K div Kol,write(Sr), nl, vyvedi(List,Sr).
all_symbol([],K, K):-!.
all_symbol([H|T], Kolvo, K):-Kolvo1 is Kolvo +H, all_symbol(T, Kolvo1, K).
symbols([],K, K):-!.
symbols([H|T], Kol, Kolvo):-symbols_a(H,0,K),Kol1 is Kol+K,symbols(T, Kol1, Kolvo),!.
symbols_a([],K, K):-!.
symbols_a([H|T], K, Kolvo):-(H==97,K1 is K+1,symbols_a(T, K1, Kolvo));(H==65,K1 is K+1,symbols_a(T, K1, Kolvo));(symbols_a(T, K, Kolvo)).
vyvedi([],_):-!.
vyvedi([H|T], Sr):-(symbols_a(H,0,K),K>Sr-> write_str(H),vyvedi(T, Sr);vyvedi(T, Sr)).

%__1_4__
pr8_4:-see('c:/Users/Daniel/Documents/GitHub/Prolog/Lab_8/lab.txt'),read_str(A,_,1),seen,tell('c:/Users/Aeeoi?ey/Documents/GitHub/Prolog1/Lab_8/Out.txt'),list_words_all_file(A,[],LW),often_word_in_list(LW,_,Word,0,_),write_str(Word),told.

list_words(A,LW):-append1([32],A,A1),reverse(A1,AR),list_words(AR,[],LW,[]).
list_words([],LW,LW,_):-!.
list_words([H|T],LW,LWN,W):-((H=32; H=10) -> append([W],LW,LW1),list_words(T,LW1,LWN,[]);
append1([H],W,W1),list_words(T,LW,LWN,W1)).

list_words_all_file([],ListAllWord,ListAllWord):-!.
list_words_all_file(Stroka,List,ListAllWord):-list_words(Stroka,LW),append1(List,LW,ListAllWord).

kol_repeat_in_list([H|T],X,K):-kol_repeat_in_list([H|T],X,0,K).
kol_repeat_in_list([],_,Kol,Kol):-!.
kol_repeat_in_list([H|T],X,K,Kol):-(H=X -> K1 is K+1,kol_repeat_in_list(T,X,K1,Kol);kol_repeat_in_list(T,X,K,Kol)).

often_word_in_list([],Word,Word,Kol,Kol):-!.
often_word_in_list([H|T],W,Word,K,Kol):-kol_repeat_in_list([H|T],H,K1),(K1>K -> Kol1 = K1,W1=H,often_word_in_list(T,W1,Word,K1,Kol1);often_word_in_list(T,W,Word,K,Kol)).

%__1_5__
pr8_5:-see('c:/Users/Daniel/Documents/GitHub/Prolog/Lab_8/lab.txt'),read_str(A,_,1),seen,tell('c:/Users/Aeeoi?ey/Documents/GitHub/Prolog1/Lab_8/Out.txt'),list_words_all_file(A,[],ListWordAllFile), proverka_(ListWordAllFile,ListWordAllFile),told.

proverka_(_,[]):-!.
proverka_(ListWordAllFile,[H|T]):- list_words(H,ListWordInStr),
					proverka(ListWordAllFile,ListWordInStr),write_str(H),nl,proverka_(ListWordAllFile,T),!.
proverka_(ListWordAllFile,[_|T]):-proverka_(ListWordAllFile,T).
proverka(_,[]):-true,!.
proverka(AllListWord,[H|T]):-kol_repeat_in_list(AllListWord,H,KolPovt),KolPovt<2,proverka(AllListWord,T),!.
proverka(AllListWord,[H|T]):-!,fail.

%__3__
pr3_:-see('c:/Users/Daniel/Documents/GitHub/Prolog/Lab_8/lab.txt'),read_str(List,_,1),seen,append(List,[32],A1),date_time(A1).

date_time([]):-!.
date_time([32|Tail]):-date_time(Tail),!.
date_time([Head|Tail]):-(day([Head|Tail],[],Day,After_Day)->(month(After_Day,[],Month,After_Month)->(year(After_Month,[],Year,After_Year)->
write_str(Day),write(" "),write_str(Month),write(" "),write_str(Year),nl,date_time(After_Year);date_time(After_Month)); date_time(After_Day));date_time(Tail)).

day([32|Tail],Day,Day,Tail):-!.
day([Head|Tail],I,Day,After_Day):-Head >=48,Head =<57,append(I,[Head],I1),day(Tail,I1,Day,After_Day),!.
day([_|_],_,_,_):-!,false.

month([32|Tail],Month,Month,Tail):-!.
month([Head|Tail],I,Month,After_Month):-Head >=97,Head =<122,append(I,[Head],I1),month(Tail,I1,Month,After_Month),!.
month([_|_],_,_,_):-!,false.

year([32|Tail],Year,Year,Tail):-!.
year([Head|Tail],I,Year,After_Year):-Head >=48,Head =<57,append(I,[Head],I1),year(Tail,I1,Year,After_Year),!.
year([_|_],_,_,_):-!,false.

%__5__
pr5:-see('c:/Users/Daniel/Documents/GitHub/Prolog/Lab_8/lab.txt'),read_list_str(List,N),seen,sort1(List, N,[]).
sort1([],[],A):-write_list_str(A),!.

sort1([H|T],[HL|TL],A):-Max =HL, Max_str=H, sort_([H|T],[HL|TL], Max, Max_str, Stroka, Nom),append(A,[Stroka],B),remove_str([H|T], Stroka, List),remove_str([HL|TL], Nom, ListL), sort1(List, ListL,B),!.

sort_([],[], Max, Max_str,Max_str, Max):-!.
sort_([H|T], [HL|TL], Max, Max_str, St,Nm):- (HL>Max-> Max1 = HL, Max_str1 = H,sort_(T, TL, Max1, Max_str1, St,Nm); sort_(T, TL, Max, Max_str,St,Nm)).

remove_str([H|T], X, List):-remove_str([H|T],[],List,X, 1).
remove_str([],List,List,_,_):-!.
remove_str([H|T], Temp, List, X, 1):-(H=X-> remove_str(T, Temp,List,X, 0)),!.
remove_str([H|T], Temp, List, X, 1):-append1(Temp,[H], Temp1), remove_str(T, Temp1, List, X,1).
remove_str([H|T], Temp, List, X, 0):-append1(Temp,[H], Temp1), remove_str(T, Temp1, List, X,1).

%__6__
pr6:-see('aead_list_str(List,_),seen,kol_slov_str(List, L),sort1(List, L,[]).

kol_slov_str(A,L):-kol_slov_str(A,[],L),!.
kol_slov_str([],L, L):-!.
kol_slov_str([H|T], L_, L):-list_wordskol(H,LW,0,Kolvo),append1(L_,[Kolvo],L1),kol_slov_str(T,L1,L).

list_wordskol(A,LW,_,K):-append1([32],A,A1),reverse(A1,AR),list_wordskol(AR,[],LW,[],K,0).
list_wordskol([],LW,LW,_,K,K):-!.
list_wordskol([H|T],LW,LWN,W,Kolvo,K):-((H=32; H=10) -> append([W],LW,LW1), K1 is K+1,list_wordskol(T,LW1,LWN,[],Kolvo, K1);
append1([H],W,W1),list_wordskol(T,LW,LWN,W1,Kolvo,K)).


%__7__
pr7:-see('c:/Users/Daniel/Documents/GitHub/Prolog/Lab_8/lab.txt'),read_list_str(List,_),seen,del_chisla(List, List1),kol_slov_str(List1, L),sort1(List1, L,[]).

del_chisla([],A,A):-!.
del_chisla(A,B):-del_chisla(A,B,[]).
del_chisla([H|T],L,A):-del_(H,List),append(A,[List],B),del_chisla(T, L,B),!.

del_([H|T],List):-del_([H|T],[],List, 1),!.
del_([],List,List,0):-!.
del_([H|T], Temp, List,1):-(H>47, H<58-> del_(T, Temp,List,0)),!.
del_([H|T], Temp, List,0):-(H>47, H<58-> del_(T, Temp,List,0)),!.
del_([H|T], Temp, List,0):-append1(Temp,[H], Temp1), del_(T, Temp1, List,0),!.
del_([H|T], Temp, List,1):-del_(T, Temp, List,1),!.


