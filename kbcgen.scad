include <Round-Anything/polyround.scad>

// Parameters
plateThickness=3;

wallHeight=16;
wallThickness=3;
wallRound=1;

keyPlateRound=1;
keyPlateMargin=0.5;

// Key plate
color("#181B39")
translate([0,0,10]) {
    linear_extrude(plateThickness, convexity=10)
        difference(){
            round2d(keyPlateRound,keyPlateRound)
                import(file = "svg/key_plate.svg");
            union() {
                import(file = "svg/key_holes.svg");
                import(file = "svg/screw_holes.svg");
            }
        }
}

// Side wall with connector holes
difference() {
    // Side wall
    linear_extrude(wallHeight, convexity=10)
        difference() {
            offset(delta=keyPlateMargin+wallThickness)
                round2d(keyPlateRound,keyPlateRound)
                    import(file = "svg/bottom_plate.svg");
            offset(delta=keyPlateMargin)
                round2d(keyPlateRound,keyPlateRound)
                    import(file = "svg/bottom_plate.svg");
        }
    union() {
        // USB connector hole
        translate([6*20-1.5, 5.5*20, 3+1])
            rotate([90,0,0]) linear_extrude(10)
                offset(r=2) offset(delta=-2)
                    square([15,8],false);
        // TRRS connector hole
        translate([7*20-1.5, 2.5*20, 3+1+4])
            rotate([0,90,0])
            cylinder(r=4, h=10, center=true);
    }
}

// Bottom plate with screw holes
linear_extrude(plateThickness, convexity=10)
    difference() {
        // Bottom plate
        offset(delta=keyPlateMargin+wallThickness)
            round2d(keyPlateRound,keyPlateRound)
                import(file = "svg/bottom_plate.svg");
        // Screw holes
        import(file = "svg/screw_holes.svg");
    }
