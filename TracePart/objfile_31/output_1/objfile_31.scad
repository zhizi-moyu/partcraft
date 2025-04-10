$fn = 100; // Smoothness

// Parameters
body_diameter = 20;
body_length = 30;
bore_diameter = 6;
screw_diameter = 2.5; // Reduced screw size
screw_depth = 8;      // Deeper screw hole
hex_socket_depth = 3; // Added hex socket depth
hex_socket_diameter = 4; // Hex socket diameter
num_helical_cuts = 12; // Increased number of cuts
cut_width = 1.2;       // Slightly narrower for continuity
cut_depth = 4;         // Deeper cuts
cut_spacing = 2.2;     // Tighter spacing for continuity

// Main assembly
module flexible_coupling() {
    difference() {
        // Main body (flattened ends)
        cylinder(h = body_length, d = body_diameter, center = true);

        // Central bore
        translate([0, 0, -body_length/2])
            cylinder(h = body_length, d = bore_diameter, center = false);

        // Helical cuts (approximated as rotated slots)
        for (i = [0:num_helical_cuts - 1]) {
            rotate([0, 0, i * 360 / num_helical_cuts])
                translate([0, body_diameter/2 - cut_depth, -body_length/2 + cut_spacing * i])
                    cube([cut_width, cut_depth, cut_spacing], center = true);
        }

        // Clamping screw holes and hex sockets
        for (z = [-body_length/2 + 2, body_length/2 - 2]) {
            for (angle = [0, 180]) {
                rotate([0, 0, angle])
                    translate([body_diameter/2 - 2, 0, z]) {
                        // Screw hole
                        rotate([90, 0, 0])
                            cylinder(h = screw_depth, d = screw_diameter, center = false);
                        // Hex socket
                        rotate([90, 0, 0])
                            cylinder(h = hex_socket_depth, d = hex_socket_diameter, $fn=6, center = false);
                    }
            }
        }
    }
}

// Render the model
flexible_coupling();