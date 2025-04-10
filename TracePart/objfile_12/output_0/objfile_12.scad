```scad
// Parameters
hub_diameter = 40;
hub_length = 30;
bore_diameter = 10;
flange_thickness = 5;
flange_diameter = 50;
screw_hole_diameter = 3;
screw_count = 6;
groove_count = 3;
groove_depth = 2;
groove_width = 2;
bellows_length = 20;
bellows_diameter = 30;
screw_length = 8;
screw_head_diameter = 5;

// Modules
module coupling_hub() {
    difference() {
        union() {
            // Main body
            cylinder(d=hub_diameter, h=hub_length - flange_thickness, $fn=100);
            // Flange
            translate([0, 0, hub_length - flange_thickness])
                cylinder(d=flange_diameter, h=flange_thickness, $fn=100);
        }
        // Bore
        translate([0, 0, -1])
            cylinder(d=bore_diameter, h=hub_length + 2, $fn=100);
        // Slit
        translate([-hub_diameter/2, -1, 0])
            cube([hub_diameter, 2, hub_length]);
        // Screw holes in flange
        for (i = [0 : 360/screw_count : 360 - 360/screw_count]) {
            angle = i;
            x = (flange_diameter/2 - 5) * cos(angle);
            y = (flange_diameter/2 - 5) * sin(angle);
            translate([x, y, hub_length - flange_thickness])
                rotate([90, 0, 0])
                    cylinder(d=screw_hole_diameter, h=flange_thickness + 2, $fn=30);
        }
        // Grooves
        for (i = [1 : groove_count]) {
            z = i * (hub_length - flange_thickness) / (groove_count + 1);
            translate([0, 0, z])
                cylinder(d=hub_diameter + 1, h=groove_width, $fn=100);
        }
    }
}

module bellows() {
    // Simplified bellows as a corrugated cylinder
    for (i = [0 : 1 : 5]) {
        translate([0, 0, i * 3])
            cylinder(d=(i % 2 == 0) ? bellows_diameter : bellows_diameter - 5, h=3, $fn=100);
    }
}

module clamping_screw() {
    union() {
        cylinder(d=screw_head_diameter, h=2, $fn=30); // head
        translate([0, 0, 2])
            cylinder(d=screw_hole_diameter, h=screw_length, $fn=30); // shaft
    }
}

// Assembly
module coupling_assembly() {
    // First hub
    coupling_hub();

    // First set of screws
    for (i = [0 : 360/screw_count : 360 - 360/screw_count]) {
        angle = i;
        x = (flange_diameter/2 - 5) * cos(angle);
        y = (flange_diameter/2 - 5) * sin(angle);
        translate([x, y, hub_length - flange_thickness])
            rotate([90, 0, angle])
                clamping_screw();
    }

    // Bellows
    translate([0, 0, hub_length])
        bellows();

    // Second hub
    translate([0, 0, hub_length + bellows_length])
        coupling_hub();

    // Second set of screws
    for (i = [0 : 360/screw_count : 360 - 360/screw_count]) {
        angle = i;
        x = (flange_diameter/2 - 5) * cos(angle);
        y = (flange_diameter/2 - 5) * sin(angle);
        translate([x, y, hub_length + bellows_length + hub_length - flange_thickness])
            rotate([90, 0, angle])
                clamping_screw();
    }
}

// Render the full assembly
coupling_assembly();
```

