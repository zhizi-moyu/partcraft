
// Parameters
body_diameter = 30;
body_height = 30;
groove_width = 1.5;
groove_depth = 1.5;
groove_spacing = 5;
shaft_diameter = 10;
shaft_length = 15;
set_screw_diameter = 4;
set_screw_length = 6;
set_screw_offset = 8;

// Main Assembly
module flexible_coupling() {
    union() {
        // Cylindrical Body
        difference() {
            cylinder(d=body_diameter, h=body_height, $fn=100);

            // Central hole for shaft
            translate([0, 0, -1])
                cylinder(d=shaft_diameter, h=body_height + 2, $fn=100);

            // Grooves
            for (i = [1:3]) {
                translate([0, 0, i * groove_spacing])
                    cylinder(d=body_diameter + 1, h=groove_width, $fn=100);
            }

            // Set screw holes (2 sides)
            for (angle = [0, 180]) {
                rotate([0, 0, angle])
                    translate([body_diameter/2 - 1, 0, set_screw_offset])
                        rotate([0, 90, 0])
                            cylinder(d=set_screw_diameter, h=set_screw_length, $fn=50);
            }
        }

        // Central Shaft
        translate([0, 0, body_height])
            cylinder(d=shaft_diameter, h=shaft_length, $fn=100);

        // Set Screws
        for (angle = [0, 180]) {
            rotate([0, 0, angle])
                translate([body_diameter/2 - 1, 0, set_screw_offset])
                    rotate([0, 90, 0])
                        cylinder(d=set_screw_diameter, h=set_screw_length, $fn=50);
        }
    }
}

// Render the model
flexible_coupling();


