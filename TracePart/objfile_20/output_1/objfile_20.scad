
// Parameters
shaft_d = 20;
shaft_l = 120; // Extended shaft for proper spacing

hub_d = 30;
hub_l = 20;
hub_bore_d = 20;
hub_flange_d = 40;
hub_flange_t = 5;
hub_bolt_r = 15;
hub_bolt_d = 4;

flange_d = 40;
flange_t = 5;
flange_bolt_r = 15;
flange_bolt_d = 4;

spacer_t = 2;

bolt_d = 4;
bolt_l = 10; // Shortened bolt
nut_d = 6;
nut_h = 2; // Reduced nut height

// Modules
module central_shaft() {
    color("gray") cylinder(d=shaft_d, h=shaft_l, $fn=100);
}

module hub_with_flange() {
    union() {
        // Main hub body
        difference() {
            color("lightgray") cylinder(d=hub_d, h=hub_l, $fn=100);
            translate([0, 0, -1]) cylinder(d=hub_bore_d, h=hub_l + 2, $fn=100);
        }
        // Flange face
        translate([0, 0, hub_l])
            difference() {
                cylinder(d=hub_flange_d, h=hub_flange_t, $fn=100);
                for (i = [0:3]) {
                    angle = i * 90;
                    x = hub_bolt_r * cos(angle);
                    y = hub_bolt_r * sin(angle);
                    translate([x, y, -1]) cylinder(d=hub_bolt_d, h=hub_flange_t + 2, $fn=50);
                }
            }
    }
}

module flange_plate() {
    difference() {
        color("lightgray") cylinder(d=flange_d, h=flange_t, $fn=100);
        for (i = [0:3]) {
            angle = i * 90;
            x = flange_bolt_r * cos(angle);
            y = flange_bolt_r * sin(angle);
            translate([x, y, -1]) cylinder(d=flange_bolt_d, h=flange_t + 2, $fn=50);
        }
    }
}

module spacer_ring() {
    difference() {
        color("silver") cylinder(d=flange_d, h=spacer_t, $fn=100);
        translate([0, 0, -1]) cylinder(d=shaft_d, h=spacer_t + 2, $fn=100);
    }
}

module bolt() {
    color("dimgray") cylinder(d=bolt_d, h=bolt_l, $fn=30);
}

module nut() {
    color("dimgray") cylinder(d=nut_d, h=nut_h, $fn=6);
}

module bolt_with_nut() {
    union() {
        bolt();
        translate([0, 0, bolt_l]) nut();
    }
}

module flange_assembly() {
    union() {
        flange_plate();
        translate([0, 0, flange_t]) spacer_ring();
        translate([0, 0, flange_t + spacer_t]) flange_plate();
        for (i = [0:3]) {
            angle = i * 90;
            x = flange_bolt_r * cos(angle);
            y = flange_bolt_r * sin(angle);
            translate([x, y, 0]) bolt_with_nut();
        }
    }
}

// Assembly
module coupling_assembly() {
    union() {
        // Central Shaft
        central_shaft();

        // Input Hub
        translate([0, 0, shaft_l]) hub_with_flange();

        // Output Hub
        translate([0, 0, -hub_l - hub_flange_t]) rotate([180, 0, 0]) hub_with_flange();

        // Flange Assembly - Input Side
        translate([0, 0, shaft_l - flange_t * 2 - spacer_t]) flange_assembly();

        // Flange Assembly - Output Side
        translate([0, 0, flange_t * 2 + spacer_t]) rotate([180, 0, 0]) flange_assembly();
    }
}

// Render the full model
coupling_assembly();

