% tests function mondays to correspond dates
tester(N5)
  :- x_unit(mondays(31 ,4 ,[5 ,12 ,19 ,26]) , 0 , N1 ) ,
     x_unit(mondays(30 ,1 ,[1 ,8 ,15 ,22 ,29]) , N1 , N2 ) ,
     x_unit(mondays(31 ,6 ,[3 ,10 ,17 ,24 ,31]) , N2 , N3 ) ,
     x_unit(mondays(28 ,7 ,[2 ,9 ,16 ,23]) , N3 , N4 ) ,
     x_unit(mondays(30 ,2 ,[7 ,14 ,21 ,28]) , N4 , N5 ).

x_unit(F , M, N)
  :- call( F ) -> N is M + 1; N is M.
