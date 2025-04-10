
// Parameters
base_length = 100;
base_width = 60;
base_thickness = 3;
cutout_length = 60;
cutout_width = 40;

bracket_length = 30;
bracket_height = 20;
bracket_width = 10;

tab_width = 6;
tab_height = 20;
tab_thickness = 3;
hole_diameter = 4;

// Base Frame with detailed cutouts and flanges
module base_frame() {
    difference() {
        union() {
            // Main base
            cube([base_length, base_width, base_thickness]);

            // Side flanges
            translate([0, 0, 0])
                cube([5, base_width, base_thickness + 2]);
            translate([base_length - 5, 0, 0])
                cube([5, base_width, base_thickness + 2]);
        }

        // Central cutout
        translate([(base_length - cutout_length)/2, (base_width - cutout_width)/2, 0])
            cube([cutout_length, cutout_width, base_thickness + 1]);

        // Small slots (example: 2 slots on each side)
        for (i = [0 : 1]) {
            translate([20 + i * 40, 5, 0])
                cube([5, 10, base_thickness + 1]);
            translate([20 + i * 40, base_width - 15, 0])
                cube([5, 10, base_thickness + 1]);
        }

        // Notches
        translate([0, base_width/2 - 2, 0])
            cube([5, 4, base_thickness + 1]);
        translate([base_length - 5, base_width/2 - 2, 0])
            cube([5, 4, base_thickness + 1]);
    }
}

// Sloped Support Bracket with hollow underside
module sloped_support_bracket() {
    difference() {
        // Outer triangular prism
        polyhedron(
            points=[
                [0, 0, 0], // 0
                [bracket_length, 0, 0], // 1
                [bracket_length, bracket_width, 0], // 2
                [0, bracket_width, 0], // 3
                [0, 0, bracket_height], // 4
                [bracket_length, 0, bracket_height] // 5
            ],
            faces=[
                [0, 1, 2, 3],
                [0, 1, 5, 4],
                [1, 2, 5],
                [2, 3, 4, 5],
                [3, 0, 4]
            ]
        );

        // Hollow underside
        translate([5, 2, 0])
            cube([bracket_length - 10, bracket_width - 4, bracket_height - 2]);
    }
}

// Vertical Support Tab with hole
module vertical_support_tab() {
    difference() {
        cube([tab_width, tab_thickness, tab_height]);
        translate([tab_width/2, tab_thickness/2, tab_height/2])
            rotate([90, 0, 0])
            cylinder(h=tab_thickness + 1, r=hole_diameter/2, $fn=30);
    }
}

// Assembly
module assembly() {
    // Base Frame
    base_frame();

    // Sloped Brackets
    translate([5, 0, base_thickness])
        sloped_support_bracket();
    translate([base_length - bracket_length - 5, 0, base_thickness])
        mirror([1, 0, 0])
        sloped_support_bracket();

    // Vertical Support Tab
    translate([(base_length - tab_width)/2, base_width - tab_thickness, base_thickness])
        rotate([90, 0, 0])
        vertical_support_tab();
}

// Render the full assembly
assembly();

