
// Locking Key Module (Corrected)
module locking_key() {
    difference() {
        // Main body with asymmetrical profile
        linear_extrude(height = 1.2)  // thinner profile
        polygon(points=[
            [0, 0],         // bottom left
            [6, 0],         // bottom right
            [7, 1.5],       // angled tip
            [6, 3],         // top right
            [3.5, 4],       // top mid
            [2, 3.5],       // curve start
            [1, 2.5],       // curve mid
            [0.5, 1.5]      // back to left
        ]);

        // Subtract a small circle to form the rounded tab
        translate([0.5, 1.5, -0.1])
        cylinder(h = 1.4, r = 0.6, $fn=30);
    }
}

// Render the locking key
locking_key();

