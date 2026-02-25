#import "/eggs.typ": *

#show: eggs

1: #ex-ref(<one>)

2a: #ex-ref(<sub-one>)

1-2: #ex-ref(<one>, <subs>)

2a-b: #ex-ref(<sub-one>, <subs:b>)

#example(label: <one>)[
  example
]

#example[
  + subexample #ex-label(<sub-one>)
  + subexample
  #ex-label(<subs>)
]

#footnote[

  i: #ex-ref(<i>)

  iia-b: #ex-ref(<ii:a>, <ii:b>)

  #example[
    example i #ex-label(<i>)
  ]

  #example[
    + subexample #ex-label(<ii:a>)
    + subexample #ex-label(<ii:b>)
    #ex-label(<ii>)
  ]
]
