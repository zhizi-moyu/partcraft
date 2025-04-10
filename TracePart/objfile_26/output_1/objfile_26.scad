$fn = 100; // Smoothness

module shaft_body() {
    difference() {
        union() {
            // Central wider section
            cylinder(h = 10, r1 = 6, r2 = 8, center = false);
            translate([0, 0, 10])
                cylinder(h = 10, r = 8, center = false);
            translate([0, 0, 20])
                cylinder(h = 10, r1 = 8, r2 = 6, center = false);

            // Left section
            translate([0, 0, -30])
                cylinder(h = 10, r = 6, center = false);
            translate([0, 0, -20])
                cylinder(h = 10, r1 = 6, r2 = 6, center = false);
            translate([0, 0, -10])
                cylinder(h = 10, r1 = 6, r2 = 6, center = false);

            // Right section
            translate([0, 0, 30])
                cylinder(h = 10, r = 6, center = false);
            translate([0, 0, 40])
                cylinder(h = 10, r1 = 6, r2 = 6, center = false);
        }

        // Through-holes near both ends
        for (z = [-25, 45]) {
            rotate([90, 0, 0])
                translate([z, 0, 0])
                    cylinder(h = 12, r = 1.2, center = true);
        }

        // Symmetric recessed keying slots on both ends
        for (z = [-28, 48]) {
            for (angle = [0, 90, 180, 270]) {
                rotate([0, 0, angle])
                    translate([5.5, 0, z])
                        cube([1.5, 2, 6], center = true);
            }
        }
    }
}

shaft_body();
