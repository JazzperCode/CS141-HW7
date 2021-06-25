%HW 7 

%Commutative property
door(X,Y) :- door_between(X,Y); door_between(Y,X).

%path_from
path_from(X,Y,R) :- path_from(X,Y,[],R).

path_from(X,X,L,L).
path_from(X,Y,L,R) :- door(X,Z), \+(member(Z,L)), (Y=Z -> append(L,[X,Y],T);append(L,[X],T)),path_from(Z,Y,T,R).




%party_seating 
%each person must be able to have a converstaion with both people they are seated next to
%No two females sit next to each other.
%% No_females

compatible(X,Y):- not_both_female(X,Y),can_communicate(X,Y),X\==Y.
can_communicate(X,Y):- speaks(X,L),speaks(Y,L).

not_both_female(X,Y) :- male(X),male(Y).
not_both_female(X,Y) :- male(X),female(Y).
not_both_female(X,Y) :- female(X),male(Y).

round_table(2, FirstPerson, L) :- compatible(SomeoneWhoMeetsRequirement,FirstPerson), append([SomeoneWhoMeetsRequirement],[FirstPerson],L).
round_table(Size,FirstPerson,L):- NewSize is Size - 1, round_table(NewSize, FirstPerson,[H|T]),compatible(H,X),\+(member(X,[H|T])),append([X],[H|T],L).

party_seating([H|T]):- round_table(10,_,[H|T]), last([H|T],Y), compatible(H,Y). 

%deriv

deriv(X,R):- unsimplified_deriv(X,Y),simplify(Y,R).

unsimplified_deriv(-x,-1):- !.
unsimplified_deriv(x,1):- !.
unsimplified_deriv(A,0) :- atomic(A).


unsimplified_deriv(A + B,X + Y):- unsimplified_deriv(A,X),unsimplified_deriv(B,Y).
unsimplified_deriv(A - B,X - Y):- unsimplified_deriv(A,X),unsimplified_deriv(B,Y).


unsimplified_deriv(A * B, A * Y + B * X):- unsimplified_deriv(A,X),unsimplified_deriv(B,Y).
unsimplified_deriv(A / B, (B * X - A * Y)/(B*B)):- unsimplified_deriv(A,X), unsimplified_deriv(B,Y).

unsimplified_deriv(A ^ C, C * X * A ^ (C-1)):- atomic(C), C\=x, unsimplified_deriv(A,X).

simplify(A,A):- atomic(A),!.

simplify(A-A,0).
simplify(A+A,2*A).
simplify(_*0,0).
simplify(0*_,0).
simplify(0/_,0).
simplify(A*1,A).
simplify(1*A,A).
simplify(A*A,A^2) :-!.
simplify(A/A,1) :-!.
simplify(A^1,A) :- !.
simplify(A^0,A) :- !.

simplify(A+B,R):- number(A),number(B), R is A + B.
simplify(A-B,R):- number(A),number(B), R is A - B.
simplify(A*B, R) :- number(A),number(B), R is A*B.
simplify(A/B, R) :- number(A),number(B), R is A/B.
simplify(A^B, R) :- number(A),number(B), R is A^B.

simplify(A+B,R):- simplify(A,X),simplify(B,Y),(A\==X;B\==Y),simplify(X+Y,R),!.
simplify(A-B,R):- simplify(A,X),simplify(B,Y),(A\==X;B\==Y),simplify(X-Y,R),!.
simplify(A*B,R) :- simplify(A,X),simplify(B,Y),(A\==X;B\==Y),simplify(X*Y,R),!.
simplify(A/B,R) :- simplify(A,X),simplify(B,Y),(A\==X;B\==Y),simplify(X/Y,R),!.
simplify(A^B,R) :- simplify(A,X),simplify(B,Y),(A\==X;B\==Y),simplify(X^Y,R),!.

simplify(A,A).





