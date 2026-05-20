#import "/eggs.typ": *

#show: eggs

#example[
  OK correct
]

#example[
  \*incorrect
]

#example[
  + OK correct
  + \*incorrect
  + ?question
  + \#infelicitous
]

#example[
  + #judge[#super[OK]]correct
  + #judge[\*]incorrect
  + #judge[#super[?]]question
  + #judge[#super[\#]]infelicitous
]

#example[
  + _what_? *umm* OK
  + ?\# complex judge
  + \*OK also complex judge
  + \* OK and this is a simple judge
]

#example[
  - \*(gloss) lines should be ?fine
  - gloss lines should be _fine_?
]

#show: eggs.with(
  auto-judges: (:)
)

#example[
  ?question
]
