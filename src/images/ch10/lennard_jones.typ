#import "@preview/cetz:0.4.2"

#set page(width: auto, height: auto, margin: 0.5cm)

#cetz.canvas({
  import cetz.draw: *
  
  // Axes
  line((0, 0), (4, 0), mark: (end: ">"))
  content((4, -0.3))[$r / sigma$]
  line((0, -2), (0, 3), mark: (end: ">"))
  content((-0.5, 3))[$V / epsilon$]
  
  // Potential Curve
  let f(r) = 4 * (calc.pow(1/r, 12) - calc.pow(1/r, 6))
  let pts = ()
  for i in range(95, 300) {
    let r = i / 100
    pts.push((r, f(r)))
  }
  line(..pts, stroke: blue + 1.5pt)
  
  // Reference lines
  line((0, 0), (4, 0), stroke: (paint: gray, dash: "dashed"))
  
  // Minimum point label
  let r_min = calc.pow(2, 1/6)
  circle((r_min, -1), radius: 0.05, fill: red)
  content((r_min + 0.5, -1))[$r_min = 2^(1/6) sigma$]
})