```scad
$fn = 100; // Smoothness

module shaft_body() {
    difference() {
        union() {
            // Central wider section
            cylinder(h = 20, r = 8, center = true);

            // Left stepped section
            translate([0, 0, -30])
                cylinder(h = 20, r = 6, center = false);
            translate([0, 0, -10])
                cylinder(h = 10, r1 = 6, r2 = 8, center = false);

            // Right stepped section
            translate([0, 0, 10])
                cylinder(h = 10, r1 = 8, r2 = 6, center = false);
            translate([0, 0, 20])
                cylinder(h = 20, r = 6, center = false);
        }

        // Through-holes near both ends
        for (z = [-25, 25]) {
            rotate([90, 0, 0])
                translate([z, 0, 0])
                    cylinder(h = 12, r = 1.2, center = true);
        }

        // Grooves on both ends
        for (z = [-28, 28]) {
            for (angle = [0, 90, 180, 270]) {
                rotate([0, 0, angle])
                    translate([6, 0, z])
                        cube([1, 2, 6], center = true);
            }
        }
    }
}

shaft_body();
```

