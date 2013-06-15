// New printer MOD by Chema

// X carriage prototype fix
// GNU GPL v3


include <inc/config.scad>

		translate([0,-10,0.21])
		rotate([0,0,180])
		fija_correa();
	
		translate([0,10,0.21])
		rotate([0,0,180])
		fija_correa();

