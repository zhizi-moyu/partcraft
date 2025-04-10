
// Parameters
block_width = 40;
block_depth = 40;
block_height = 30;

hole_size = 10; // size of the square base of the pyramid
hole_spacing = 20; // center-to-center spacing between holes
hole_height = block_height; // through-hole

module hollow_block() {
    difference() {
        // Main block
        cube([block_width, block_depth, block_height], center = true);

        // Pyramidal holes
        for (x = [-hole_spacing/2, hole_spacing/2])
            for (y = [-hole_spacing/2, hole_spacing/2])
                translate([x, y, 0])
                    pyramid_hole();
    }
}

// Module to create a square pyramidal hole
module pyramid_hole() {
    translate([0, 0, -block_height/2])
        rotate([0, 0, 0])
            linear_extrude(height = hole_height)
                polygon(points=[[ -hole_size/2, -hole_size/2],
                                [  hole_size/2, -hole_size/2],
                                [  hole_size/2,  hole_size/2],
                                [ -hole_size/2,  hole_size/2]],
                        paths=[[0,1,2,3]]);
}

// Render the model
hollow_block();

