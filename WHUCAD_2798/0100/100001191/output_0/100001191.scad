
// Dimensions
base_length = 40;
base_width = 20;
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
                    [0, 0, base_height],               // 0 - front bottom left
                    [base_length, 0, 0],               // 1 - front bottom right
                    [base_length, base_width, 0],      // 2 - back bottom right
                    [0, base_width, base_height],      // 3 - back bottom left
                    [0, 0, 0],                         // 4 - front top left
                    [0, base_width, 0]                 // 5 - back top left
                ],
                faces=[
                    [0, 1, 2, 3],  // bottom face
                    [0, 4, 5, 3],  // left face
                    [1, 2, 5, 4],  // right face
                    [0, 1, 4],     // front triangle
                    [3, 2, 5]      // back triangle
                ]
            );
    }
}

// Render the block
angled_block();

