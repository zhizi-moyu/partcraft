
// Parameters
shaft_diameter = 20;
shaft_length = 25; // Shortened shaft
bore_diameter = 8;
side_hole_diameter = 5;
side_hole_offset = 6; // Adjusted for shorter shaft
side_hole_depth = shaft_diameter / 2 + 2; // ensure it goes through

module input_shaft() {
    difference() {
        // Main shaft body
        cylinder(h = shaft_length, d = shaft_diameter, $fn = 100);

        // Central bore
        translate([0, 0, 0])
            cylinder(h = shaft_length, d = bore_diameter, $fn = 100);

        // Side holes (2x)
        for (angle = [0, 180]) {
            rotate([0, 0, angle])
                translate([shaft_diameter/2, 0, shaft_length/2 - side_hole_offset])
                    rotate([0, 90, 0])
                        cylinder(h = side_hole_depth, d = side_hole_diameter, $fn = 60);
        }
    }
}

// Render the input shaft
input_shaft();

