```scad
$fn = 100; // Smoothness

// Parameters
hub_diameter = 30;
hub_length = 20;
bore_diameter = 8;
slot_width = 2;
slot_depth = hub_diameter;
jaw_depth = 5;
jaw_lobes = 3;
insert_length = 10;
insert_diameter = hub_diameter * 0.95;

// Main Assembly
module flexible_coupling() {
    translate([0, 0, hub_length + insert_length])
        left_clamp_hub();
    translate([0, 0, hub_length])
        central_jaw_insert();
    translate([0, 0, 0])
        right_clamp_hub();
}

// Left Clamp Hub
module left_clamp_hub() {
    difference() {
        union() {
            cylinder(h = hub_length, d = hub_diameter);
            jaw_profile(jaw_depth, true);
        }
        // Bore hole
        translate([0, 0, -1])
            cylinder(h = hub_length + 2, d = bore_diameter);
        // Clamping slot
        translate([-slot_width/2, -hub_diameter, hub_length/2])
            cube([slot_width, slot_depth, hub_length], center=true);
    }
}

// Right Clamp Hub (mirror of left)
module right_clamp_hub() {
    difference() {
        union() {
            cylinder(h = hub_length, d = hub_diameter);
            jaw_profile(jaw_depth, false);
        }
        // Bore hole
        translate([0, 0, -1])
            cylinder(h = hub_length + 2, d = bore_diameter);
        // Clamping slot
        translate([-slot_width/2, -hub_diameter, hub_length/2])
            cube([slot_width, slot_depth, hub_length], center=true);
    }
}

// Central Jaw Insert
module central_jaw_insert() {
    difference() {
        union() {
            cylinder(h = insert_length, d = insert_diameter);
            jaw_lobes_profile(jaw_depth);
        }
    }
}

// Jaw Profile for Hubs
module jaw_profile(depth, isLeft=true) {
    angle_step = 360 / jaw_lobes;
    for (i = [0 : jaw_lobes - 1]) {
        rotate([0, 0, i * angle_step])
            translate([hub_diameter/2 - 2, 0, isLeft ? 0 : hub_length - depth])
                cube([4, 4, depth]);
    }
}

// Jaw Lobes for Insert
module jaw_lobes_profile(depth) {
    angle_step = 360 / jaw_lobes;
    for (i = [0 : jaw_lobes - 1]) {
        rotate([0, 0, i * angle_step])
            translate([insert_diameter/2 - 2, 0, 0])
                cube([4, 4, insert_length]);
    }
}

// Render the full assembly
flexible_coupling();
```

