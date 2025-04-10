
// Parameters
outer_width_top = 40;
outer_depth_top = 25;
outer_height = 40; // Increased height

flange_thickness = 3; // Thicker flanges
flange_extension = 7; // More extended flanges

wall_thickness = 3;

// Inner cavity dimensions (more tapered)
inner_width_top = outer_width_top - 2 * wall_thickness;
inner_depth_top = outer_depth_top - 2 * wall_thickness;
inner_width_bottom = inner_width_top * 0.4; // Increased taper
inner_depth_bottom = inner_depth_top * 0.4; // Increased taper
inner_height = outer_height;

// Main module
module tapered_hollow_block() {
    difference() {
        // Outer block with flanges
        union() {
            // Main body
            cube([outer_width_top, outer_depth_top, outer_height], center=false);

            // Top flange
            translate([-flange_extension, -flange_extension, 0])
                cube([outer_width_top + 2 * flange_extension, outer_depth_top + 2 * flange_extension, flange_thickness]);

            // Bottom flange
            translate([-flange_extension, -flange_extension, outer_height - flange_thickness])
                cube([outer_width_top + 2 * flange_extension, outer_depth_top + 2 * flange_extension, flange_thickness]);
        }

        // Inner tapered cavity
        translate([wall_thickness, wall_thickness, 0])
            linear_extrude(height=inner_height)
                polygon(points=[
                    [0, 0],
                    [inner_width_top, 0],
                    [inner_width_bottom, inner_depth_bottom],
                    [0, inner_depth_bottom]
                ]);
    }
}

// Render the model
tapered_hollow_block();

