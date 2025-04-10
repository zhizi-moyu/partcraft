```scad
$fn = 100;

// Parameters
shaft_d = 20;
shaft_l = 30;
bore_d = 8;

flange_d = 50;
flange_th = 8;
bolt_hole_d = 5;
bolt_circle_d = 40;

spacer_th = 1;
spacer_d = flange_d;

bolt_d = 5;
bolt_l = 20;
nut_d = 8;
nut_th = 4;

// Modules
module shaft() {
    difference() {
        union() {
            cylinder(h = shaft_l, d = shaft_d);
            translate([0, 0, shaft_l])
                cylinder(h = flange_th, d = flange_d);
        }
        translate([0, 0, -1])
            cylinder(h = shaft_l + 2, d = bore_d);
    }
}

module flange_plate() {
    difference() {
        cylinder(h = flange_th, d = flange_d);
        translate([0, 0, -1])
            cylinder(h = flange_th + 2, d = bore_d);
        for (i = [0:90:270]) {
            angle = i;
            x = bolt_circle_d / 2 * cos(angle);
            y = bolt_circle_d / 2 * sin(angle);
            translate([x, y, -1])
                cylinder(h = flange_th + 2, d = bolt_hole_d);
        }
    }
}

module spacer_ring() {
    difference() {
        cylinder(h = spacer_th, d = spacer_d);
        translate([0, 0, -1])
            cylinder(h = spacer_th + 2, d = bore_d);
    }
}

module bolt() {
    union() {
        cylinder(h = bolt_l, d = bolt_d);
        translate([0, 0, bolt_l])
            cylinder(h = 2, d = 7); // hex head
    }
}

module nut() {
    cylinder(h = nut_th, d = nut_d);
}

// Assembly
module coupling() {
    // Input shaft
    shaft();

    // First flange plate
    translate([0, 0, shaft_l])
        flange_plate();

    // Spacer rings
    translate([0, 0, shaft_l + flange_th])
        spacer_ring();
    translate([0, 0, shaft_l + flange_th + spacer_th])
        spacer_ring();

    // Second flange plate
    translate([0, 0, shaft_l + flange_th + 2 * spacer_th])
        flange_plate();

    // Output shaft
    translate([0, 0, shaft_l + 2 * flange_th + 2 * spacer_th])
        rotate([180, 0, 0])
            shaft();

    // Bolts and nuts
    for (i = [0:90:270]) {
        angle = i;
        x = bolt_circle_d / 2 * cos(angle);
        y = bolt_circle_d / 2 * sin(angle);
        // Bolts
        translate([x, y, shaft_l + flange_th + 2])
            rotate([0, 0, 0])
                bolt();
        // Nuts
        translate([x, y, shaft_l - nut_th])
            nut();
        translate([x, y, shaft_l + flange_th + 2 * spacer_th + flange_th + bolt_l])
            nut();
    }
}

coupling();
```

