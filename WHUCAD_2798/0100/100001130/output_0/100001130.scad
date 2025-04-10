
// Parameters
thickness = 5;         // Thickness of the bracket
short_arm = 30;        // Length of the shorter arm
long_arm = 50;         // Length of the longer arm
corner_radius = 5;     // Radius for the rounded outer corner

module L_bracket() {
    difference() {
        union() {
            // Vertical arm (shorter)
            cube([thickness, thickness, short_arm]);

            // Horizontal arm (longer)
            translate([0, 0, -long_arm + thickness])
                cube([thickness, thickness, long_arm]);
        }

        // Cut the outer corner to make it rounded
        translate([-corner_radius, -corner_radius, -long_arm + thickness])
            rotate([0, 90, 0])
                cylinder(h = thickness + 1, r = corner_radius, $fn = 50);
    }
}

// Position the bracket upright as described
rotate([0, 0, 0])
    L_bracket();

