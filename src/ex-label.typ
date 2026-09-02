/// Used inside an example to give it a label.
/// Effectively an alias of metadata.
///
/// - l (label): The label.
///
///   *Required*
///
/// -> content
#let ex-label(
  l,
) = {
  assert(type(l) == label, message: "ex-label only accepts labels")
  metadata(l)
}

/// Search content for a label.
/// - If `standard`, search for Typst standard <label> (takes priority)
/// - In any case, search for `ex-label`-generated metadata
#let get-ex-label(content, standard: true) = {
  // find the standard Typst label. assume it is in the end,
  // attaching to one of the two last children (the last might be space)
  if standard {
    let children = if content.has("children") {
      content.children.slice(-2)
    } else {
      (content,)
    }
    for child in children {
      
    }
  }

  // find `ex-label`
  if content.has("children") {
    let label = content.children.find(it => "value" in it.fields() and type(it.value) == std.label)
    if label != none {
      return label.value
    }
  }
}

