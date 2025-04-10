
// Module to create a single quarter-cylinder wedge block
module curved_wedge_block() {
    rotate_extrude(angle=90, convexity=10)
        translate([20, 0, 0])
            polygon(points=[[0,0], [0,20], [20,20]]);
}

// Arrange four curved wedge blocks in a circular pattern
module layer_1() {
    for (i = [0:3]) {
        rotate([0, 0, i * 90])
            curved_wedge_block();
    }
}

// Call the layer module to render the model
layer_1();

