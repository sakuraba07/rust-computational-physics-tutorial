#import "@preview/cetz:0.4.2"

#set page(width: auto, height: auto, margin: 0.5cm)

#cetz.canvas({
  import cetz.draw: *
  
  // Axes
  line((0, 0), (6, 0), mark: (end: ">"))
  content((6, -0.3))[$"Temperature" (T)$]
  line((0, 0), (0, 4), mark: (end: ">"))
  content((-0.8, 4))[$"Magnetization" (m)$]
  
  // Critical Temperature Tc
  let Tc = 3
  line((Tc, 0), (Tc, 4), stroke: (paint: gray, dash: "dashed"))
  content((Tc, -0.4))[$T_c$]
  
  // Curve
  // Simple approximation: m ~ (Tc - T)^beta for T < Tc
  let pts = ()
  for i in range(0, 300) {
    let t = i / 100
    if t < Tc {
      let m = 3.5 * calc.pow(1 - t/Tc, 1/8) // 2D Ising beta = 1/8
      pts.push((t, m))
    } else {
      pts.push((t, 0))
    }
  }
  line(..pts, stroke: (paint: blue, thickness: 2pt))
  
  // Phase labels
  content((1.5, 1))["Ferromagnetic" \ ($m eq.not 0$)]
  content((4.5, 1))["Paramagnetic" \ ($m approx 0$)]
})