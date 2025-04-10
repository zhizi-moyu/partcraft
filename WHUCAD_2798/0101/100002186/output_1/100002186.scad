```scad
// Parameters
bolt_length = 40;
bolt_radius = 3;
head_height = 6;
head_radius = 5;
hex_radius = 2.5;
hex_depth = 3;
tip_length = 5;

// Bolt shaft
module bolt_shaft() {
    cylinder(h = bolt_length - head_height - tip_length, r = bolt_radius, $fn = 64);
}

// Bolt head with hex socket
module bolt_head() {
    difference() {
        cylinder(h = head_height, r = head_radius, $fn = 64);
        // Recessed hex socket
        translate([0, 0, head_height - hex_depth])
            rotate([0, 0, 0])
                cylinder(h = hex_depth + 0.1, r = hex_radius, $fn = 6);
    }
}

// Conical tip
module bolt_tip() {
    translate([0, 0, -(tip_length)])
        cylinder(h = tip_length, r1 = bolt_radius, r2 = 0, $fn = 64);
}

// Full bolt
module bolt() {
    union() {
        bolt_head();
        translate([0, 0, head_height])
            bolt_shaft();
        translate([0, 0, bolt_length - tip_length])
            bolt_tip();
    }
}

// Render the bolt
bolt();
```
 