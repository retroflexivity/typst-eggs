#import "/eggs.typ": *

#show: eggs

(1): @one

(2a): @sub-one

(1-2): @one[@subs]

(2a-b): @sub-one[@subs:b]

#example(label: <one>)[
  example
]

#example[
  + subexample #ex-label(<sub-one>)
  + subexample
  #ex-label(<subs>)
]

#footnote[

  (i): @i

  (iia-b): @ii:a[@ii:b]

  #example[
    example i #ex-label(<i>)
  ]

  #example[
    + subexample #ex-label(<ii:a>)
    + subexample #ex-label(<ii:b>)
    #ex-label(<ii>)
  ]
]

#figure(
  kind: "example",
  supplement: none
)[figure] <fig>

1: @fig
