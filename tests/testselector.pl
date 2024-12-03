% test the selector to correctly filter pairs
x_unit(F , M, N)
  :- call( F ) -> N is M + 1; N is M.

x_selector(N10)
  :- x_unit(selector([[ 2 ,29 ,1] ,[ 3 ,31 ,2]]) , 0 , N1 ) ,
     x_unit(selector([[ 2 ,29 ,5] ,[ 3 ,31 ,6]]) , N1 , N2 ) ,
     x_unit(\+ selector([[ 1 ,31 ,5] ,[ 2 ,28 ,1]]) , N2 , N3 ) ,
     x_unit(\+ selector([[ 1 ,31 ,7] ,[ 2 ,29 ,3]]) , N3 , N4 ) ,
     x_unit(\+ selector([[ 2 ,29 ,6] ,[ 3 ,31 ,7]]) , N4 , N5 ) ,
     x_unit(\+ selector([[ 2 ,29 ,4] ,[ 3 ,31 ,5]]) , N5 , N6 ) ,
     x_unit(\+ selector([[ 6 ,30 ,2] ,[ 7 ,31 ,4]]) , N6 , N7 ) ,
     x_unit(\+ selector([[ 8 ,31 ,3] ,[ 9 ,30 ,6]]) , N7 , N8 ) ,
     x_unit(\+ selector([[10 ,31 ,3] ,[11 ,30 ,6]]) , N8 , N9 ) ,
     x_unit(\+ selector([[10 ,31 ,7] ,[11 ,30 ,3]]) , N9 , N10 ).
