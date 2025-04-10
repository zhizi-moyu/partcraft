$fn = 100; // Smoothness

// Parameters
coupling_diameter = 20;
coupling_length = 40;
half_length = coupling_length / 2;
bore_diameter = 8;
set_screw_diameter = 3;
set_screw_head_diameter = 5;
set_screw_depth = 5;
slot_width = 2;
slot_depth = 5;
slot_spacing = 5;
slot_count = 6;

// Main assembly
module flexible_coupling() {
    translate([-half_length, 0, 0]) left_coupling_half();
    central_flexible_element();
    translate([half_length, 0, 0]) right_coupling_half();
}

// Left coupling half
module left_coupling_half() {
    difference() {
        union() {
            cylinder(h = half_length, d = coupling_diameter, center = false);
            // Interlocking profile (semi-circular notch)
            translate([0, 0, half_length - 1])
                rotate([0, 0, 0])
                    cylinder(h = 2, d = coupling_diameter * 0.8, center = true);
        }
        // Bore
        translate([0, 0, -1])
            cylinder(h = half_length + 2, d = bore_diameter, center = false);
        // Set screw hole
        translate([0, coupling_diameter / 2 - 2, half_length / 2])
            rotate([90, 0, 0])
                cylinder(h = set_screw_depth, d = set_screw_diameter, center = true);
        // Set screw head recess
        translate([0, coupling_diameter / 2 - 2, half_length / 2])
            rotate([90, 0, 0])
                cylinder(h = set_screw_depth / 2, d = set_screw_head_diameter, center = true);
    }
}

// Right coupling half (mirror of left)
module right_coupling_half() {
    mirror([1, 0, 0]) left_coupling_half();
}

// Central flexible element with curved slots
module central_flexible_element() {
    for (i = [0 : slot_count - 1]) {
        angle = 360 / slot_count * i;
        rotate([0, 0, angle])
            translate([0, 0, -slot_width / 2])
                flexible_slot();
    }
}

// Slot shape (curved slot for flexibility)
module flexible_slot() {
    difference() {
        cylinder(h = slot_width, d = coupling_diameter + 1, center = true);
        rotate_extrude(angle = 180)
            translate([coupling_diameter / 2 - slot_depth, 0])
                square([slot_depth, slot_width], center = false);
    }
}

// Render the full coupling
flexible_coupling();
