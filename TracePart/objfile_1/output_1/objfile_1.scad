$fn = 100; // Smoothness

// Parameters
hub_diameter = 30;
hub_length = 20;
bore_diameter = 8;
slot_width = 1.2; // Narrower slot
slot_depth = hub_diameter;
jaw_depth = 3; // Shallower jaw depth
jaw_lobes = 3;
insert_length = 10;
insert_diameter = hub_diameter * 0.95;
lobe_radius = 1.5; // Rounded lobe radius

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
        // Clamping slot (narrower and more compact)
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
        // Clamping slot (narrower and more compact)
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
                rounded_lobe(depth, 3, 3);
    }
}

// Jaw Lobes for Insert
module jaw_lobes_profile(depth) {
    angle_step = 360 / jaw_lobes;
    for (i = [0 : jaw_lobes - 1]) {
        rotate([0, 0, i * angle_step])
            translate([insert_diameter/2 - 2, 0, 0])
                rounded_lobe(insert_length, 3, 3);
    }
}

// Rounded lobe shape
module rounded_lobe(height, width, depth) {
    translate([-width/2, -depth/2, 0])
        minkowski() {
            cube([width, depth, height]);
            sphere(r = lobe_radius);
        }
}

// Render the full assembly
flexible_coupling();
