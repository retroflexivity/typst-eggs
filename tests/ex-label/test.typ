#import "/eggs.typ": *

#show: eggs

#example(label: <one>)[
  example
]

#example(number: 3)[
  example 3 #ex-label(<three>)
]

#example[
  + subexample #ex-label(<sub-one>)
  + subexample
  #ex-label(<subs>)
]

#example(number: 8)[
  example 3 #ex-label(<eight>)
]


1: @one

3: @three

2: @subs

2a: @sub-one

2b: @subs:b

8: @eight

#footnote[

  #example[
    example i #ex-label(<i>)
  ]

  i: @i
]
