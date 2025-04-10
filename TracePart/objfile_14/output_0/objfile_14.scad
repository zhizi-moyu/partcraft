```scad
// Parameters
hub_diameter = 30;
hub_length = 15;
bore_diameter = 10;
keyway_width = 3;
keyway_depth = 2;
cutout_depth = 5;
cutout_width = 10;
spider_thickness = 10;
spider_arm_width = 6;
spider_arm_radius = 12;
pin_diameter = 3;
pin_length = 40;
set_screw_diameter = 2;
set_screw_length = 5;

// Modules
module hub(mirror=false) {
    difference() {
        union() {
            cylinder(d=hub_diameter, h=hub_length, $fn=100);
            // Cutout for spider
            translate([0, -cutout_width/2, hub_length/2 - cutout_depth/2])
                cube([hub_diameter, cutout_width, cutout_depth], center=true);
        }
        // Bore
        translate([0, 0, -1])
            cylinder(d=bore_diameter, h=hub_length+2, $fn=100);
        // Keyway
        translate([-keyway_width/2, 0, 0])
            cube([keyway_width, keyway_depth, hub_length+2], center=true);
        // Set screw hole
        rotate([90, 0, 0])
            translate([0, 0, hub_length/2])
                cylinder(d=set_screw_diameter, h=set_screw_length, $fn=30);
    }
    if (mirror) {
        mirror([1, 0, 0]) {
            children();
        }
    }
}

module spider() {
    difference() {
        union() {
            // Central disk
            cylinder(d=hub_diameter - 2, h=spider_thickness, $fn=100);
            // Arms
            for (i = [0:120:360]) {
                rotate([0, 0, i])
                    translate([spider_arm_radius, -spider_arm_width/2, 0])
                        cube([spider_arm_width, spider_arm_width, spider_thickness]);
            }
        }
        // Pin holes
        for (x = [-5, 5])
            translate([x, 0, -1])
                rotate([90, 0, 0])
                    cylinder(d=pin_diameter, h=hub_diameter+2, $fn=30);
    }
}

module pin() {
    cylinder(d=pin_diameter, h=pin_length, $fn=30);
}

module set_screw() {
    translate([0, 0, -set_screw_length/2])
        cylinder(d=set_screw_diameter, h=set_screw_length, $fn=30);
}

// Assembly
translate([-hub_length, 0, 0])
    hub();

translate([hub_length, 0, 0])
    hub(mirror=true);

translate([0, 0, 0])
    spider();

translate([-5, 0, hub_diameter/2])
    rotate([0, 90, 0])
        pin();

translate([5, 0, hub_diameter/2])
    rotate([0, 90, 0])
        pin();

// Set screws
translate([-hub_length, 0, hub_length/2])
    rotate([0, 90, 0])
        set_screw();

translate([hub_length, 0, hub_length/2])
    rotate([0, 90, 0])
        set_screw();
```

