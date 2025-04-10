```scad
// Parameters
rod_width = 2;     // Width of the rectangular rod
rod_depth = 4;     // Depth (thickness) of the rod
leg_height = 30;   // Height of the vertical legs
arc_radius = 10;   // Inner radius of the arc

module u_shaped_bracket() {
    // Left leg
    translate([-(arc_radius + rod_width/2), 0, 0])
        cube([rod_width, rod_depth, leg_height]);

    // Right leg
    translate([(arc_radius - rod_width/2), 0, 0])
        cube([rod_width, rod_depth, leg_height]);

    // Top arc
    translate([0, rod_depth/2, leg_height])
        rotate_extrude(angle = 180)
            translate([arc_radius, 0, 0])
                square([rod_width, rod_depth], center = true);
}

u_shaped_bracket();
```

