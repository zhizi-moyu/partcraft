
// Parameters
plate_size = 40;
plate_thickness = 2;
corner_radius = 3;
hole_diameter = 5; // Slightly enlarged from 4 to 5
groove_depth = 0.4;
groove_margin = 2; // Distance from edge to groove

// Module for rounded square
module rounded_square_plate(size, thickness, radius, hole_d) {
    difference() {
        // Base plate with rounded corners
        minkowski() {
            cube([size - 2*radius, size - 2*radius, thickness], center=true);
            cylinder(r=radius, h=0.01, center=true);
        }

        // Central hole
        translate([0, 0, -thickness])
            cylinder(h=3*thickness, d=hole_d, center=true);

        // Recessed groove near the top surface
        translate([0, 0, thickness/2 - groove_depth/2])
            minkowski() {
                cube([size - 2*groove_margin - 2*radius, size - 2*groove_margin - 2*radius, groove_depth], center=true);
                cylinder(r=radius, h=0.01, center=true);
            }
    }
}

// Render the plate
rounded_square_plate(plate_size, plate_thickness, corner_radius, hole_diameter);

