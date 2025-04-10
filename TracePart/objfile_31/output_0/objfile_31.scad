```scad
$fn = 100; // Smoothness

// Parameters
body_diameter = 20;
body_length = 30;
bore_diameter = 6;
screw_diameter = 3;
screw_depth = 5;
num_helical_cuts = 6;
cut_width = 1.5;
cut_depth = 3;
cut_spacing = 3;

// Main assembly
module flexible_coupling() {
    difference() {
        // Main body
        cylinder(h = body_length, d = body_diameter, center = true);

        // Central bore
        translate([0, 0, -body_length/2])
            cylinder(h = body_length, d = bore_diameter, center = false);

        // Helical cuts (approximated as rotated slots)
        for (i = [0:num_helical_cuts - 1]) {
            rotate([0, 0, i * 360 / num_helical_cuts])
                translate([0, body_diameter/2 - cut_depth, -body_length/2 + cut_spacing * i + cut_spacing/2])
                    cube([cut_width, cut_depth, cut_spacing], center = true);
        }

        // Clamping screw holes (2 on each end, 90 degrees apart)
        for (z = [-body_length/2 + 2, body_length/2 - 2]) {
            for (angle = [0, 180]) {
                rotate([0, 0, angle])
                    translate([body_diameter/2 - 2, 0, z])
                        rotate([90, 0, 0])
                            cylinder(h = screw_depth, d = screw_diameter, center = false);
            }
        }
    }
}

// Render the model
flexible_coupling();
```

