#import "/eggs.typ": *

#show: eggs

#example(number: 3)[
  example 3
]

#example[
  example
]

#example(number: 5, label: <5>)[
  + subexample (5)
  + subexample
]

lbl @5

#example[
  + subexample
  + subexample
]

#example(number: "7x", label: <7x>)[
  example 7x
]

lbl @7x

#example[
  + subexample
  + subexample
]


#example(number: (9, 8), label: <98>)[
  + subexample (9h)
  + subexample
]

lbl @98
- @98:a

#example[
  example
]

#example(number: [11'])[
  example 11'
]

#example(number: [huh], label: <huh>)[
  example huh
]

lbl @huh

#example[
  example
]

#footnote[
  #example[
    example
  ]

  #example(number: 4, label: <fn>)[
    example iv
  ]

  lbl @fn

  #example[
    example
  ]  
]

#example[
  + subexample
  #subexample(number: 6, label: <6>)[subexample f]
  + subexample
  #subexample(number: 2)[subexample b]
]

lbl @6

#example(number: 10)[
  + subexample (10)
  #subexample(number: [uj], label: <uj>)[subexample uj]
]

lbl @uj

#example[
  example
]
