/// Typesets the content, then adds negative space
/// of the length of this content.
/// Used to add a judge to the left of a text.
///
/// - j (content): The content to typeset
///
///   *Required*
///
/// -> content
#let judge(
  j
) = [#context(h(-measure(j).width))#j]


  // show selected initial characters as corresponding judges
#let format-judges(body, auto-judges: (:)) = {
  if auto-judges.len() == 0 {
    return body
  }
  assert(type(auto-judges) == dictionary, message: "`auto-judges` must be a dictionary")

  let (head, tail) = if type(body) == content and body.has("children") {
    let head-ix = body.children.position(it => it != [ ])
    (body.children.at(head-ix), body.children.slice(head-ix + 1))
  } else {
    (body, ([],))
  }

  if type(head) != content or head.func() not in (text, symbol) {
    return {head; tail.join()}
    // return head.func()
  }

  let escape-special-characters(s) = s.replace(regex("[-\[\]{}()+?.,^$|\\s]"), c => "\\" + c.text)
  let judge-regex(a) = regex("^(" + a.map(escape-special-characters).join("|") + ")+ ?")
  {
    show judge-regex(auto-judges.keys()): it => {
      show " ": ""
      show judge-regex(auto-judges.keys().filter(key => auto-judges.at(key))): super
      judge(it)
    }
    (head)
  }
  tail.join()
}
