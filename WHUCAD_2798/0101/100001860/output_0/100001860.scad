
// Module to create a single curved wedge block
module curved_wedge_block() {
    difference() {
        // Start with a cube that will be cut into a wedge
        cube([20, 20, 20], center=false);
        
        // Subtract a quarter cylinder to create the curved surface
        rotate([0, 0, 0])
        translate([0, 0, 0])
        rotate_extrude(angle=90)
            translate([20, 0, 0])
                square([20, 20]);
    }
}

// Arrange three curved wedge blocks in a circular pattern
module layer_1() {
    for (i = [0:2]) {
        rotate([0, 0, i * 90])
            curved_wedge_block();
    }
}

// Call the layer module to render the model
layer_1();

 
