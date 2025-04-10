
// Parameters
block_length = 40;
block_width = 40;
block_height = 20;
corner_radius = 8; // Increased for smoother curvature

// Rounded top block with smoother transition
module rounded_edge_block() {
    difference() {
        // Smooth top using hull between top and bottom shapes
        hull() {
            // Bottom shape (sharp edges)
            translate([corner_radius, corner_radius, 0])
                cube([block_length - 2*corner_radius, block_width - 2*corner_radius, block_height - corner_radius]);

            // Top shape (rounded)
            translate([corner_radius, corner_radius, block_height - corner_radius])
                minkowski() {
                    cube([block_length - 2*corner_radius, block_width - 2*corner_radius, 0.1]);
                    cylinder(h=corner_radius, r=corner_radius, $fn=64);
                }
        }

        // Cut bottom to ensure sharp bottom edges
        translate([-10, -10, -10])
            cube([block_length + 20, block_width + 20, corner_radius], center=false);
    }
}

// Render the block, aligned flat on the ground
translate([0, 0, 0])
    rounded_edge_block();

