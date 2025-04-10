
$fn = 100; // Smoothness

// Module: Input/Output Shaft Hub
module shaft_hub() {
    difference() {
        cylinder(h = 15, d = 30);
        translate([0, 0, -1])
            cylinder(h = 17, d = 8); // Central bore
    }
}

// Module: Internal Gear Ring (simplified teeth)
module internal_gear_ring() {
    difference() {
        cylinder(h = 5, d = 40);
        translate([0, 0, -1])
            cylinder(h = 7, d = 30); // Inner cut to fit hub
    }
}

// Module: External Gear Sleeve (simplified external teeth)
module external_gear_sleeve() {
    difference() {
        cylinder(h = 20, d = 40);
        translate([0, 0, -1])
            cylinder(h = 22, d = 30); // Inner cut to fit gear rings
    }
}

// Assembly
module flexible_coupling() {
    // Layer 1: Input Shaft Hub
    translate([0, 0, 0])
        shaft_hub();

    // Layer 2: Internal Gear Ring 1
    translate([0, 0, 15])
        internal_gear_ring();

    // Layer 3: External Gear Sleeve
    translate([0, 0, 20])
        external_gear_sleeve();

    // Layer 4: Internal Gear Ring 2
    translate([0, 0, 40])
        internal_gear_ring();

    // Layer 5: Output Shaft Hub
    translate([0, 0, 45])
        shaft_hub();
}

// Render the full model
flexible_coupling();

