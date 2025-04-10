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
helical_pitch = flex_length / helical_cut_count;
recess_depth = 1.5;
recess_diameter = coupling_diameter - 2;

// Helical cut approximation
module helical_cut() {
    for (i = [0 : 360 * helical_cut_count - 1 : 10]) {
        angle = i;
        z = clamp_length + (angle / 360) * helical_pitch;
        x = (coupling_diameter / 2) * cos(angle);
        y = (coupling_diameter / 2) * sin(angle);
        translate([x, y, z])
            rotate([0, 0, angle])
                rotate([90, 0, 0])
                    cube([slit_width, coupling_diameter, 2], center = true);
    }
}

// Main coupling body
module coupling_body() {
    difference() {
        union() {
            // Full body
            cylinder(h = coupling_length, d = coupling_diameter);

            // Recessed ends
            translate([0, 0, 0])
                cylinder(h = recess_depth, d = recess_diameter);

            translate([0, 0, coupling_length - recess_depth])
                cylinder(h = recess_depth, d = recess_diameter);

            // Helical cuts
            helical_cut();
        }

        // Slits on both ends
        translate([0, -slit_width / 2, 0])
            cube([coupling_diameter, slit_width, clamp_length + 1], center = false);

        translate([0, -slit_width / 2, coupling_length - clamp_length - 1])
            cube([coupling_diameter, slit_width, clamp_length + 1], center = false);

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
