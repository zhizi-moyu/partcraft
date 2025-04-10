$fn = 100;

// Parameters
shaft_d = 20;
shaft_length = 15;
flange_d = 40;
flange_thickness = 5;
bolt_d = 3;
bolt_head_d = 6;
bolt_head_h = 2;
bolt_spacing_r = 15;
bellows_d = 30;
bellows_length = 20;
bellows_ridges = 5;
bellows_ridge_depth = 2;
bellows_ridge_spacing = bellows_length / bellows_ridges;

// Modules
module shaft_hub() {
    difference() {
        cylinder(h = shaft_length, d = flange_d);
        translate([0, 0, -1])
            cylinder(h = shaft_length + 2, d = shaft_d);
        for (i = [0:2]) {
            angle = i * 120;
            translate([bolt_spacing_r * cos(angle), bolt_spacing_r * sin(angle), -1])
                cylinder(h = shaft_length + 2, d = bolt_d);
        }
    }
}

module flange_plate() {
    difference() {
        cylinder(h = flange_thickness, d = flange_d);
        translate([0, 0, -1])
            cylinder(h = flange_thickness + 2, d = shaft_d);
        for (i = [0:2]) {
            angle = i * 120;
            translate([bolt_spacing_r * cos(angle), bolt_spacing_r * sin(angle), -1])
                cylinder(h = flange_thickness + 2, d = bolt_d);
        }
    }
}

module bolt() {
    union() {
        cylinder(h = flange_thickness + 2, d = bolt_d);
        translate([0, 0, flange_thickness + 2])
            cylinder(h = bolt_head_h, d = bolt_head_d);
    }
}

module nut() {
    cylinder(h = 2, d = bolt_head_d);
}

module bellows() {
    for (i = [0:bellows_ridges - 1]) {
        translate([0, 0, i * bellows_ridge_spacing])
            cylinder(h = bellows_ridge_spacing / 2, d = bellows_d + bellows_ridge_depth);
        translate([0, 0, i * bellows_ridge_spacing + bellows_ridge_spacing / 2])
            cylinder(h = bellows_ridge_spacing / 2, d = bellows_d - bellows_ridge_depth);
    }
}

// Assembly
module coupling() {
    // Left shaft hub
    translate([0, 0, 0])
        shaft_hub();

    // Left flange plate
    translate([0, 0, shaft_length])
        flange_plate();

    // Left bolts and nuts
    for (i = [0:2]) {
        angle = i * 120;
        x = bolt_spacing_r * cos(angle);
        y = bolt_spacing_r * sin(angle);
        translate([x, y, shaft_length])
            bolt();
        translate([x, y, shaft_length + flange_thickness + bolt_head_h])
            nut();
    }

    // Bellows
    translate([0, 0, shaft_length + flange_thickness])
        bellows();

    // Right flange plate
    translate([0, 0, shaft_length + flange_thickness + bellows_length])
        flange_plate();

    // Right bolts and nuts
    for (i = [0:2]) {
        angle = i * 120;
        x = bolt_spacing_r * cos(angle);
        y = bolt_spacing_r * sin(angle);
        translate([x, y, shaft_length + flange_thickness + bellows_length])
            bolt();
        translate([x, y, shaft_length + flange_thickness + bellows_length + flange_thickness + bolt_head_h])
            nut();
    }

    // Right shaft hub
    translate([0, 0, shaft_length + flange_thickness * 2 + bellows_length])
        shaft_hub();
}

// Render the full coupling
coupling();
