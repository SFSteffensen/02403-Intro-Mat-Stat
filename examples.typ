#import "template.typ": *  
#import "theorems.typ": * 
#import "util.typ": *

#set heading(numbering: "1.1")

= Heading dependent

#proof(title: "test")[
]

#theorem(title: "Test")[
  2222
]

#remark(title: "test")[
  11
]

#warning[
  Blah
]

#exercise[
 Test test 
]

#example[
  Indeed
]

#lemma[
  Test
]

#solution[
  
]

#proposition[
  
]

#note[

  
]

#corollary[
  
]

#let ma(v) = vb(math.upright(v))


$
"vector" va(v) &= vec(2,3,4)  \ 
"matrix" ma(A) &= mat(1,2,3;4,5,6; 7,8,9) \ 
"Transponeret" va(v)^TT &= vecrow(2,3,4)
$

