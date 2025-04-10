$fn=100;

// Parameters
hub_diameter = 40;
hub_length = 20;
bore_diameter = 10;
flange_thickness = 5;
jaw_length = 10;
jaw_width = 10;
jaw_height = 10;
bolt_hole_diameter = 4;
bolt_circle_radius = 20;
spider_thickness = 10;
spider_lobe_radius = 6;
bolt_length = 20;
bolt_head_diameter = 8;
nut_diameter = 8;
nut_thickness = 4;

// Main Assembly
union() {
    translate([0, 0, 0])
        left_hub();
    translate([0, 0, hub_length + spider_thickness])
        right_hub();
    translate([0, 0, hub_length])
        elastomer_spider();
    bolts_and_nuts();
}

// Left Hub
module left_hub() {
    difference() {
        union() {
            // Main body
            cylinder(d=hub_diameter, h=hub_length);
            // Flange
            translate([0, 0, hub_length - flange_thickness])
                cylinder(d=hub_diameter + 10, h=flange_thickness);
            // Jaws
            for (i = [0:120:360]) {
                rotate([0, 0, i])
                    translate([hub_diameter/2 - jaw_width/2, -jaw_width/2, hub_length])
                        cube([jaw_width, jaw_width, jaw_length]);
            }
        }
        // Bore
        cylinder(d=bore_diameter, h=hub_length + jaw_length);
        // Bolt holes
        for (i = [0:120:360]) {
            rotate([0, 0, i])
                translate([bolt_circle_radius, 0, hub_length - flange_thickness])
                    cylinder(d=bolt_hole_diameter, h=flange_thickness + 1);
        }
    }
}

// Right Hub (mirrored)
module right_hub() {
    mirror([0, 0, 1])
        left_hub();
}

// Elastomer Spider
module elastomer_spider() {
    difference() {
        union() {
            // Central cylinder
            cylinder(d=hub_diameter - 10, h=spider_thickness);
            // Lobes
            for (i = [0:120:360]) {
                rotate([0, 0, i])
                    translate([hub_diameter/2 - spider_lobe_radius, 0, 0])
                        cylinder(r=spider_lobe_radius, h=spider_thickness);
            }
        }
        // Bore
        translate([0, 0, -1])
            cylinder(d=bore_diameter, h=spider_thickness + 2);
    }
}

// Bolts and Nuts
module bolts_and_nuts() {
    for (i = [0:120:360]) {
        angle = i;
        x = bolt_circle_radius * cos(angle);
        y = bolt_circle_radius * sin(angle);
        // Bolt shaft
        translate([x, y, hub_length - flange_thickness])
            rotate([90, 0, 0])
                cylinder(d=bolt_hole_diameter, h=bolt_length);
        // Bolt head (hex)
        translate([x, y, hub_length - flange_thickness])
            rotate([90, 0, 0])
                cylinder(d=bolt_head_diameter, h=2, $fn=6);
        // Nut (hex)
        translate([x, y, hub_length + spider_thickness + flange_thickness - 2])
            rotate([90, 0, 0])
                cylinder(d=nut_diameter, h=nut_thickness, $fn=6);
    }
}
