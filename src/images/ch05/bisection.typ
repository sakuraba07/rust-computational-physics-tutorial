#import "@preview/cetz:0.4.2"

#set page(width: auto, height: auto, margin: 1cm)

#cetz.canvas({
    import cetz.draw: *
    
    // Function definition
    let f(x) = 0.5 * (x - 2) * (x - 2) * (x - 2) + 0.5 * (x - 2) + 1
    
    // Plotting range
    let x_min = 0
    let x_max = 4.5
    
    // Points
    let a = 0.5
    let b = 3.5
    let c = (a + b) / 2
    
    // Axis
    line((x_min, 0), (x_max, 0), mark: (end: ">"), name: "axis")
    content("axis.end", anchor: "north-west", padding: .1)[$x$]
    
    // Curve
    let domain = range(0, 45).map(x => x/10)
    line(..domain.map(x => (x, f(x))), stroke: blue, name: "f")
    content((4, f(4)), anchor: "west")[$f(x)$]
    
    // Points and vertical lines
    let draw_point(x, label_text, color) = {
        let y = f(x)
        line((x, 0), (x, y), stroke: (dash: "dashed", paint: gray))
        circle((x, y), radius: 0.08, fill: color, stroke: none)
        line((x, 0.1), (x, -0.1), stroke: gray)
        content((x, -0.3))[#label_text]
    }
    
    draw_point(a, $a$, red)
    draw_point(b, $b$, red)
    draw_point(c, $c$, green)
    
    // Intervals
    // line((a, -0.8), (b, -0.8), mark: (start: "|", end: "|"))
    // content(((a+b)/2, -1.0))[Range]
    
    // Signs
    content((a, f(a) - 0.5))[$f(a) < 0$]
    content((b, f(b) + 0.5))[$f(b) > 0$]
    content((c, f(c) + 0.5))[$f(c) > 0$]
    
    // New interval arrow
    line((a, -0.8), (c, -0.8), mark: (start: "|", end: ">"), stroke: red)
    content(((a+c)/2, -1.1))[Next Interval]

})
