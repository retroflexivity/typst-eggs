#import "/eggs.typ": *

#show: eggs

#example[
  preamble
  - some  text
  - sooooooome  text
  ft
]

#example[
  - some  _text_
  - #smallcaps[several word]  text
]

#example[
  - some  #[multiple _words_]
  - #smallcaps[several]~word  text
]

+ #gloss[
    some  text
  ][
    soooome  text
  ]

#show: eggs.with(
  auto-glosses: false,
)

#example[
  - not  glosses
  - still  not  glosses
  #gloss[
    some  text
  ][
    soooome  text
  ]
]

#show: eggs.with(
  auto-glosses: true,
  gloss-before-spacing: 2em,
  gloss-after-spacing: 0em,
  gloss-line-spacing: 4em,
  gloss-word-spacing: 1pt,
  gloss-styles: (
    emph,
    smallcaps,
    it => [/it]
  )
)

#example[
  preamble
  - some  text
  - sooome  text
  - more  text
  ft
]

#example[
  - text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  
  - text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  text  
]
