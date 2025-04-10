
// Parameters
jaw_length = 30;
jaw_width = 30;
jaw_height = 20;
tooth_radius = 5;
tooth_depth = 5;
core_radius = 10;
core_length = 20;
bolt_radius = 2;
bolt_length = 40;
nut_radius = 4;
nut_height = 3;

// Modules
module jaw_block(mirror=false) {
    translate([mirror ? jaw_length : 0, 0, 0])
    mirror([mirror ? 1 : 0, 0, 0])
    difference() {
        cube([jaw_length, jaw_width, jaw_height]);
        
        // Central bore
        translate([jaw_length/2, jaw_width/2, jaw_height/2])
            rotate([90,0,0])
                cylinder(h=jaw_width+2, r=core_radius, center=true);
        
        // Bolt holes
        for (x = [jaw_length*0.25, jaw_length*0.75])
            translate([x, jaw_width/2, 0])
                rotate([90,0,0])
                    cylinder(h=jaw_height+2, r=bolt_radius, center=true);
        
        // Nut recesses
        for (x = [jaw_length*0.25, jaw_length*0.75])
            translate([x, jaw_width/2, jaw_height - nut_height])
                cylinder(h=nut_height+0.1, r=nut_radius, $fn=6);
        
        // Interlocking teeth
        for (i = [0:2]) {
            translate([jaw_length, i*10 + 2.5, jaw_height/2])
                rotate([0,90,0])
                    cylinder(h=tooth_depth, r=tooth_radius, center=true);
        }
    }
}

module central_core() {
    translate([jaw_length/2, jaw_width/2, jaw_height/2])
        rotate([90,0,0])
            cylinder(h=core_length, r=core_radius, center=true);
}

module bolt() {
    union() {
        // Shaft
        cylinder(h=bolt_length, r=bolt_radius);
        // Head
        translate([0,0,bolt_length])
            cylinder(h=2, r=bolt_radius*1.5, $fn=6);
    }
}

module nut() {
    cylinder(h=nut_height, r=nut_radius, $fn=6);
}

// Assembly
module assembly() {
    // Left jaw
    jaw_block(false);
    
    // Right jaw
    translate([jaw_length, 0, 0])
        jaw_block(true);
    
    // Core
    central_core();
    
    // Bolts
    for (x = [jaw_length*0.25, jaw_length*0.75])
        translate([x, jaw_width/2, -10])
            bolt();
    
    // Nuts
    for (x = [jaw_length*0.25, jaw_length*0.75])
        translate([x, jaw_width/2, jaw_height - nut_height])
            nut();
}

// Render the full model
assembly();


