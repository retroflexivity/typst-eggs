#import "/eggs.typ": *

#show: eggs

#example[
  + subexample
  + subexample
]

#example[
  + subexample
  #subexample[manual subexample]
  + subexample
]

#example(auto-subexamples: false)[
  + not a subexample
  + not a subexample
  #subexample[manual subexample]
  #subexample[manual subexample]
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

#show: eggs.with(
  auto-subexamples: false,
  sub-body-indent: 10em,
  sub-indent: 3em,
  sub-num-pattern: "[a]",
  sub-spacing: 10em,
)

#example(auto-subexamples: false)[
  + not a subexample
  + not a subexample
  #subexample[manual subexample]
  #subexample[manual subexample]
]

