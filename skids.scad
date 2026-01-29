// Wheelie Training Skids - Quarter-inch steel, sportbike swingarm mount
// Units: inches

// Parameters (tweak these!)
leg_height = 18;          // Total leg length
bend_length = 6;          // Bottom bend section
bend_angle = 10;          // Forward bend in degrees
footplate_size = 4;       // Square footplate
crossbar_width = 16;      // Between legs
mount_hole_dist = 8;      // From bottom to bolt holes
thickness = 0.25;         // Tube/bar thickness

// Single leg (left side)
module leg() {
    // Vertical part (12 inches)
    translate([-crossbar_width/2 + thickness/2, 0, leg_height/2])
        cube([thickness, thickness, leg_height - bend_length], center=true);
    
    // Bent section at bottom
    translate([-crossbar_width/2 + thickness/2, 0, -leg_height/2 + bend_length/2])
        rotate([bend_angle, 0, 0])
        cube([thickness, thickness, bend_length], center=true);
    
    // Footplate
    translate([-crossbar_width/2 + thickness/2, 0, -leg_height/2 - footplate_size/2])
        cube([footplate_size, footplate_size, thickness], center=true);
    
    // Mount holes (two M8, 8" up from bottom)
    for (y = [-mount_hole_dist/2, mount_hole_dist/2]) {
        translate([-crossbar_width/2 + thickness/2, y, leg_height/2 - mount_hole_dist])
            rotate([90, 0, 0])
            cylinder(h=thickness*2, d=0.35, center=true); // ~M8 hole
    }
}

// Right leg (mirror)
module right_leg() {
    mirror([1, 0, 0])
        leg();
}

// Crossbar between legs
module crossbar() {
    translate([0, 0, leg_height - thickness/2])
        cube([crossbar_width, thickness, thickness], center=true);
}

// Full assembly
leg();
right_leg();
crossbar();
