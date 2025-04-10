
// Parameters
block_length = 40;
block_width = 40;
block_height = 20;
corner_radius = 5;

// Rounded top block
module rounded_edge_block() {
    difference() {
        // Main block with extra height for rounding
        minkowski() {
            cube([block_length - 2*corner_radius, block_width - 2*corner_radius, block_height - corner_radius], center=false);
            translate([0, 0, 0])
                cylinder(h=corner_radius, r=corner_radius, $fn=50);
        }
        // Cut bottom to make bottom edges sharp
        translate([-10, -10, -10])
            cube([block_length + 20, block_width + 20, corner_radius], center=false);
    }
}

// Render the block
rounded_edge_block();

