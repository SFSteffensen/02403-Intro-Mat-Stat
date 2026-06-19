#import "colors.typ": *  
#import "@preview/physica:0.9.8": vb

#let cmd(c) = {
  // insert zero-width break points so long commands wrap inside the cell
  let s = c
  for ch in (".", "(", ")", ",", "_", "=", "[", "]") {
    s = s.replace(ch, ch + "\u{200B}")
  }
  raw(s, lang: "python")
}

// shrink a block equation only when it's wider than its cell
#let fit(it) = layout(size => {
  let m = measure(it)
  if m.width > size.width and m.width > 0pt {
    let r = size.width / m.width
    box(scale(x: r * 100%, y: r * 100%, reflow: true, it))
  } else { it }
})

#let st(..cells) = block(width: 100%, breakable: true)[
  #set text(size: 8.5pt)
  #show raw: set text(size: 8pt)
  #show math.equation.where(block: true): it => fit(it)
  #table(
    columns: (1fr, 1.7fr, 1.5fr, 1.2fr),
    align: left + top,
    inset: 4.5pt,
    stroke: 0.5pt + luma(60%),
    fill: (_, y) => if y == 0 { luma(235) },
    table.header(
      [*Description*], [*Formula*], [*Python command*], [*TI-30XB/XS*],
    ),
    ..cells,
  )
]

// Distribution notation mapping (Book <-> Python)
#let book2py(..rows) = block(width: 100%)[
  #set text(size: 8.5pt)
  #table(
    columns: (auto, 1fr),
    align: left + top,
    inset: 5pt,
    stroke: 0.5pt + luma(70%),
    fill: (_, y) => if y == 0 { luma(238) },
    table.header([*Book*], [*Python*]),
    ..rows,
  )
]


/// Args: 
/// h: height 
/// ..args: content_1, content_2   caption 1, caption, 2
#let grid_figure(h: 25%, ..args) = {

  set rect(stroke: none)

  let args = args.pos()


  assert(args.len() == 2 or args.len() == 4, message: "You must have both figures, and both captions if supplied")


  let content_1 = args.at(0)
  let content_2 = args.at(1)
  
  let caption_1 = args.at(2)
  let caption_2 = args.at(3)
  
  
grid(columns: (1fr, 1fr), align: horizon,
  gutter: 1em, 
    
  figure(
    rect(height: h,
    content_1),
    caption: caption_1
  ),
  
  
  figure(
    rect(height: h,
    content_2),
    caption: caption_2
  ))
}



#let integrate(func, args, bounds) = {
  let idx = 0 
  
  for arg in args {
    let lower = bounds.at(idx)
    let upper = bounds.at(idx+1)
    
 $integral_(#lower)^#upper $ 
   idx = idx + 2
 } 

 $#func.at(0) space.sixth$
   
 for arg in args {
   $upright(d) #arg space.hair$
 }
}



#let ma(v) = vb(math.upright(v))
