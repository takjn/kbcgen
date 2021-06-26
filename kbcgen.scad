include <Round-Anything/polyround.scad>

key_plate="svg/planck/bottom_plate.svg";
key_holes="svg/planck/key_holes.svg";
bottom_plate="svg/planck/bottom_plate.svg";
screw_holes="svg/planck/screw_holes.svg";

// Parameters
plateThickness=3;

innerhegiht=3+2+3;
wallHeight=plateThickness+innerhegiht+plateThickness;
wallThickness=3;
wallRound=1;

keyPlateRound=1;
keyPlateMargin=1.0;

// Key plate
color("#181B39")
translate([0,0,innerhegiht+plateThickness]) {
    linear_extrude(plateThickness, convexity=10)
        difference(){
            round2d(keyPlateRound,keyPlateRound)
                import(file = key_plate);
            union() {
                import(file = key_holes);
                import(file = screw_holes);
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
                    import(file = bottom_plate);
            offset(delta=keyPlateMargin)
                round2d(keyPlateRound,keyPlateRound)
                    import(file = bottom_plate);
        }
    // TODO: clean up
    // union() {
    //     // USB connector hole
    //     translate([6*20-1.5, 5.5*20, 3+1])
    //         rotate([90,0,0]) linear_extrude(10)
    //             offset(r=2) offset(delta=-2)
    //                 square([15,8],false);
    //     // TRRS connector hole
    //     translate([7*20-5, 2.3*20, 3+1])
    //         rotate([90,0,90]) linear_extrude(10)
    //             offset(r=2) offset(delta=-2)
    //                 square([13,8],false);
    // }
    // USB connector hole
    translate([6.62*20, 5.5*20, 3+1])
        rotate([90,0,0]) linear_extrude(30)
            offset(r=2) offset(delta=-2)
                square([13,8],false);
}

// Bottom plate with screw holes
linear_extrude(plateThickness, convexity=10)
    difference() {
        // Bottom plate
        offset(delta=keyPlateMargin+wallThickness)
            round2d(keyPlateRound,keyPlateRound)
                import(file = bottom_plate);
        // Screw holes
        import(file = screw_holes);
    }
