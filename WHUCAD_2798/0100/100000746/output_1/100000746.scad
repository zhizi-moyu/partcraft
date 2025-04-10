```scad
// Parameters
rod_radius = 0.8;       // Radius of the rod (circular cross-section)
leg_height = 20;        // Shorter leg height
arc_radius = 10;        // Inner radius of the arc
leg_angle = 10;         // Outward angle in degrees
segments = 100;         // Smoothness of the arc

module rounded_cylinder(h, r, $fn=segments) {
    // Rounded cylinder using minkowski sum
    minkowski() {
        cylinder(h=h, r=r, $fn=$fn);
        sphere(r=0.4, $fn=$fn);
    }
}

module u_shaped_bracket() {
    // Left leg (angled outward)
    rotate([0, leg_angle, 0])
        translate([-(arc_radius + rod_radius), 0, 0])
            rounded_cylinder(leg_height, rod_radius);

    // Right leg (angled outward)
    rotate([0, -leg_angle, 0])
        translate([(arc_radius + rod_radius), 0, 0])
            rounded_cylinder(leg_height, rod_radius);

    // Top arc (smooth semi-circle)
    translate([0, 0, leg_height])
        rotate([0, 0, 0])
            rotate_extrude(angle = 180, $fn=segments)
                translate([arc_radius, 0, 0])
                    circle(r=rod_radius, $fn=segments);
}

u_shaped_bracket();
```

