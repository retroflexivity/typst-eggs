#import "/eggs.typ": *

#show: eggs

#example[
  + OK correct
  + \*incorrect
  + ?question
  + \#infelicitous
]

#example[
  + #judge[OK] correct
  + #judge[\*]incorrect
  + #judge[?]question
  + #judge[\#]infelicitous
]
