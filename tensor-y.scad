// New printer MOD by Chema

// Y tension prototype
// GNU GPL v3

include<inc/config.scad>

ytens_alto=15+5;
ytens_ancho=23;
ytens_largo=18+10;

module y_tens_base(){
	// Bloque
	//translate([-x_end_alto,-x_end_ancho+bearing_size/2,0]) 
	 cube(size = [ytens_ancho,ytens_largo,ytens_alto], center=false);
}

module y_tens_holes(){
	//general
	translate([5,(ytens_largo-50)/2,5])
	cube([13,50,45], center=false);

	//screws poleas 
	translate ([ytens_ancho+0.5,ytens_largo/2,ytens_alto-5]) rotate ([0,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=2, h=50, $fn=10);
	translate ([-0.5,ytens_largo/2,ytens_alto-5]) rotate ([-90,0,-90]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=3, h=50, $fn=6);

	//screws tensores
	translate ([ytens_ancho/2,ytens_largo-5,6]) rotate ([0,180,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=3, h=50, $fn=6);
	translate ([ytens_ancho/2,5,6]) rotate ([0,180,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=3, h=50, $fn=6);


}


// Final prototype
module y_tens_plain(){
 difference(){
  y_tens_base();
  y_tens_holes();
 }
}

y_tens_plain();
translate([30,0,0]) y_tens_plain();
//translate([ytens_ancho/2,ytens_largo/2,ytens_alto-5])
//rotate([0,90,0])
//polea();
