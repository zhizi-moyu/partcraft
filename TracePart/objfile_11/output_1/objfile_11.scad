```scad
// Parameters
body_diameter = 30;
body_height = 30;
groove_width = 1.5;
groove_depth = 2.5; // Deepened grooves
groove_spacing = 6; // Adjusted spacing for better alignment
shaft_diameter = 8; // Reduced diameter
shaft_length = 10;  // Reduced length
set_screw_diameter = 4;
set_screw_length = 6;
set_screw_offset = 6; // Lowered position
set_screw_recess = 1.5; // Recess depth

// Main Assembly
module flexible_coupling() {
    union() {
        // Cylindrical Body with grooves and holes
        difference() {
            cylinder(d=body_diameter, h=body_height, $fn=100);

            // Central hole for shaft
            translate([0, 0, -1])
                cylinder(d=shaft_diameter, h=body_height + 2, $fn=100);

            // Grooves (deeper and sharper)
            for (i = [1:3]) {
                translate([0, 0, i * groove_spacing])
                    rotate_extrude($fn=100)
                        translate([body_diameter/2 - groove_depth, 0])
                            square([groove_depth, groove_width]);
            }

            // Set screw holes (recessed and aligned)
            for (angle = [0, 180]) {
                rotate([0, 0, angle])
                    translate([body_diameter/2 - 1, 0, set_screw_offset])
                        rotate([0, 90, 0])
                            cylinder(d=set_screw_diameter, h=set_screw_length + set_screw_recess, $fn=50);
            }
        }

        // Central Shaft (shorter and thinner)
        translate([0, 0, body_height])
            cylinder(d=shaft_diameter, h=shaft_length, $fn=100);

        // Set Screws (recessed heads)
        for (angle = [0, 180]) {
            rotate([0, 0, angle])
                translate([body_diameter/2 - 1 - set_screw_recess, 0, set_screw_offset])
                    rotate([0, 90, 0])
                        union() {
                            // Screw body
                            cylinder(d=set_screw_diameter, h=set_screw_length, $fn=50);
                            // Recessed head
                            translate([0, 0, -1])
                                cylinder(d=set_screw_diameter + 2, h=1, $fn=50);
                        }
        }
    }
}

// Render the model
flexible_coupling();
```

