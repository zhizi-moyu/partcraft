```scad
$fn=100;

// Parameters
hub_diameter = 40;
hub_length = 20;
bore_diameter = 10;
jaw_width = 10;
jaw_depth = 5;
jaw_radius = 18;
bolt_hole_diameter = 4;
bolt_circle_radius = 15;
bolt_length = 50;
bolt_head_diameter = 7;
bolt_head_height = 3;
nut_diameter = 7;
nut_height = 3;
insert_thickness = 5;
insert_length = 10;
insert_radius = 18;

// Modules
module hub(mirror=false) {
    rotate([0,0,mirror ? 180 : 0])
    difference() {
        union() {
            cylinder(d=hub_diameter, h=hub_length);
            for(i=[0:2]) {
                rotate([0,0,i*120])
                translate([jaw_radius,0,hub_length - jaw_depth])
                    cube([jaw_width, jaw_width, jaw_depth], center=true);
            }
        }
        // Bore
        translate([0,0,-1])
            cylinder(d=bore_diameter, h=hub_length+2);
        // Bolt holes
        for(i=[0:2]) {
            rotate([0,0,i*120])
            translate([bolt_circle_radius,0,hub_length/2])
                rotate([90,0,0])
                    cylinder(d=bolt_hole_diameter, h=hub_length+10, center=true);
        }
        // Recessed center
        translate([0,0,hub_length-2])
            cylinder(d=hub_diameter/2, h=2);
    }
}

module jaw_insert() {
    for(i=[0:2]) {
        rotate([0,0,i*120])
        translate([insert_radius,0,hub_length])
            cube([insert_thickness, insert_length, jaw_depth], center=true);
    }
}

module bolt() {
    for(i=[0:2]) {
        rotate([0,0,i*120])
        translate([bolt_circle_radius,0,hub_length])
        union() {
            // Shaft
            cylinder(d=bolt_hole_diameter, h=bolt_length);
            // Head
            cylinder(d=bolt_head_diameter, h=bolt_head_height);
        }
    }
}

module nut() {
    for(i=[0:2]) {
        rotate([0,0,i*120])
        translate([bolt_circle_radius,0,hub_length*2 + 2])
            cylinder(d=nut_diameter, h=nut_height, $fn=6);
    }
}

// Assembly
translate([0,0,0]) hub(false); // Left hub
translate([0,0,hub_length]) jaw_insert(); // Jaw inserts
translate([0,0,hub_length*2]) hub(true); // Right hub
bolt(); // Bolts
nut(); // Nuts
```

