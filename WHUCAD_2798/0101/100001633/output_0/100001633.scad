```scad
// Parameters
tabletop_length = 100;
tabletop_width = 60;
tabletop_thickness = 4;

leg_diameter = 4;
leg_height = 50;

support_bar_length = tabletop_length - 2 * leg_diameter;
support_bar_width = 4;
support_bar_height = 4;

leg_offset = 4; // distance from edge to leg center

module tabletop() {
    difference() {
        cube([tabletop_length, tabletop_width, tabletop_thickness]);
        // Slots for support bars
        translate([leg_offset, (tabletop_width - support_bar_width) / 2, 0])
            cube([support_bar_length, support_bar_width, tabletop_thickness]);
        translate([leg_offset, (tabletop_width - support_bar_width) / 2 - 10, 0])
            cube([support_bar_length, support_bar_width, tabletop_thickness]);
    }
}

module table_leg() {
    cylinder(h = leg_height, d = leg_diameter, $fn = 32);
}

module horizontal_support_bar() {
    cube([support_bar_length, support_bar_width, support_bar_height]);
}

// Assemble the table
module table() {
    // Tabletop
    translate([0, 0, leg_height])
        tabletop();

    // Legs
    translate([leg_offset, leg_offset, 0])
        table_leg();
    translate([tabletop_length - leg_offset, leg_offset, 0])
        table_leg();
    translate([leg_offset, tabletop_width - leg_offset, 0])
        table_leg();
    translate([tabletop_length - leg_offset, tabletop_width - leg_offset, 0])
        table_leg();

    // Support bars
    translate([leg_offset, (tabletop_width - support_bar_width) / 2, leg_height - support_bar_height])
        horizontal_support_bar();
    translate([leg_offset, (tabletop_width - support_bar_width) / 2 - 10, leg_height - support_bar_height])
        horizontal_support_bar();
}

// Render the table
table();
```

