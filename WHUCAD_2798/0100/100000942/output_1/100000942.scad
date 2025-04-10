
// Parameters
block_length = 60;
block_width = 30;
block_thickness = 20; // Increased thickness for a more robust appearance
hole_diameter = 6;
hole_radius = hole_diameter / 2;
hole_offset_x = 10; // from each end
hole_center_y = block_width / 2;

// Rounded rectangle module
module rounded_block(length, width, height, radius) {
    minkowski() {
        cube([length - 2*radius, width - 2*radius, height], center = true);
        sphere(r=radius);
    }
}

// Main block with holes
difference() {
    // Rounded rectangular block
    translate([0, 0, 0])
        rounded_block(block_length, block_width, block_thickness, 2);

    // Holes along the longer side (X-axis), centered in Y
    for (x = [hole_offset_x, block_length - hole_offset_x]) {
        translate([x - block_length/2, 0, block_thickness/2])
            rotate([90, 0, 0])
                cylinder(h = block_width + 2, r = hole_radius, $fn=50);
    }
}

