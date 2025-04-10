
// Dimensions
base_length = 60;     // Increased for a longer base
base_width = 30;      // Increased for a wider base
base_height = 20;
slope_height = 20;

// Main block
module angled_block() {
    difference() {
        // Full rectangular block
        cube([base_length, base_width, base_height]);

        // Subtract sloped wedge
        translate([0, 0, 0])
            polyhedron(
                points=[
                    [0, 0, base_height],               // 0 - front top left
                    [base_length, 0, 0],               // 1 - front bottom right
                    [base_length, base_width, 0],      // 2 - back bottom right
                    [0, base_width, base_height],      // 3 - back top left
                    [0, 0, 0],                         // 4 - front bottom left
                    [0, base_width, 0],                // 5 - back bottom left
                    [base_length, base_width, base_height] // 6 - back top right (for deeper cut)
                ],
                faces=[
                    [0, 1, 2, 3],  // sloped top face
                    [0, 4, 5, 3],  // left face
                    [1, 2, 5, 4],  // bottom face
                    [0, 1, 4],     // front triangle
                    [3, 2, 6],     // back triangle (deeper cut)
                    [3, 6, 5]      // back face
                ]
            );
    }
}

// Render the block
angled_block();

