#import "colors.typ": * 
#import "@preview/physica:0.9.8": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.3": *
#import "theorems.typ": * 
#show: codly-init

// Yeah so realistically we dont really need all these helper functions. but consider: funny
#let __text(primary, secondary, accent,body) = {
  set text(lang: "da", font: "Arial")
  set par(justify: true, first-line-indent: 1em)

  
  body
}

#let __raw(primary, secondary, accent, body) = {
  show raw: set text(font: "Monaspace Neon")
  
  let latte = (
    base:     rgb("#eff1f5"),
    mantle:   rgb("#e6e9ef"),
    crust:    rgb("#dce0e8"),
    surface0: rgb("#ccd0da"),
    surface1: rgb("#bcc0cc"),
    surface2: rgb("#acb0be"),
    overlay1: rgb("#8c8fa1"),
    subtext0: rgb("#6c6f85"),
    text:     rgb("#4c4f69"),
    lavender: rgb("#7287fd"),
    blue:     rgb("#1e66f5"),
    mauve:    rgb("#8839ef"),
    green:    rgb("#40a02b"),
    peach:    rgb("#fe640b"),
  )

  show: codly-init.with()
  codly(languages: codly-languages)
  codly(
    // Block chrome
    fill:        latte.base,
    zebra-fill:  latte.mantle,
    stroke:      1pt + latte.surface1,
    radius:      0.4em,
    inset:       0.4em,
    // Line numbers
    number-format: (n) => text(fill: latte.overlay1, str(n)),
    // Language badges
    aliases: ("gherkin": "yaml"),
    default-color: latte.lavender,
    lang-fill:     (lang) => lang.color.lighten(85%),
    lang-stroke:   (lang) => 0.5pt + lang.color,
    // Highlights
    highlighted-default-color: latte.peach.lighten(60%),
    highlight-fill:            (color) => color.lighten(75%),
    highlight-stroke:          (color) => 0.5pt + color,
  )
  
  body
}

#let __heading(primary, secondary, accent,body) = {
  set heading(numbering: "1.1")
  show heading: set text(font: "Neo Sans Pro", fill: primary)

  let heading_colours = (primary, secondary, accent)

  show heading: it => {
    if it.level > 3 {
      text(it.body, fill: black)
      linebreak()
    } else {


    if it.level == 2 {
      counter(math.equation).update(0)
    }
    

    text(it, fill: heading_colours.at(it.level - 1 ))
    

    theorem-counter.update(0)
    definition-counter.update(0)
    lemma-counter.update(0)
    corollary-counter.update(0)
    example-counter.update(0)
    exercise-counter.update(0)
    proposition-counter.update(0)
    remark-counter.update(0)
    
  }
}
  

  
  body
}

#let __figure(body) = {

   show figure: set block(breakable: true)
  body
}

#let __math(body) = {

  set math.mat(delim: "[")
  set math.vec(delim: "[")


  set math.equation(numbering: (..nums) =>  {

    let header_numbering = context {

      let headings = counter(heading).at(here())


      if headings.len() > 2 {
      headings =  headings.slice(0,2)
      }
      
      
      headings.map(str).join(".")
  }

    
   "(" + header_numbering + "."  + nums.pos().map(str).join(".") + ")"
  })

  
  
  
  body
}


#let __preamble(doc-title,draft,authors, primary, secondary, accent, body) = {
  set document(title: doc-title) 


  let bg
  if draft {
    bg = context {
      let page_num = here().position().at("page")
      let ctx 
      
      if calc.rem(page_num, 2) == 0 {
        ctx = rotate(-55deg, repeat(text(strong("DRAFT"), size: 20pt, fill: dtu-black.lighten(80%))))
      } else {
        ctx = rotate(55deg, repeat(text(strong("DRAFT"), size: 20pt, fill: dtu-black.lighten(80%))))
      }
      ctx
    } 

    // no worries, im just fucking everything
    // i could tell when my doc stoppe compiling lmao
  }
    
    show ref: it => {
      let el = it.element
      
      if el != none and el.func() == math.equation {
        context {
          let eq_elements = query(it.target)
          
          if eq_elements.len() == 0 {
            return it 
          }
          
          let loc = eq_elements.first().location()
          
          let headings = counter(heading).at(loc)
          if headings.len() > 2 {
            headings = headings.slice(0, 2)
          }
          let h_str = headings.map(str).join(".")
          
          let eq_num = counter(math.equation).at(loc).first()
          
          link(loc)[Ligning (#h_str.#eq_num)]
        }
    } else {
    it
  }
}
 
  
  set page(paper: "a4", background: bg)

  show: __text.with(primary, secondary, accent)
  show: __heading.with(primary, secondary, accent)
  show: __raw.with(primary, secondary, accent)
  show: __figure
  show: __math
  
  
  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    strong(it)
  }



  body
  
}

