#import "colors.typ": *

// These counters act as "numbered" flags for theorem-box.
// Actual numbering uses per-chapter figure counting, so counter values are unused.
#let theorem-counter = counter("theorem")
#let definition-counter = counter("definition")
#let lemma-counter = counter("lemma")
#let corollary-counter = counter("corollary")
#let proposition-counter = counter("proposition")
#let example-counter = counter("example")
#let remark-counter = counter("remark")
#let exercise-counter = counter("exercise")
#let proof-counter = counter("proof")

#let bindings = ("da": (
  "Proof": "Bevis",
  "Theorem": "Sætning",
  "Definition": "Definition",
  "Lemma": "Lemma",
  "Corollary": "Korollar",
  "Proposition": "Proposition",
  "Example": "Eksempel",
  "Remark": "Bemærkning",
  "Exercise": "Opgave",
  "Solution": "Løsning",
  "Note": "Note",
  "Warning": "Advarsel",
), "en": (
  "Proof": "Proof",
  "Theorem": "Theorem",
  "Definition": "Definition",
  "Lemma": "Lemma",
  "Corollary": "Corollary",
  "Proposition": "Proposition",
  "Example": "Example",
  "Remark": "Remark",
  "Exercise": "Exercise",
  "Solution": "Solution",
  "Note": "Note",
  "Warning": "Warning",
))

#let translate(key) = context {
  let lang = text.lang
  let lang-dict = bindings.at(lang, default: bindings.en)
  lang-dict.at(key, default: key)
}

// Base function for creating theorem-like environments with DTU styling.
//
// Numbering strategy (fixes the counter/ref mismatch):
//   Both the in-box display and the @ref numbering-fn use identical per-chapter
//   counting logic, counting figures of the same `kind` that fall within the
//   same top-level chapter as the current element.  This guarantees they always
//   agree, with no separate custom counter that can drift.
#let theorem-box(
  title: "",
  name: "",
  fill-color: white,
  stroke-color: black,
  stroke-width: 4pt,
  __counter: none, // non-none means "number this box"
  name-in-ref: false, // when true: @ref renders as "Supplement X.Y (name)"
  body,
) = {
  //show figure: set block(breakable: true)
  let translated-title = translate(title)

  // ── In-box number display ─────────────────────────────────────────────────
  // Evaluated lazily (context) inside the figure body so that the figure has
  // already been registered by the time we query for it.
  let number = if __counter != none {
    context {
      let headings = counter(heading).at(here())
      let chapter-depth = calc.min(2, headings.len())
      let chap-prefix = headings.slice(0, chapter-depth)
      let prefix-str = chap-prefix.map(str).join(".")

      // Figures of this kind whose start location is before the current point
      // (which is inside the body, i.e. after the figure's own start location,
      // so the current figure itself IS included in this query).
      let figs-here = query(selector(figure.where(kind: title)).before(here()))

      let chapter-count = figs-here.filter(f => {
        let fh = counter(heading).at(f.location())
        fh.slice(0, calc.min(chapter-depth, fh.len())) == chap-prefix
      }).len()

      prefix-str + "." + str(chapter-count)
    }
  } else { "" }

  let display-title = if name == "" {
    translated-title + " " + number  
  } else {
    translated-title + " " + number + " (" + name + ")"
  }

  // ── @ref numbering function ───────────────────────────────────────────────
  // Called by Typst with the figure's 1-based sequential index.
  // We look up the figure's location and apply the exact same per-chapter
  // counting logic so the ref always matches the in-box display.
  let numbering-fn = if __counter != none {
    (..args) => context {
      let n = args.pos().first() - 1 // 0-based
      let figs = query(figure.where(kind: title))
      if figs.len() > n {
        let fig-loc = figs.at(n).location()
        let headings = counter(heading).at(fig-loc)
        let chapter-depth = calc.min(2, headings.len())
        let chap-prefix = headings.slice(0, chapter-depth)
        let prefix-str = chap-prefix.map(str).join(".")

        // Count figures of this kind in the same chapter up to and including
        // this figure (slice gives indices 0..n inclusive).
        let chapter-count = figs.slice(0, n + 1).filter(f => {
          let fh = counter(heading).at(f.location())
          fh.slice(0, calc.min(chapter-depth, fh.len())) == chap-prefix
        }).len()

        let num-str = prefix-str + "." + str(chapter-count)
        if name-in-ref and name != "" { num-str + " (" + name + ")" } else { num-str }
      }
    }
  } else { none }

  figure(kind: title, supplement: translated-title, numbering: numbering-fn, align(left, block(
    width: 100%,
    fill: fill-color,
    stroke: (left: stroke-width + stroke-color),
    inset: (left: 1.2em, right: 1em, top: 1em, bottom: 1em),
    breakable: true,
    {
      set par(justify: true, first-line-indent: 0em)
      set enum(numbering: "(i)")
      //set math.equation(numbering: none)
      [
        #text(weight: "bold", fill: stroke-color, size: 11pt)[#display-title]
        #v(0.5em)
        #body
      ]
    },
  )))
}

