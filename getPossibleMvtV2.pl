
%fct de déplacement
deplacement1(A,B):- A=:=B+1,A<46,(A%10)<6,!.
deplacement2(A,B):- A=:=B+10,A<46,(A%10)<6,!.
deplacement3(A,B):- A=:=B+11,A<46,(A%10)<6,!.
deplacement4(A,B):- A=:=B+9,A<46,(A%10)<6,!.
deplacement5(A,B):- A=:=B-1,,A>0,(A%10)<6,!.
deplacement6(A,B):- A=:=B-10,A>0,(A%10)<6,!.
deplacement7(A,B):- A=:=B-11,A>0,(A%10)<6,!.
deplacement8(A,B):- A=:=B-9,A>0,(A%10)<6,!.

