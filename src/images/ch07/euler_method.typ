#import "@preview/cetz:0.4.2"

#set page(width: auto, height: auto, margin: 1cm)

#cetz.canvas({
    import cetz.draw: *
    
    let f(x) = 0.1 * x * x + 0.5
    let df(x) = 0.2 * x
    
    let x0 = 1.0
    let y0 = f(x0)
    let h = 1.5
    let x1 = x0 + h
    let y1_exact = f(x1)
    let y1_euler = y0 + df(x0) * h
    
    // Axis
    line((0, 0), (3.5, 0), mark: (end: ">"), name: "x_axis")
    content("x_axis.end", anchor: "north-west", padding: 0.1)[$t$]
    line((0, 0), (0, 2.5), mark: (end: ">"), name: "y_axis")
    content("y_axis.end", anchor: "south-east", padding: 0.1)[$x(t)$]
    
    // True curve
    let domain = range(0, 30).map(x => x/10)
    line(..domain.map(x => (x, f(x))), stroke: blue, name: "curve")
    content((2.5, f(2.5)), anchor: "south-east", padding: 0.1)[True Solution]
    
    // Euler step (Tangent line)
    line((x0, y0), (x1, y1_euler), stroke: (paint: orange, thickness: 1.5pt), name: "euler")
    
    // Points
    circle((x0, y0), radius: 0.08, fill: black)
    content((x0, y0), anchor: "south-east", padding: 0.2)[$(t_n, x_n)$]
    
    circle((x1, y1_exact), radius: 0.08, fill: blue, stroke: none)
    content((x1, y1_exact), anchor: "south", padding: 0.2)[True]
    
    circle((x1, y1_euler), radius: 0.08, fill: orange, stroke: none)
    content((x1, y1_euler), anchor: "north", padding: 0.2)[Euler]
    
    // Projections and h
    line((x0, 0), (x0, y0), stroke: (dash: "dashed", paint: gray))
    line((x1, 0), (x1, y1_exact), stroke: (dash: "dashed", paint: gray))
    
    line((x0, 0.2), (x1, 0.2), mark: (start: "|", end: "|"))
    content(((x0+x1)/2, 0.4))[$h$]
    
    // Error
    line((x1, y1_euler), (x1, y1_exact), stroke: (paint: red, thickness: 1pt), mark: (start: "|", end: "|"))
    content((x1 + 0.1, (y1_euler + y1_exact)/2), anchor: "west", padding: 0.1)[Error]
})
