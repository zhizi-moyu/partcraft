
// Parameters
base_length = 60;
base_width = 10;
base_height = 4;

vertical_height = 40;
vertical_thickness = 4;

pin_radius = 3;
pin_height = 6;

pin_offset_from_end = 15; // Distance from the end of the base arm to the center of the pin

module base_arm() {
    cube([base_length, base_width, base_height]);
}

module vertical_arm() {
    translate([0, 0, base_height])
        cube([vertical_thickness, base_width, vertical_height]);
}

module pivot_pin() {
    translate([pin_offset_from_end, base_width/2, -pin_height])
        rotate([90, 0, 0])
            cylinder(h = pin_height, r = pin_radius, $fn=50);
}

module full_model() {
    union() {
        base_arm();
        vertical_arm();
        pivot_pin();
    }
}

full_model();


