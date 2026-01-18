#import "@preview/cetz:0.4.2"

#set page(width: auto, height: auto, margin: 1cm)

#cetz.canvas({
    import cetz.draw: *
    
    let f(x) = 0.2 * (x * x) - 1.5
    let df(x) = 0.4 * x
    
    let x_min = -1
    let x_max = 6
    
    // Axis
    line((x_min, 0), (x_max, 0), mark: (end: ">"), name: "axis")
    content("axis.end", anchor: "north-west", padding: .1)[$x$]
    
    // Curve
    let domain = range(-10, 60).map(x => x/10)
    line(..domain.map(x => (x, f(x))), stroke: blue, name: "f")
    content((5.5, f(5.5)), anchor: "south-west")[$f(x)$]
    
    // Newton Step
    let x0 = 4.5
    let y0 = f(x0)
    let slope = df(x0)
    let x1 = x0 - y0 / slope
    
    // Point x0
    line((x0, 0), (x0, y0), stroke: (dash: "dashed", paint: gray))
    circle((x0, y0), radius: 0.08, fill: red, stroke: none)
    content((x0, -0.3))[$x_n$]
    
    // Tangent line
    // y - y0 = m (x - x0) => y = m(x - x0) + y0
    // find start and end for drawing
    let t_start = 2.0
    let t_end = 5.0
    let tangent_y(x) = slope * (x - x0) + y0
    line((t_start, tangent_y(t_start)), (t_end, tangent_y(t_end)), stroke: orange)
    
    // Point x1 (intersection)
    circle((x1, 0), radius: 0.08, fill: green, stroke: none)
    content((x1, -0.3))[$x_(n+1)$]
    
    // Annotations
    content((x0 + 0.2, y0))[$f(x_n)$]
    
    // Angle arc? simpler to just label tangent
    content((4.8, tangent_y(4.8)), anchor: "west", padding: 0.1)[Tangent slope $f'(x_n)$]

})