#let theorem(body, title: none) = theorem-box(
  title: "Theorem",
  name: if title != none { title } else { "" },
  fill-color: dtu-light-gray.lighten(50%),
  stroke-color: dtu-red,
  __counter: theorem-counter,
  body,
)

#let definition(body, title: none) = theorem-box(
  title: "Definition",
  name: if title != none { title } else { "" },
  fill-color: dtu-light-gray.lighten(50%),
  stroke-color: dtu-blue,
  __counter: definition-counter,
  body,
)

#let lemma(body, title: none) = theorem-box(
  title: "Lemma",
  name: if title != none { title } else { "" },
  fill-color: dtu-light-gray.lighten(50%),
  stroke-color: dtu-purple,
  __counter: lemma-counter,
  body,
)

#let corollary(body, title: none) = theorem-box(
  title: "Corollary",
  name: if title != none { title } else { "" },
  fill-color: dtu-green.lighten(85%),
  stroke-color: dtu-dark-green,
  __counter: corollary-counter,
  body,
)

#let proposition(body, title: none) = theorem-box(
  title: "Proposition",
  name: if title != none { title } else { "" },
  fill-color: dtu-yellow.lighten(85%),
  stroke-color: dtu-orange,
  __counter: proposition-counter,
  body,
)

#let example(body, title: none) = theorem-box(
  title: "Example",
  name: if title != none { title } else { "" },
  fill-color: dtu-light-gray.lighten(95%),
  stroke-color: dtu-green.darken(10%),
  __counter: example-counter,
  body,
)

#let remark(body, title: none) = theorem-box(
  title: "Remark",
  name: if title != none { title } else { "" },
  fill-color: dtu-light-gray.lighten(80%),
  stroke-color: dtu-dark-gray,
  __counter: remark-counter,
  body,
)

#let exercise(body, title: none) = theorem-box(
  title: "Exercise",
  name: if title != none { title } else { "" },
  fill-color: dtu-teal.lighten(85%),
  stroke-color: dtu-teal,
  __counter: exercise-counter,
  body,
)

// proof now uses theorem-box so it shares the same box style, counter
// infrastructure, and ref numbering as every other environment.
//
// Parameters
//   title:     Short description of what is proved. Shown in parentheses in the
//              header: "Bevis X.Y (title):".
//   sec_title: When supplied, this becomes the parenthetical name in the header
//              instead of `title`, and `title` (the formal claim) is displayed
//              as an italic line at the top of the proof body.
//              This is the old "Egenpar af Markov-matricer" pattern.
#let proof(body, title: none, sec_title: auto) = {
  // Determine whether we have a separate formal claim to display
  let has-claim = (sec_title != auto) and (sec_title != none) and (title != none)

  let name = if (sec_title != auto) and (sec_title != none) {
    sec_title
  } else if title != none {
    title
  } else {
    ""
  }

  theorem-box(
    title: "Proof",
    name: name,
    fill-color: rgb("#fafafa"),
    stroke-color: dtu-dark-blue,
    stroke-width: 3pt,
    __counter: proof-counter,
    name-in-ref: false,
    {
      // When both a formal claim (title) and a readable label (sec_title) are
      // given, display the formal claim in italics before the proof body.
      if has-claim [
        #text(style: "italic")[_Påstand:_ #title]
        #v(0.3em)
      ]
      body
      [#h(1fr) $square$]
      // QED square, right-aligned
    },
  )
}

#let solution(body, title: none) = {
  let sol-title = translate("Solution")
  block(
    width: 100%,
    fill: dtu-blue.lighten(95%),
    stroke: (left: 4pt + dtu-blue),
    inset: (left: 1.2em, right: 1em, top: 1em, bottom: 1em),
    breakable: true,
    [
      #set par(first-line-indent: 0em, justify: false)
      #text(weight: "bold", fill: dtu-blue, size: 11pt)[#sol-title#if title != none [: #title]:]
      #v(0.5em)
      #body
    ],
  )
}

#let custom-theorem(body, title: none, number: none, fill-color: white, stroke-color: black) = {
  let translated-title = if title != none { translate(title) } else { "" }
  let display-number = if number != none { " " + str(number) } else { "" }
  let display-name = translated-title + display-number
  theorem-box(title: display-name, name: "", fill-color: fill-color, stroke-color: stroke-color, __counter: none, body)
}

#let note(body, title: none) = theorem-box(
  title: "Note",
  name: if title != none { title } else { "" },
  fill-color: dtu-light-gray.lighten(80%),
  stroke-color: dtu-dark-gray,
  __counter: none,
  body,
)

#let warning(body, title: none) = theorem-box(
  title: "Warning",
  name: if title != none { title } else { "" },
  fill-color: dtu-red.lighten(90%),
  stroke-color: dtu-red,
  __counter: none,
  body,
)
