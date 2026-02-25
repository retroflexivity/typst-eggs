#import "/eggs.typ": *

#show: eggs

#example[
  + subexample
  + subexample
]

#example[
  + subexample
  + subexample
]

#example[
  + subexample
  + subexample
]

#show: eggs.with(
  sub-body-indent: 10em,
  sub-indent: 3em,
  sub-num-pattern: "[a]",
  sub-spacing: 10em,
)

#example[
  + subexample
  + subexample
]

