#import "@preview/cetz:0.4.2"

#set page(width: auto, height: auto, margin: 1cm)

#cetz.canvas({
    import cetz.draw: *
    
    // Draw contours for f(x,y) = x^2 + y^2
    // Circles centered at (0,0)
    
    let x_center = 0
    let y_center = 0
    
    for r in (0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5) {
        circle((x_center, y_center), radius: r, stroke: gray.lighten(50%))
    }
    
    // Optimization path
    let path = (
        (-3, 2),
        (-2, 0.5),
        (-1, -0.2),
        (-0.2, 0.1),
        (0, 0)
    )
    
    // Draw path
    for i in range(0, path.len() - 1) {
        let p1 = path.at(i)
        let p2 = path.at(i+1)
        line(p1, p2, mark: (end: ">"), stroke: (paint: blue, thickness: 1.5pt))
        circle(p1, radius: 0.05, fill: red, stroke: none)
    }
    circle(path.last(), radius: 0.08, fill: green, stroke: none)
    
    // Labels
    content(path.first(), anchor: "south-east", padding: 0.2)[Start]
    content(path.last(), anchor: "north", padding: 0.2)[Minimum]
    content((2.5, 2.0))[Contour Lines]
    
})
