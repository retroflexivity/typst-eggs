#import "@preview/elembic:1.1.1" as e

#let prefix = "eggs07"

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

// from a dictionary containing keys starting with "sub-",
// get a dictionary of only those fields with "sub-" dropped
#let get-sub-fields(dict) = {
  dict.keys()
  .filter(it => it.starts-with("sub-"))
  .map(it => (it.slice(4): dict.at(it))).join()
}

