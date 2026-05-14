#import "@preview/elembic:1.1.1" as e

#let auto-length = e.types.union(auto, length)

#let gen-get-function(it, ..args) = {
  for (field, default) in args.pos() {
    it.insert(
      "get-" + field,
      () => if it.at(field) == auto {
        default
      } else { it.at(field) }
    )
  }
  it
}

#let split-content(it, separator: [ ]) = {
  if type(it) == array {
    return it
  }
  assert(type(it) == content)

  // one-word line
  if not it.has("children") {
    return (it,)
  }

  it.children.split(separator).filter(it => it != ()).map([].func())
}

#let prefix = "eggs08"
