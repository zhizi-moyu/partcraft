
// Parameters
fork_arm_length = 40;
fork_arm_thickness = 5;
fork_arm_width = 10;
fork_gap = 10;
fork_base_radius = 7;
fork_base_height = 10;
hole_radius = 2.5;
hole_offset = 5;

pin_block_length = fork_gap;
pin_block_width = fork_arm_width * 2 + fork_gap;
pin_block_height = 10;
pin_shaft_radius = 5;
pin_shaft_height = 20;

// Fork Head
module fork_head() {
    // Base cylinder
    translate([0, 0, 0])
        cylinder(h = fork_base_height, r = fork_base_radius, $fn = 64);

    // Left arm
    translate([-fork_gap/2 - fork_arm_thickness, -fork_arm_width/2, fork_base_height])
        cube([fork_arm_thickness, fork_arm_width, fork_arm_length]);

    // Right arm
    translate([fork_gap/2, -fork_arm_width/2, fork_base_height])
        cube([fork_arm_thickness, fork_arm_width, fork_arm_length]);

    // Holes in arms
    for (x = [-fork_gap/2 - fork_arm_thickness/2, fork_gap/2 + fork_arm_thickness/2])
        translate([x, 0, fork_base_height + hole_offset])
            rotate([90, 0, 0])
                cylinder(h = fork_arm_width + 1, r = hole_radius, $fn = 32);
}

// Pin Head
module pin_head() {
    // Shaft
    translate([0, 0, fork_base_height + fork_arm_length])
        cylinder(h = pin_shaft_height, r = pin_shaft_radius, $fn = 64);

    // Block
    translate([-pin_block_length/2, -pin_block_width/2, fork_base_height + fork_arm_length + pin_shaft_height])
        cube([pin_block_length, pin_block_width, pin_block_height]);

    // Holes in block
    for (y = [-pin_block_width/2 + hole_offset, pin_block_width/2 - hole_offset])
        translate([0, y, fork_base_height + fork_arm_length + pin_shaft_height + pin_block_height/2])
            rotate([0, 90, 0])
                cylinder(h = pin_block_length + 1, r = hole_radius, $fn = 32);
}

// Assembly
fork_head();
pin_head();

