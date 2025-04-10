
// Parameters
outer_diameter = 40;
outer_height = 40;

shaft_diameter = 20;
shaft_height = 15;
recess_depth = 5;

// Outer cylinder (main body)
module outer_cylinder() {
    difference() {
        cylinder(d=outer_diameter, h=outer_height, $fn=64);
        // Recessed cavity at the bottom
        translate([0, 0, 0])
            cylinder(d=shaft_diameter, h=recess_depth, $fn=64);
    }
}

// Inner shaft
module inner_shaft() {
    translate([0, 0, -shaft_height])
        cylinder(d=shaft_diameter, h=shaft_height, $fn=64);
}

// Assembly
union() {
    outer_cylinder();
    inner_shaft();
}