#let __title_page(
  title,
  draft,
  date, 
  authors,
  group-number,
  logo,
  primary, 
  secondary,
  accent
  ) = {

    let bg = grid(columns: (1fr, 3fr, 3fr), 
        rect(
        height: 100%, 
        width: 100%, 
        fill: primary,
        stroke: none
     ),[] ,
     if logo != "" {
       v(15%)
       image(logo, width: 25%)
      v(90%) 
     }
    ) 

    set page(background: bg)

    set page(foreground: [

      #text("DRAFT", size: 6em, fill: red)
      
    ]) if draft == true 

    set par(first-line-indent: 0em)

    grid(
      columns: (75%, 25%), rows: (3fr, 3fr, 1fr), 
  [
    #v(1fr)
    #h(3em)
    #text(title, fill: dtu-black, font: "Neo Sans Pro", size: 3em) 
    
    #h(3em)
    #if group-number != none {text([#group-number])} 

    #v(2fr)
  ],
  [],

  [
    #v(1fr)
    #rect(stroke: none, fill: primary, width:  40%, height: 10%, radius: (right: 5pt) , align(left, [
      #v(1fr)
      #h(2em)
      #text(font: "Neo Sans Pro",date.display("[day]. [month repr:long] [year]"), fill: primary.lighten(100%), size: 1.3em)

      
      
      #v(1fr)]))],
      [
      ],
      
  grid.cell(colspan: 2, inset: 2em)[

    #v(1fr)
      #grid(
        columns: (1fr,) * calc.min(2, authors.len()),
        row-gutter: 2em,
        
        ..authors.map(author => align(start)[
        #box(width: 80%, repeat("."))
        #v(-0.8em)
        #strong(text(0.8em,author.name)) #text(0.7em, [(#author.id)]) 

      ]),
    )

  #v(1fr)
]
      
  )
}

#let __abstract(abstract) = {

  v(1fr)

  align(center, heading("Abstract", numbering: none, outlined: false))
  align(center, abstract)

  v(1fr)

  pagebreak()
  
}

#let __outline() =  {
  outline(depth: 3)

  pagebreak()

  outline(title: "Figurer", target: figure.where(kind: table).or(figure.where(kind: image)).or(figure.where(kind: raw)))
  
  pagebreak()
}

#let __glossary() = {
  // Glossarium shit

  
  import "@preview/glossarium:0.5.10": * 
  import "glossarium.typ": entry-list

  heading("Glossary", numbering: none, outlined: false)
  linebreak()
  
  
  show: make-glossary

  register-glossary(entry-list)
  
  print-glossary(
    entry-list,
    show-all: true
  )
  

  pagebreak()
}



#let template(
  title: [], 
  date: datetime.today(), 
  authors: (), 
  group-number: 1, 
  abstract: [], 
  logo: "",
  primary: dtu-blue,
  secondary: dtu-purple,
  accent: dtu-dark-blue,
  draft: true,
  glossary: false,
  body) = {
  show: __preamble.with(title, draft,authors, primary, secondary, accent)
    __title_page(title,draft, date, authors, group-number, logo, primary, secondary, accent)

    counter(page).update(1)
    set page(numbering: "I", number-align: right)
    

    if abstract != [] {
       __abstract(abstract)
    }

    __outline()

    if glossary {
      __glossary()
    }
    
    

    counter(page).update(1)
    set page(numbering: "1 аf 1")
    
  body
}


#let vecrow = vecrow.with(delim: "[")
#let jmat = jmat.with(delim: "[")
#let hmat = hmat.with(delim: "[")
#let dmat = dmat.with(delim: "[")
#let vm = math.op("vm")
#let dm = math.op("dm")