
// Parameters
tabletop_length = 100;
tabletop_width = 60;
tabletop_thickness = 4;

leg_diameter = 4;
leg_height = 50;

support_bar_length = tabletop_length - 2 * leg_offset;
support_bar_width = 4;
support_bar_height = 4;

leg_offset = 4; // distance from edge to leg center

// Tabletop module: flat rectangular panel with slots for support bars
module tabletop() {
    difference() {
        cube([tabletop_length, tabletop_width, tabletop_thickness]);
        // Slots for support bars
        translate([leg_offset, 10, 0])
            cube([support_bar_length, support_bar_width, tabletop_thickness]);
        translate([leg_offset, tabletop_width - 10 - support_bar_width, 0])
            cube([support_bar_length, support_bar_width, tabletop_thickness]);
    }
}

// Cylindrical table leg
module table_leg() {
    cylinder(h = leg_height, d = leg_diameter, $fn = 32);
}

// Horizontal support bar
module horizontal_support_bar() {
    cube([support_bar_length, support_bar_width, support_bar_height]);
}

// Assemble the table
module table() {
    // Tabletop
    translate([0, 0, leg_height])
        tabletop();

    // Legs at four corners
    translate([leg_offset, leg_offset, 0])
        table_leg();
    translate([tabletop_length - leg_offset, leg_offset, 0])
        table_leg();
    translate([leg_offset, tabletop_width - leg_offset, 0])
        table_leg();
    translate([tabletop_length - leg_offset, tabletop_width - leg_offset, 0])
        table_leg();

    // Support bars beneath the tabletop
    translate([leg_offset, 10, leg_height - support_bar_height])
        horizontal_support_bar();
    translate([leg_offset, tabletop_width - 10 - support_bar_width, leg_height - support_bar_height])
        horizontal_support_bar();
}

// Render the table
table();

