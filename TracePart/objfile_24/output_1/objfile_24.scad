```scad
// Parameters
shaft_d = 25;         // Increased shaft diameter
shaft_l = 20;         // Shortened shaft length
bore_d = 10;

flange_d = 50;        // Increased flange diameter
flange_t = 8;         // Increased flange thickness
bolt_hole_d = 4;
bolt_circle_d = 38;   // Adjusted bolt circle to match flange size

spacer_t = 3;         // Slightly thicker spacer for visibility

bolt_d = 4;
bolt_l = 40;          // Increased bolt length to pass through all layers
nut_d = 7;            // Slightly larger nut diameter
nut_h = 4;            // Increased nut height

// Modules
module shaft() {
    difference() {
        union() {
            cylinder(d=shaft_d, h=shaft_l);
            translate([0, 0, shaft_l - flange_t])
                cylinder(d=flange_d, h=flange_t);
        }
        translate([0, 0, -1])
            cylinder(d=bore_d, h=shaft_l + 2);
    }
}

module flange_plate() {
    difference() {
        cylinder(d=flange_d, h=flange_t);
        translate([0, 0, -1])
            cylinder(d=bore_d, h=flange_t + 2);
        for (i = [0:5]) {
            angle = i * 60;
            x = bolt_circle_d / 2 * cos(angle);
            y = bolt_circle_d / 2 * sin(angle);
            translate([x, y, -1])
                cylinder(d=bolt_hole_d, h=flange_t + 2);
        }
    }
}

module spacer_ring() {
    difference() {
        cylinder(d=flange_d, h=spacer_t);
        translate([0, 0, -1])
            cylinder(d=bore_d, h=spacer_t + 2);
        for (i = [0:5]) {
            angle = i * 60;
            x = bolt_circle_d / 2 * cos(angle);
            y = bolt_circle_d / 2 * sin(angle);
            translate([x, y, -1])
                cylinder(d=bolt_hole_d, h=spacer_t + 2);
        }
    }
}

module bolt_with_nut() {
    union() {
        cylinder(d=bolt_d, h=bolt_l);
        translate([0, 0, bolt_l])
            cylinder(d=nut_d, h=nut_h, $fn=6);
    }
}

// Assembly
module coupling() {
    // Layer 1: Input Shaft
    translate([0, 0, 0])
        shaft();

    // Layer 2: Flange Plates on Input Shaft
    translate([0, 0, shaft_l])
        flange_plate();
    translate([0, 0, shaft_l + flange_t])
        flange_plate();

    // Layer 3: Spacer Ring
    translate([0, 0, shaft_l + 2 * flange_t])
        spacer_ring();

    // Layer 4: Flange Plates on Output Shaft
    translate([0, 0, shaft_l + 2 * flange_t + spacer_t])
        flange_plate();
    translate([0, 0, shaft_l + 3 * flange_t + spacer_t])
        flange_plate();

    // Layer 5: Output Shaft
    translate([0, 0, shaft_l + 4 * flange_t + spacer_t])
        rotate([180, 0, 0])
            shaft();

    // Layer 6: Bolts and Nuts
    for (i = [0:5]) {
        angle = i * 60;
        x = bolt_circle_d / 2 * cos(angle);
        y = bolt_circle_d / 2 * sin(angle);
        translate([x, y, shaft_l])
            bolt_with_nut();
    }
}

// Render the full coupling
coupling();
```
 