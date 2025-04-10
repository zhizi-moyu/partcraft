
// Parameters
plate_size = 40;
plate_thickness = 2;
corner_radius = 3;
hole_diameter = 4;

// Module for rounded square
module rounded_square_plate(size, thickness, radius, hole_d) {
    difference() {
        // Rounded square base
        minkowski() {
            cube([size - 2*radius, size - 2*radius, thickness], center=true);
            cylinder(r=radius, h=0.01, center=true);
        }
        // Central hole
        translate([0, 0, -thickness])
            cylinder(h=3*thickness, d=hole_d, center=true);
    }
}

// Render the plate
rounded_square_plate(plate_size, plate_thickness, corner_radius, hole_diameter);

