#import "@preview/elembic:1.1.1" as e

#import("ex-ref.typ"): parse-ref
#import("example.typ"): example, subexample, fn-ctr
#import("gloss.typ"): gloss

#let get-dict-without-autos(pairs) = pairs.filter(it => {
  it.at(1) != auto
}).map(it => (it.at(0): it.at(1))).join()

/// Sets the default config with optional overrides.
/// Primarily intended for use in a global show rule:
/// ```typst #show: eggs()``` -> content
#let eggs(
  /// The content. -> content
  it,
  /// Whether to treat numbered lists in examples as subexamples.
  /// Default: true -> bool
  auto-subexamples: auto,
  /// Whether to treat bullet lists in examples as glosses.
  /// Default: true -> bool
  auto-glosses: auto,
  /// Whether to insert subexample labels of the form ex-label:a.
  /// Default: true -> bool
  auto-labels: auto,
  /// A dictionary of characters to convert into judges (keys) and whether to superscript them (values).
  /// Default: ("\*": false, "\#": true, "?": true, "OK": true) -> dictionary
  auto-judges: auto,
  /// Distance between the left margin and the left edge of the example number.
  /// Default: 0em -> length
  indent: auto,
  /// Distance between the left edge of the example marker and the left edge of the example body.
  /// Default: 2.5em -> length
  body-indent: auto,
  /// Distance between the left edge of the top-level example body
  /// and the left edge of the subexample number.
  /// Can be negative.
  /// Default: 0em -> length
  sub-indent: auto,
  /// Distance between the left edge of the subexample marker
  /// and the subexample body.
  /// Default: 1.5em -> length
  sub-body-indent: auto,
  /// Vertical spacing around example.
  /// Currently, there is no way to modify spacing between two subexamples specifically.
  /// Default: current `par.spacing`. -> length
  spacing: auto,
  /// Vertical spacing around subexamples.
  /// Default: current `par.leading`. -> length
  sub-spacing: auto,
  /// Whether the example figure is breakable.
  /// Default: false -> bool
  breakable: auto,
  /// Whether the subexample figure is breakable.
  /// Default: false -> bool
  sub-breakable: auto,
  /// Example number format.
  /// A numbering pattern.
  /// Default: "(1)" -> str | function
  num-pattern: auto,
  /// Example number format inside footnotes.
  /// A numbering pattern.
  /// Default: "(i)" -> str | function
  footnote-num-pattern: auto,
  /// Subexample number format.
  /// A numbering pattern.
  /// Default: "a." -> str | function
  sub-num-pattern: auto,
  /// Whether to format `@`-references and `ref`-references to examples
  /// Adding parenthesis and parsing the supplement.
  /// Default: true -> bool
  smart-refs: auto,
  /// Example reference format.
  /// A 2-level numbering pattern.
  /// Default: "1a" -> str | function
  ref-pattern: auto,
  /// Format to reference the second argument of `ex-ref` if it is a subexample.
  /// A 1-level numbering pattern.
  /// Default: "a" -> str | function
  second-sub-ref-pattern: auto,
  /// Whether examples in each footnote start from 1.
  /// Default: true -> bool
  footnote-separate-numbering: auto,
  /// Footnote example reference format.
  /// A 2-level numbering pattern.
  /// Default: "ia" -> str | function
  footnote-ref-pattern: auto,
  /// The example figure supplement used in references.
  /// Has no effect when `smart-ref` is `true`.
  /// Default: none -> str | none
  label-supplement: auto,
  /// The subexample figure supplement used in references.
  /// Has no effect when `smart-ref` is `true`.
  /// Default: none -> str | none
  sub-label-supplement: auto,
  /// Horizontal spacing between words in glosses.
  /// Default: 1em -> length
  gloss-word-spacing: auto,
  /// Vertical spacing between lines in glosses.
  /// Default: current `par.leading`. -> length
  gloss-line-spacing: auto,
  /// Vertical spacing above glosses (i.e. after the preamble).
  /// Default: current `par.leading`. -> length
  gloss-before-spacing: auto,
  /// Vertical spacing below glosses (i.e. before the translation).
  /// Default: current `par.leading`. -> length
  gloss-after-spacing: auto,
  /// List of functions to be applied to each line of glosses.
  /// Can be of any length. `gloss-styles[0]` is applied to the first line,
  /// `gloss-styles[1]` --- to the second, etc.
  /// E.g. ```typst (emph, it => it + [.])``` makes the first line italicized
  /// and adds a period to the second line.
  /// Default: () -> array
  gloss-styles: auto,
) = {
  show: e.prepare()

  let get-default-footnote(..fields) = fields.named().pairs().map(it =>
    if it.at(1) == auto {(it.at(0):
      (
        num-pattern: "(i)",
        ref-pattern: "ia",
        separate-numbering: true,
      ).at(it.at(0))
    )} else { (it.at(0): it.at(1)) }
  ).join()

  let example-fields = (
    ("auto-subexamples", auto-subexamples),
    ("auto-glosses", auto-glosses),
    ("auto-labels", auto-labels),
    ("auto-judges", auto-judges),

    ("indent", indent),
    ("body-indent", body-indent),
    ("spacing", spacing),
    ("breakable", breakable),

    ("smart-refs", smart-refs),
    ("num-pattern", num-pattern),
    ("ref-pattern", ref-pattern),

    ("label-supplement", label-supplement),
  )

  let subexample-fields = (
    ("auto-glosses", auto-glosses),
    ("auto-judges", auto-judges),

    ("indent", sub-indent),
    ("body-indent", sub-body-indent),
    ("spacing", sub-spacing),
    ("breakable", sub-breakable),

    ("num-pattern", sub-num-pattern),
    ("ref-pattern", ref-pattern),
    ("second-sub-ref-pattern", second-sub-ref-pattern),
    ("label-supplement", sub-label-supplement),
  )

  let gloss-fields = (
    ("word-spacing", gloss-word-spacing),
    ("line-spacing", gloss-line-spacing),
    ("before-spacing", gloss-before-spacing),
    ("after-spacing", gloss-after-spacing),
    ("styles", gloss-styles),
  )

  show: e.set_(example,
    ..get-dict-without-autos(example-fields)
  )
  show: e.set_(subexample,
    ..get-dict-without-autos(subexample-fields)
  )
  show: e.set_(gloss,
    ..get-dict-without-autos(gloss-fields)
  )


  show footnote.entry: it => {
    let separate-numbering = get-default-footnote(separate-numbering: footnote-separate-numbering).separate-numbering

    let fields = get-default-footnote(
      num-pattern: footnote-num-pattern,
      ref-pattern: footnote-ref-pattern,
    ) + if separate-numbering {
      ( _counter: fn-ctr )
    }

    show: e.set_(example,
      ..get-default-footnote(
            num-pattern: footnote-num-pattern,
            ref-pattern: footnote-ref-pattern,
      ) + if separate-numbering {
        ( _counter: fn-ctr )
      }
    )

    show: e.set_(subexample,
      ..get-default-footnote(
            ref-pattern: footnote-ref-pattern,
      ) + if separate-numbering {
        ( _counter: fn-ctr )
      }
    )

    // update the counter at the beginning of each footnote
    if separate-numbering {
      fn-ctr.update(0)
    }
  //   config-state.update(fn-config)

  it

  //   config-state.update(config)
  }

  show ref: {
    if smart-refs == auto or smart-refs {
      parse-ref
    } else {
      it => it
    }
  }

  it
}
