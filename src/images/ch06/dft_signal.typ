#import "@preview/cetz:0.4.2"

#set page(width: auto, height: auto, margin: 1cm)

#cetz.canvas({
    import cetz.draw: *
    
    let f(t) = 0.7 * calc.sin(2 * 3.14 * t) + 0.3 * calc.sin(5 * 3.14 * t)
    
    // Time domain plot
    let t_max = 2.0
    line((0, 0), (t_max + 0.2, 0), mark: (end: ">"), name: "t_axis")
    content("t_axis.end", anchor: "north-west", padding: 0.1)[$t$]
    line((0, -1.2), (0, 1.2), mark: (end: ">"), name: "y_axis")
    content("y_axis.end", anchor: "south-east", padding: 0.1)[$x(t)$]
    
    let domain = range(0, 200).map(x => x/100 * t_max)
    line(..domain.map(t => (t, f(t))), stroke: blue)
    
    // Sampling points
    let n_samples = 15
    for i in range(0, n_samples) {
        let t = i * t_max / n_samples
        let y = f(t)
        line((t, 0), (t, y), stroke: (dash: "dashed", paint: gray))
        circle((t, y), radius: 0.05, fill: red, stroke: none)
    }
    
    // Annotation
    content((1.0, 1.3))[Sampled Signal]
})
