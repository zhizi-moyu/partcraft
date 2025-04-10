
// Parameters
hub_d = 30;
hub_l = 40;
bore_d = 10;
keyway_w = 4;
keyway_d = 2;

flange_d = 50;
flange_t = 5;
bolt_hole_d = 4;
bolt_circle_d = 40;

spacer_t = 2;

bolt_d = 4;
bolt_l = 20;
nut_d = 6;
nut_h = 4;

$fn = 100;

// Modules
module shaft_hub() {
    difference() {
        cylinder(d=hub_d, h=hub_l);
        translate([0, 0, -1])
            cylinder(d=bore_d, h=hub_l + 2);
        translate([-keyway_w/2, bore_d/2, hub_l/2])
            cube([keyway_w, keyway_d, hub_l], center=true);
    }
}

module flange_plate() {
    difference() {
        cylinder(d=flange_d, h=flange_t);
        translate([0, 0, -1])
            cylinder(d=bore_d, h=flange_t + 2);
        for (i = [0:90:270]) {
            angle = i;
            x = bolt_circle_d/2 * cos(angle);
            y = bolt_circle_d/2 * sin(angle);
            translate([x, y, -1])
                cylinder(d=bolt_hole_d, h=flange_t + 2);
        }
    }
}

module spacer_ring() {
    difference() {
        cylinder(d=flange_d, h=spacer_t);
        translate([0, 0, -1])
            cylinder(d=bolt_circle_d - 10, h=spacer_t + 2);
    }
}

module bolt_with_nut() {
    union() {
        cylinder(d=bolt_d, h=bolt_l);
        translate([0, 0, bolt_l])
            cylinder(d=nut_d, h=nut_h, $fn=6);
    }
}

module flange_assembly() {
    flange_plate();
    translate([0, 0, flange_t])
        spacer_ring();
    translate([0, 0, flange_t + spacer_t])
        flange_plate();
    // Bolts
    for (i = [0:90:270]) {
        angle = i;
        x = bolt_circle_d/2 * cos(angle);
        y = bolt_circle_d/2 * sin(angle);
        translate([x, y, -2])
            bolt_with_nut();
    }
}

// Assembly
translate([0, 0, 0])
    shaft_hub(); // input hub

translate([0, 0, hub_l])
    flange_assembly(); // input flange + spacer

translate([0, 0, hub_l + 2 * flange_t + spacer_t])
    flange_assembly(); // output flange + spacer

translate([0, 0, hub_l + 4 * flange_t + 2 * spacer_t])
    shaft_hub(); // output hub


