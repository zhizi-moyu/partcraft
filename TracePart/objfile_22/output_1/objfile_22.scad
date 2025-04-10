
// Parameters
shaft_d = 20;
shaft_l = 35; // Increased for better alignment
bore_d = 8;
pin_d = 5; // More prominent transverse hole
pin_offset = 7; // Adjusted for better visibility

flange_d = 45; // Increased for better match
flange_th = 6;
bolt_d = 4; // Slightly thicker bolts
bolt_circle_d = 36; // Adjusted for new flange size
bolt_count = 6;

spacer_th = 0.5; // Thinner spacer rings
flex_th = 3;

nut_d = 7; // Enlarged nuts
nut_th = 3;

// Modules
module input_shaft() {
    difference() {
        cylinder(d=shaft_d, h=shaft_l);
        translate([0, 0, shaft_l/2])
            cylinder(d=bore_d, h=shaft_l, center=true);
        translate([-shaft_d/2, 0, shaft_l - pin_offset])
            rotate([0,90,0])
            cylinder(d=pin_d, h=shaft_d + 2); // More visible
    }
}

module output_shaft() {
    translate([0, 0, shaft_l + flange_th*2 + spacer_th*2 + flex_th])
        input_shaft(); // Reuse with correct position
}

module flange_plate() {
    difference() {
        cylinder(d=flange_d, h=flange_th);
        for (i = [0:bolt_count-1]) {
            angle = 360/bolt_count * i;
            x = bolt_circle_d/2 * cos(angle);
            y = bolt_circle_d/2 * sin(angle);
            translate([x, y, 0])
                cylinder(d=bolt_d, h=flange_th + 2);
        }
    }
}

module spacer_ring() {
    difference() {
        cylinder(d=flange_d, h=spacer_th);
        cylinder(d=shaft_d + 2, h=spacer_th + 1);
    }
}

module flexible_element() {
    difference() {
        cylinder(d=flange_d, h=flex_th);
        for (x = [-15:5:15])
            for (y = [-15:5:15])
                if (abs(x) + abs(y) > 0)
                    translate([x, y, 0])
                        cylinder(d=2, h=flex_th + 1);
    }
}

module bolt() {
    union() {
        cylinder(d=bolt_d, h=flange_th*2 + spacer_th*2 + flex_th + 2);
        translate([0, 0, flange_th*2 + spacer_th*2 + flex_th + 2])
            cylinder(d=bolt_d*2, h=2, $fn=6); // hex head
    }
}

module nut() {
    translate([0, 0, -nut_th])
        cylinder(d=nut_d, h=nut_th, $fn=6);
}

// Assembly
module coupling_assembly() {
    input_shaft();
    translate([0, 0, shaft_l]) flange_plate();
    translate([0, 0, shaft_l + flange_th]) spacer_ring();
    translate([0, 0, shaft_l + flange_th + spacer_th]) flexible_element();
    translate([0, 0, shaft_l + flange_th + spacer_th + flex_th]) spacer_ring();
    translate([0, 0, shaft_l + flange_th + spacer_th*2 + flex_th]) flange_plate();
    output_shaft();

    // Bolts and nuts
    for (i = [0:bolt_count-1]) {
        angle = 360/bolt_count * i;
        x = bolt_circle_d/2 * cos(angle);
        y = bolt_circle_d/2 * sin(angle);
        translate([x, y, shaft_l])
            bolt();
        translate([x, y, shaft_l - nut_th])
            nut();
    }
}

// Render the full assembly
coupling_assembly();

