// New printer MOD by Chema

// fijaciones x-end prototype
// GNU GPL v3

include <inc/config.scad>

module fija_shaft(par=true){
	translate([0,0,12]) rotate([-90,180,0]) difference(){
		translate([0,0,10]) 
	 	 cube_fillet([18,25+4,14], vertical=[3,3,3,3], top=[2,2,2,2], center=true);
		translate([0,0,0]){
		  // Hueco para barra lisa
		  translate([0,-100,10+6]) rotate([0,90,90]) cylinder(h = 230, r=4.2, $fn=30); 
		  // Brida
		  translate([-15,-2,8])  cube([ancho*2,3.5,2]);
		  // Tornillos
		  translate([0,7,13]) 
			rotate([180,0,0]) screw(r=m3_diameter/2,slant=false,head_drop=4,h=50, $fn=par?12:6);
		  translate([0,7-15,13]) 
			rotate([180,0,0]) screw(r=m3_diameter/2,slant=false,head_drop=4,h=50, $fn=par?6:12);
		}
	}

}

rotate([90,0,0])
fija_shaft();
translate([20,0,0])
rotate([90,0,0])
fija_shaft(par=false);