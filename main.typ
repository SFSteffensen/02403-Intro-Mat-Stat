#import "@preview/glossarium:0.5.10": gls, glspl, make-glossary, register-glossary, print-glossary
#import "glossary.typ": glossary-entries
#import "template.typ": *
#import "colors.typ": *
#import "util.typ": grid_figure, ma

#show: make-glossary
#register-glossary(glossary-entries)

#show: template.with(logo: "Blue_CMYK.png", title: "Formulas", draft: false, authors: (
  (name: "Pedersen, Mikkel M.H.", id: "s255015"),
  (name: "Rosendahl-Kaa, Rasmus", id: "s255955"),
  (name: "Steffensen, Sebastian F.", id: "s255609"),
), primary: rgb("#096C1D"), secondary: rgb("#0D9628"), accent: rgb("#11C034"), group-number: "For 02403 Introduction to Mathematical Statistics")


#include "chapters/chapter_one.typ"