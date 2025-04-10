```scad
$fn = 100; // Smoothness

// Parameters
coupling_length = 60;
coupling_diameter = 20;
clamp_length = 10;
flex_length = 40;
screw_diameter = 3;
screw_length = 6;
slit_width = 1;
slit_depth = 10;
helical_cut_count = 4;

// Main coupling body
module coupling_body() {
    difference() {
        union() {
            // Full body
            cylinder(h = coupling_length, d = coupling_diameter);

            // Add helical cuts (simulated as angled slots)
            for (i = [0 : helical_cut_count - 1]) {
                rotate([0, 0, i * 360 / helical_cut_count])
                    translate([0, 0, clamp_length + i * (flex_length / helical_cut_count)])
                        rotate([0, 90, 0])
                            cube([slit_width, coupling_diameter, flex_length / helical_cut_count + 2], center = true);
            }
        }

        // Slits on both ends
        translate([0, 0, 0])
            rotate([0, 0, 0])
                cube([slit_width, coupling_diameter, clamp_length + 1], center = true);

        translate([0, 0, coupling_length])
            rotate([0, 0, 0])
                cube([slit_width, coupling_diameter, clamp_length + 1], center = true);

        // Screw holes (top and bottom)
        for (z = [clamp_length / 2, coupling_length - clamp_length / 2]) {
            for (angle = [0, 90]) {
                rotate([0, 0, angle])
                    translate([coupling_diameter / 2 - 2, 0, z])
                        rotate([90, 0, 0])
                            cylinder(h = screw_length, d = screw_diameter, center = true);
            }
        }
    }
}

// Set screw module
module set_screw() {
    color("gray")
        cylinder(h = screw_length, d = screw_diameter);
}

// Assembly
module flexible_coupling() {
    coupling_body();

    // Top screws
    for (angle = [0, 90]) {
        rotate([0, 0, angle])
            translate([coupling_diameter / 2 - 2, 0, clamp_length / 2])
                rotate([90, 0, 0])
                    set_screw();
    }

    // Bottom screws
    for (angle = [0, 90]) {
        rotate([0, 0, angle])
            translate([coupling_diameter / 2 - 2, 0, coupling_length - clamp_length / 2])
                rotate([90, 0, 0])
                    set_screw();
    }
}

// Render the model
flexible_coupling();
```

