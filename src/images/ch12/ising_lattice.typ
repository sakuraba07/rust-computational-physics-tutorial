#import "@preview/cetz:0.4.2"

#set page(width: auto, height: auto, margin: 0.5cm)

#cetz.canvas({
  import cetz.draw: *
  
  let size = 4
  let spacing = 1.5
  
  // Grid lines
  for i in range(0, size) {
    line((i * spacing, 0), (i * spacing, (size - 1) * spacing), stroke: gray + 0.5pt)
    line((0, i * spacing), ((size - 1) * spacing, i * spacing), stroke: gray + 0.5pt)
  }
  
  // Spins
  // Hardcoded simple configuration
  let spins = (
    (1, -1, 1, 1),
    (1, 1, -1, 1),
    (-1, 1, 1, -1),
    (1, -1, -1, 1)
  )
  
  for y in range(0, size) {
    for x in range(0, size) {
      let px = x * spacing
      let py = y * spacing
      let s = spins.at(y).at(x)
      
      // Lattice point
      circle((px, py), radius: 0.2, fill: if s > 0 { red } else { blue })
      
      // Arrow
      if s > 0 {
        line((px, py - 0.4), (px, py + 0.4), stroke: (thickness: 2pt, paint: red), mark: (end: ">"))
      } else {
        line((px, py + 0.4), (px, py - 0.4), stroke: (thickness: 2pt, paint: blue), mark: (end: ">"))
      }
    }
  }
  
  // Legend
  content((spacing * size + 0.5, spacing * size / 2))[
    $arrow.t$ : Spin +1 (Up) \ 
    $arrow.b$ : Spin -1 (Down)
  ]
})
