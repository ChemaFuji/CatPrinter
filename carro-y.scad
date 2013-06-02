// New printer MOD by Chema

// X end prototype
// GNU GPL v3


include <inc/config.scad>
use <inc/bearing.scad>

impresion=true; //para posicionar...
altura_bearing=5;

module x_end_base(){
	// Bloque principal
	translate([-x_end_alto,-x_end_ancho+bearing_size/2,0]) 
	 cube(size = [x_end_alto,x_end_ancho,x_end_largo], center = false);
	// Bearing holder
	translate ([altura_bearing,0,0]) 
	 soporte_bearing(largo=x_end_largo,ancho=y_rod_distance/2);
//	translate ([-y_rod_distance+xc_ancho,0,0]) rotate([0,0,180]) 
//	 soporte_bearing(largo=x_end_largo,ancho=y_rod_distance/2);
}

module x_end_holes(){
	// Belt holes
	translate(v=[-x_end_alto/2,-x_end_ancho/2-4,10]) 
	//cube(size = [x_end_alto-grueso*2,30,22], center = true);
	 cube(size = [belt_ancho*2,30,22], center = true);
	translate(v=[-x_end_alto/2,-x_end_ancho/2-4,x_end_largo-10]) 
	 cube(size = [belt_ancho*2,30,22], center = true);
	translate(v=[-x_end_alto/2,-x_end_ancho/2+12,x_end_largo/2]) 
	 cube(size = [belt_ancho*2,6,100], center = true);
	
	//screws poleas 
	translate ([0,-15.5-12,(x_end_largo-40)/2]) rotate ([0,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=2, h=50, $fn=10);
	translate ([0,-15.5-12,x_end_largo-(x_end_largo-40)/2]) rotate ([0,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=2, h=50, $fn=10);
	
	translate ([-x_end_alto-2,-15.5-12,(x_end_largo-40)/2]) rotate ([180,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=4, h=50, $fn=6);
	translate ([-x_end_alto-2,-15.5-12,x_end_largo-(x_end_largo-40)/2]) rotate ([180,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=4, h=50, $fn=6);

	//screws fijaciones barras
	translate ([50,-15+1,x_end_largo/2]) 
	rotate ([0,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=0, h=150);
	translate ([50,-15+1-15,x_end_largo/2]) 
	rotate ([0,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=0, h=150);

}

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
			rotate([180,0,0]) screw(r=m3_diameter/2+0.1,slant=false,head_drop=4,h=50, $fn=par?12:6);
		  translate([0,7-15,13]) 
			rotate([180,0,0]) screw(r=m3_diameter/2+0.1,slant=false,head_drop=4,h=50, $fn=par?6:12);
		}
	}

}

// Final prototype
module x_end_plain(){
 difference(){
  x_end_base();
  x_end_holes();
 }
}

x_end_plain();

if(impresion){

//	translate([15,-15,-3])
//	rotate([90,0,0])
//	fija_shaft();
//	translate([-47+10,-15,-3])
//	rotate([90,0,0])
//	fija_shaft(par=false);

} else {

//	%translate([-x_end_alto,0,0]){
//	//translate ([-xc_ancho-grueso,0,-2]) cube([y_rod_distance,5,5]);
//	//translate ([grueso,-10,-2]) cube([altura-2,5,5]);
	%translate([altura_bearing,0,-100]) cylinder(r=4,h=200);
	//translate([altura-2+grueso-y_rod_distance,0,-100]) cylinder(r=4,h=200);
//	}
	
	// poleas
	translate ([-x_end_alto/2,-15.5-12,(x_end_largo-40)/2]) rotate ([0,-90,0]) 
	 polea(diam=12,alto=8);
	translate ([-x_end_alto/2,-15.5-12,x_end_largo-(x_end_largo-40)/2]) rotate ([0,-90,0]) 
	 polea(diam=12,alto=8);
//	translate ([-x_end_alto+grueso,-15.5-12,10]) rotate([0,-90,0]) 
//	 //#nema17(h=16,polea=12,shaft=false);
//	 polea();
//	translate ([-x_end_alto+grueso,-15.5-12,x_end_largo-10]) rotate([0,-90,0]) 
//	 #nema17(h=16,polea=12,shaft=false);
	
	translate([-3,-10,x_end_largo/2])
	rotate([0,90,-90])
	fija_shaft();
	translate([-x_end_alto+3,-10,x_end_largo/2])
	rotate([0,-90,90])
	fija_shaft(par=false);
	
	%translate([-3+16,-7,x_end_largo/2]) rotate ([90,0,0]){
	cylinder(r=4,h=100);
	translate([-x_rod_distance+0,0,0])
	cylinder(r=4,h=100);
	
	
	}
	
	//translate([-x_end_alto+16.5,-50,x_end_largo/2])
	//rotate([90,0,0])
	//carro_x();
}