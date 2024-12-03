% tests the generate to correctly produce pairs of consecutive months 
x_unit(F , M, N)
  :- call( F ) -> N is M + 1; N is M.

x_generator(N10)
  :- x_unit(generator([[ 1 ,31 ,1] ,[ 2 ,28 ,4]]) , 0 , N1 ) ,
     x_unit(generator([[ 1 ,31 ,6] ,[ 2 ,29 ,2]]) , N1 , N2 ) ,
     x_unit(generator([[ 2 ,29 ,5] ,[ 3 ,31 ,6]]) , N2 , N3 ) ,
     x_unit(generator([[ 8 ,31 ,5] ,[ 9 ,30 ,1]]) , N3 , N4 ) ,
     x_unit(generator([[12 ,31 ,4] ,[ 1 ,31 ,7]]) , N4 , N5 ) ,
     x_unit(\+ generator([[11 ,30 ,2] ,[12 ,31 ,3]]) , N5 , N6 ) ,
     x_unit(\+ generator([[ 6 ,20 ,3] ,[11 ,30 ,3]]) , N6 , N7 ) ,
     x_unit(\+ generator([[12 ,31 ,4] ,[11 ,30 ,2]]) , N7 , N8 ) ,
     x_unit(\+ generator([[ 9 ,30 ,1] ,[ 5 ,29 ,2]]) , N8 , N9 ) ,
     x_unit(\+ generator([[ 7 ,31 ,3] ,[ 8 ,31 ,7]]) , N9 , N10 ).
