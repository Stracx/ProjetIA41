%fct de deplacement
deplacement(A,B):- A=:=B+10,A<46,(A mod 10)<6,!.
deplacement(A,B):- A=:=B+11,A<46,(A mod 10)<6,!.
deplacement(A,B):- A=:=B+9,A<46,(A mod 10)<6,!.
deplacement(A,B):- A=:=B-1,A>0,(A mod 10)<6,!.
deplacement(A,B):- A=:=B-10,A>0,(A mod 10)<6,!.
deplacement(A,B):- A=:=B-11,A>0,(A mod 10)<6,!.
deplacement(A,B):- A=:=B-9,A>0,(A mod 10)<6,!.