
$fn=100;

// Parameters
flange_d = 40;
flange_th = 5;
cyl_d = 20;
cyl_h = 20;
slot_w = 6;
slot_depth = 15;
hole_d = 8;
ring_th = 5;
ring_d = 30;
sleeve_th = 2;
groove_depth = 1;
cup_depth = 10;
cup_outer_d = 30;
cup_inner_d = 20;

// Component: Slotted Flange Cylinder
module slotted_flange_cylinder() {
    difference() {
        union() {
            cylinder(h=flange_th, d=flange_d);
            translate([0,0,flange_th])
                cylinder(h=cyl_h, d=cyl_d);
        }
        // Center hole
        translate([0,0,-1])
            cylinder(h=flange_th + cyl_h + 2, d=hole_d);
        // Slots
        for (angle = [0, 180]) {
            rotate([0,0,angle])
                translate([-slot_w/2, cyl_d/2 - slot_w/2, flange_th])
                    cube([slot_w, slot_depth, cyl_h]);
        }
    }
}

// Component: Slotted Inner Sleeve
module slotted_inner_sleeve() {
    difference() {
        union() {
            // Outer sleeve
            cylinder(h=cyl_h, d=cyl_d);
            // Flange
            translate([0,0,cyl_h])
                cylinder(h=flange_th, d=flange_d);
        }
        // Inner bore
        translate([0,0,-1])
            cylinder(h=cyl_h + flange_th + 2, d=cyl_d - 2*sleeve_th);
        // Slots
        for (angle = [0, 180]) {
            rotate([0,0,angle])
                translate([-slot_w/2, cyl_d/2 - slot_w/2, 0])
                    cube([slot_w, slot_depth, cyl_h]);
        }
    }
}

// Component: Flat Flange Cylinder
module flat_flange_cylinder() {
    difference() {
        union() {
            cylinder(h=flange_th, d=flange_d);
            translate([0,0,flange_th])
                cylinder(h=cyl_h, d=cyl_d);
        }
        translate([0,0,-1])
            cylinder(h=flange_th + cyl_h + 2, d=hole_d);
    }
}

// Component: Central Ring
module central_ring() {
    difference() {
        cylinder(h=ring_th, d=ring_d);
        translate([0,0,-1])
            cylinder(h=ring_th + 2, d=hole_d);
    }
}

// Component: Slotted Base Cup
module slotted_base_cup() {
    difference() {
        union() {
            // Outer cup
            cylinder(h=cup_depth, d=cup_outer_d);
            // Raised rim
            translate([0,0,cup_depth])
                cylinder(h=flange_th, d=flange_d);
        }
        // Inner recess
        translate([0,0,1])
            cylinder(h=cup_depth + 1, d=cup_inner_d);
        // Center hole
        translate([0,0,-1])
            cylinder(h=cup_depth + flange_th + 2, d=hole_d);
        // Slots
        for (angle = [0, 180]) {
            rotate([0,0,angle])
                translate([-slot_w/2, cup_outer_d/2 - slot_w/2, 0])
                    cube([slot_w, slot_depth, cup_depth]);
        }
    }
}

// Assembly
module assembly() {
    z = 0;
    // Layer 1: Top slotted flange cylinder
    translate([0,0,z])
        slotted_flange_cylinder();
    z += flange_th + cyl_h;

    // Layer 2: Slotted inner sleeve
    translate([0,0,z])
        slotted_inner_sleeve();
    z += cyl_h + flange_th;

    // Layer 3: Central ring
    translate([0,0,z])
        central_ring();
    z += ring_th;

    // Layer 4: Flat flange cylinder
    translate([0,0,z])
        flat_flange_cylinder();
    z += flange_th + cyl_h;

    // Layer 5: Slotted base cup
    translate([0,0,z])
        slotted_base_cup();
    z += cup_depth + flange_th;

    // Layer 6: Bottom slotted flange cylinder
    translate([0,0,z])
        slotted_flange_cylinder();
}

assembly();


