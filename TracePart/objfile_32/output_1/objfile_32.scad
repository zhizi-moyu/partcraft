//scad_start
$fn = 100;

// Parameters
hub_diameter = 20;
hub_length = 15; // Increased for better definition
flexure_length = 30; // Extended for more central coverage
flexure_diameter = 20;
slot_width = 2;
slot_depth = 8; // Increased depth for better flexibility
num_slots = 10; // Increased number of slots
screw_diameter = 3;
screw_length = 8;
screw_offset = 5;
slit_width = 0.5;
hex_socket_diameter = 4; // For hex socket appearance
hex_socket_depth = 2;

// Main assembly
module coupling() {
    // Left hub
    translate([0, 0, 0])
        clamping_hub();

    // Flexure body
    translate([0, 0, hub_length])
        helical_flexure();

    // Right hub
    translate([0, 0, hub_length + flexure_length])
        clamping_hub();

    // Screws
    for (z = [0, hub_length + flexure_length]) {
        translate([0, 0, z])
            clamping_screws();
    }
}

// Clamping hub with slit and screw holes
module clamping_hub() {
    difference() {
        cylinder(h = hub_length, d = hub_diameter);
        // Slit
        translate([-hub_diameter/2, -slit_width/2, 0])
            cube([hub_diameter, slit_width, hub_length]);
        // Screw holes
        for (y = [-screw_offset, screw_offset]) {
            translate([0, y, hub_length/2])
                rotate([90, 0, 0])
                    cylinder(h = hub_diameter, d = screw_diameter);
        }
    }
}

// Helical flexure approximation using rotated slots
module helical_flexure() {
    difference() {
        cylinder(h = flexure_length, d = flexure_diameter);
        for (i = [0:num_slots-1]) {
            angle = i * 360 / num_slots;
            z_pos = i * flexure_length / num_slots;
            rotate([0, 0, angle])
                translate([-flexure_diameter/2, -slot_width/2, z_pos])
                    cube([flexure_diameter, slot_width, slot_depth]);
        }
    }
}

// Clamping screws with hex socket
module clamping_screws() {
    for (y = [-screw_offset, screw_offset]) {
        translate([hub_diameter/2 - 1.5, y, hub_length/2])
            rotate([0, 90, 0]) {
                // Screw body
                cylinder(h = screw_length, d = screw_diameter);
                // Hex socket
                translate([0, 0, screw_length - hex_socket_depth])
                    cylinder(h = hex_socket_depth, d = hex_socket_diameter, $fn=6);
            }
    }
}

// Render the full coupling
coupling();
//scad_end