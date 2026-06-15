#import "@preview/elembic:1.1.1" as e

#import "judge.typ": format-judges
#import "utils.typ": auto-length, prefix, gen-get-function, split-content

// take a matrix of words and assemble it into a gloss grid
#let build-gloss-grid(
  lines,
  styles: (),
  auto-judges: auto,
  before-spacing: auto,
  after-spacing: auto,
  line-spacing: auto,
  word-spacing: auto,
  leading: auto,
  hanging-indent: auto,
) = {
  // transpose a list of lines into a list of columns
  let gloss-units(lines) = lines.at(0).zip(..lines.slice(1))
  let style-units(words, styles) = words
    // parse each word for auto judges
    .map(format-judges.with(auto-judges: auto-judges))
    // apply corresponding styling to each word
    .zip(styles)
    .map(((word, style)) => style(word))

  block(above: before-spacing, below: after-spacing,
    par(hanging-indent: hanging-indent, leading: leading,
      for words in gloss-units(lines) { // note: this is a joining `for`, loop results are appended together
        box(grid(row-gutter: line-spacing, ..style-units(words, styles))) + h(word-spacing)
      }
    )
  )
}

/// Interlinear gloss grid.
///
/// - body (content): Any number of rows of equal length. Rows can be either contents where elements are separated by one or more spaces, or lists.
///
///   *Required*
///
/// - auto-judges (dictionary): A dictionary of characters to convert into judges (keys) and whether to superscript them (values).
///
///   *Default*: ("\*": false, "\#": true, "?": true, "OK": true)
///
/// - word-spacing (length): Horizontal spacing between words in glosses.
///
///   *Default*: 1em
///
/// - line-spacing (length): Vertical spacing between lines in glosses.
///
///   *Default*: current `par.leading`.
///
/// - before-spacing (length): Vertical spacing above glosses (i.e. after the preamble).
///
///   *Default*: current `par.leading`.
///
/// - after-spacing (length): Vertical spacing below glosses (i.e. before the translation).
///
///   *Default*: current `par.leading`.
///
/// - leading (length): Vertical spacing between between blocks of (wrapped) glosses.
///
///   *Default*: current `par.leading`.
///
/// - hanging-indent (length): Horizontal spacing before wrapped gloss lines.
///
///   *Default*: 1em
///
/// - styles (array): List of functions to be applied to each line of glosses.
///   Can be of any length. `gloss-styles[0]` is applied to the first line,
///   `gloss-styles[1]` --- to the second, etc.
///   E.g. ```typst (emph, it => it + [.])``` makes the first line italicized
///   and adds a period to the second line.
///
///   *Default*: ()
///
///
/// -> content
#let gloss = e.element.declare(
  "gloss",
  prefix: prefix,
  doc: "Interlinear gloss grid",
  labelable: false,

  fields: (
    e.field("body", array, required: true, doc: "Any number of rows of equal length. Rows can be either contents where elements are separated by more than one space or lists."),

    // accept lists for legacy support of ()
    e.field("auto-judges", e.types.union(dictionary, array), default: (
      "*": false,
      "#": true,
      "?": true,
      "OK": true,
    ), folds: false, doc: "A dictionary of characters to convert into judges (keys) and whether to superscript them (values)."),

    e.field("word-spacing", length, default: 1em, doc: "Horizontal spacing between words in glosses."),
    e.field("line-spacing", auto-length, doc: "Vertical spacing between lines in glosses. Defaults to `par.leading`."),
    e.field("before-spacing", auto-length, doc: "Vertical spacing above glosses (i.e. after the preamble). Defaults to `par.leading`."),
    e.field("after-spacing", auto-length, doc: "Vertical spacing below glosses (i.e. before the translation). Defaults to `par.leading`."),
    e.field("leading", auto-length, doc: "Vertical spacing between between blocks of (wrapped) glosses. Defaults to `par.leading`."),
    e.field("hanging-indent", length, default: 1em, doc: "Horizontal spacing before wrapped gloss lines."),
    e.field("styles", array, doc: "List of functions to be applied to each line of glosses. Can be of any length. `gloss-styles[0]` is applied to the first line, `gloss-styles[1]` --- to the second, etc. E.g. ```typst (emph, it => it + [.])``` makes the first line italicized and adds a period to the second line."),

    e.field("get-line-spacing", function, synthesized: true, default: () => par.leading),
    e.field("get-before-spacing", function, synthesized: true, default: () => par.leading),
    e.field("get-after-spacing", function, synthesized: true, default: () => par.leading),
  ),

  parse-args: (default-parser, fields: none, typecheck: none) => (args, include-required: false) => {
    let args = if include-required {
      arguments(args.pos(), ..args.named())
    } else if args.pos() == () {
      args
    } else {
      return (false, "element 'sunk': unexpected positional arguments\n  hint: these can only be passed to the constructor")
    }

    default-parser(args, include-required: include-required)
  },

  synthesize: it => gen-get-function(
    it,
    ("line-spacing", par.leading),
    ("before-spacing", par.leading),
    ("after-spacing", par.leading)
  ),

  // split content lines into word arrays.
  // error traces do not go through context (https://github.com/PgBiel/elembic/issues/84), so we must do all the validation here
  construct: constructor => (..args) => {
    // NOTE: we can't control whether split happens on single spaces using a show rule, because we do that in the constructor
    let lines = args.pos().map(split-content)
    assert(lines.len() > 0, message: "at least one gloss line must be present")

    // guard against invalid line lengths
    let length = lines.at(0).len()
    for line in lines {
      assert(line.len() == length, message: "gloss lines have different lengths")
    }

    constructor(..lines, ..args.named())
  },

  display: elem => {
    // fill missing styles with defaults
    let styles = elem.styles
    if styles.len() < elem.body.len() {
      styles += (x => x,) * (elem.body.len() - styles.len())
    }

    build-gloss-grid(
      elem.body,
      styles: styles,
      auto-judges: elem.auto-judges,
      before-spacing: (elem.get-before-spacing)(),
      after-spacing: (elem.get-after-spacing)(),
      line-spacing: (elem.get-line-spacing)(),
      leading: (elem.leading)(),
      word-spacing: elem.word-spacing,
      hanging-indent: elem.hanging-indent,
    )
  }
)
