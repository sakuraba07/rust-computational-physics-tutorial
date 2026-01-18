#import "@preview/cetz:0.4.2"

#set page(width: auto, height: auto, margin: 0.5cm)

#cetz.canvas({
  import cetz.draw: *
  
  // Axes
  line((-4, 0), (4, 0), mark: (end: ">"))
  content((4, -0.3))[$q$]
  line((0, -4), (0, 4), mark: (end: ">"))
  content((-0.3, 4))[$p$]
  
  // Ideal orbit (Circle)
  circle((0, 0), radius: 2.5, stroke: (paint: gray, dash: "dashed"))
  content((2.5, 2.5), [Ideal (Energy Constant)])
  
  // Euler method (Spiraling out - simplified with circle segments)
  // 実際には渦巻きですが、デフォルメして描画します
  let euler_pts = ()
  for i in range(0, 100) {
    let angle = i * 0.1
    let r = 2.5 + i * 0.015
    euler_pts.push((r * calc.cos(angle), r * calc.sin(angle)))
  }
  line(..euler_pts, stroke: red + 1.5pt)
  content((-3, 3.5), [Euler (Energy Drift)], fill: red)
  
  // Symplectic method (Oscillating near orbit)
  // 少しだけ歪んだ円を描画
  let symp_pts = ()
  for i in range(0, 63) {
    let angle = i * 0.1
    let r = 2.5 + 0.1 * calc.sin(angle * 8)
    symp_pts.push((r * calc.cos(angle), r * calc.sin(angle)))
  }
  line(..symp_pts, stroke: blue + 1.5pt, close: true)
  content((0, 0), [Symplectic], fill: blue)
})