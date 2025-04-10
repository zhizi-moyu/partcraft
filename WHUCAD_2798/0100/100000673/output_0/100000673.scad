
// Locking Key Module
module locking_key() {
    linear_extrude(height = 2)  // consistent thickness
    polygon(points=[
        [0, 0],         // bottom left
        [5, 0],         // bottom right
        [7, 2],         // angled edge
        [6, 5],         // top right
        [3, 6],         // top mid
        [1.5, 5.5],     // rounded tab start
        [0.5, 4],       // rounded tab mid
        [0, 2]          // back to left
    ]);
}

// Render the locking key
locking_key();

