// New printer MOD by Chema

// Pieza para pruebas
// GNU GPL v3


include <inc/config.scad>
use <inc/bearing.scad>

module base(){
cube_fillet([36,14,16],top=[2,2,2,2]);
}

module agujeros(){

	translate ([8,20,6]) 
	rotate ([90,180,0]) 
	pushfit_rod(diam_x,50);

	translate([20,7,-5])
	cylinder(r=bearing_diameter/2,h=100,$fn=20);
	
	translate ([30,7,20]) rotate ([180,0,0]) 
	 screw(r=m3_diameter/2, r_head=m3_nut_diameter/2, slant=false, head_drop=10, h=50, $fn=6);

	translate ([30,22,7]) rotate ([90,0,0]) 
	 screw(r=m3_diameter/2, r_head=m3_nut_diameter/2, slant=false, head_drop=10, h=50, $fn=6);

	translate ([30,-7,7]) rotate ([270,0,0]) 
	 screw(r=m3_diameter/2, r_head=m3_nut_diameter/2, slant=false, head_drop=10, h=50, $fn=10);

}

difference(){
	base();
	agujeros();
}