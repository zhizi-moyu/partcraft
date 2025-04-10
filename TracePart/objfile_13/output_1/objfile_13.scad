$fn = 100; // Smoothness

// Module: Input/Output Shaft Hub (shorter and smoother transition)
module shaft_hub() {
    difference() {
        union() {
            // Main hub body
            cylinder(h = 10, d = 30);
            // Slight step for shaft
            translate([0, 0, 10])
                cylinder(h = 3, d = 20);
        }
        // Central bore
        translate([0, 0, -1])
            cylinder(h = 15, d = 8);
    }
}

// Module: Internal Gear Ring (more exposed)
module internal_gear_ring() {
    difference() {
        cylinder(h = 5, d = 40);
        translate([0, 0, -1])
            cylinder(h = 7, d = 30); // Inner cut to fit hub
    }
}

// Module: External Gear Sleeve (wider and centered)
module external_gear_sleeve() {
    difference() {
        cylinder(h = 25, d = 40);
        translate([0, 0, -1])
            cylinder(h = 27, d = 30); // Inner cut to fit gear rings
    }
}

// Assembly
module flexible_coupling() {
    // Layer 1: Input Shaft Hub
    translate([0, 0, 0])
        shaft_hub();

    // Layer 2: Internal Gear Ring 1 (more exposed)
    translate([0, 0, 10])
        internal_gear_ring();

    // Layer 3: External Gear Sleeve (centered)
    translate([0, 0, 15])
        external_gear_sleeve();

    // Layer 4: Internal Gear Ring 2 (more exposed)
    translate([0, 0, 40])
        internal_gear_ring();

    // Layer 5: Output Shaft Hub
    translate([0, 0, 45])
        shaft_hub();
}

// Render the full model
flexible_coupling();
