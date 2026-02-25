#import "/eggs.typ": *

#show: eggs

#example(number: 3)[
  example 3
]

#example[
  example
]

#example(number: 5)[
  + subexample (5)
  + subexample
]

#example[
  + subexample
  + subexample
]

#example(number: 7)[
  example 7
]

#example[
  + subexample
  + subexample
]


#example(number: 9)[
  + subexample (9)
  + subexample
]

#example[
  example
]

#example(number: 11)[
  example 11
]

#example(number: 13)[
  example 13
]

#example[
  example
]

#footnote[
  #example[
    example
  ]

  #example(number: 4)[
    example 4
  ]

  #example[
    example
  ]  
]

#example[
  + subexample
  #subexample(number: 6)[subexample f]
  + subexample
  #subexample(number: 2)[subexample b]
]

#example(number: 10)[
  + subexample (10)
  + subexample
]

#example[
  example
]

#example(number: 12)[
  + subexample (12)
  + subexample
]
