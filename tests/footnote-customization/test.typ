#import "/eggs.typ": *

#show: eggs.with(
  footnote-separate-numbering: false,
  footnote-num-pattern: "{1}",
)

#example[
  example
]

#footnote[
  #example[
    example
  ]
  #example[
    - subexample
    - subexample
  ]
]

#example[
  example
]

