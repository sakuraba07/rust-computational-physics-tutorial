#import "@preview/cetz:0.4.2"

#set page(width: auto, height: auto, margin: 1cm)

#cetz.canvas({
    import cetz.draw: *
    
    // Square
    rect((0, 0), (4, 4), stroke: black)
    
    // Quarter Circle
    arc((0, 0), radius: 4, start: 0deg, stop: 90deg, mode: "PIE", fill: blue.lighten(90%), stroke: blue)
    
    // Axis
    line((0, 0), (4.5, 0), mark: (end: ">"))
    content((4.5, 0), anchor: "north")[$x$]
    line((0, 0), (0, 4.5), mark: (end: ">"))
    content((0, 4.5), anchor: "east")[$y$]
    
    // Random points (simulated)
    // We can't generate random numbers in Typst easily without a plugin or external input,
    // so we'll just plot some fixed "random-looking" points.
    
    let points = (
        (0.5, 0.5), (1.2, 3.4), (2.1, 1.1), (3.5, 0.2), (0.8, 2.5),
        (3.1, 3.1), (2.5, 2.8), (1.5, 1.5), (0.2, 3.8), (3.9, 1.5),
        (2.2, 3.5), (1.1, 0.8), (3.3, 2.2), (0.5, 1.9), (2.8, 0.5),
        (1.8, 2.2), (3.6, 3.2), (0.9, 0.3), (1.4, 2.9), (2.6, 1.2),
        // Add more outside points
        (3.5, 3.5), (3.8, 2.5), (2.5, 3.8), (3.2, 2.8)
    )
    
    for p in points {
        let (x, y) = p
        let color = if x*x + y*y <= 16.0 { red } else { black }
        circle((x, y), radius: 0.05, fill: color, stroke: none)
    }
    
    content((2, -0.5))[$r=1$]
    content((-0.5, 2))[$r=1$]
    
    content((2, 2))[Hit]
    content((3.5, 3.5))[Miss]
})
