// New printer MOD by Chema

// X carriage prototype
// GNU GPL v3

include <inc/config.scad>
use <inc/bearing.scad>

impresion=true; //para posicionar...

alt_f=-15; //altura extra de los agujeros de anclaje extrusores
dbof=7+10; //distancia al borde del carro de los agujeos de fijación correa
grueso_fijacion=4; //este grueso incluye el grosor de la correa (0.75mm para GT2==belt_grueso)
ancho_fijacion=16; //entre centros de los agujeros
fge=1+1.5; //grueso extra de la fijación correa

module carro_x_base(){
	// Bearing holder

	//translate ([12.75+(33/2),0,0]) 
	translate ([x_rod_distance/2,0,0]) 
	 soporte_bearing(largo=xc_largo,ancho=x_rod_distance/2);	

	translate ([-x_rod_distance/2,0,0]) rotate([0,0,180]) 
	 soporte_bearing(largo=xc_largo,ancho=x_rod_distance/2);	

}

module carro_x_holes(){
	//agujeros fijación extrusores

	//translate([0,50,xc_largo/4])
	translate([alt_f,50,xc_largo/2+15])
	rotate([90,0,0])
	cylinder(r=m3_diameter/2,h=100,$fn=6);

	//translate([0,50,3*xc_largo/4])
	translate([alt_f,50,xc_largo/2-15])
	rotate([90,0,0])
	cylinder(r=m3_diameter/2,h=100,$fn=6);

	//agujeros correa
	translate([0,0,10])
	cube ([belt_ancho*1.5,100,belt_grueso*2],center=true);
	translate([0,0,xc_largo-10])
	cube ([belt_ancho*1.5,100,belt_grueso*2],center=true);

	//agujeros fijaciones correas agujeros a 12mm
	for (i= [-1, 1]){
	translate([i*ancho_fijacion/2,0,xc_largo-dbof]){
		
		translate([0,0,-20])
		
		cylinder(r=m3_diameter/2,h=30,$fn=20);
		rotate([0,0,90])
		screw(r=m3_diameter/2+0.2, slant=false, head_drop=3, h=50, $fn=6);
		translate([0,10,1.5])
		cube([6,20,3],center=true);
	}}
	for (i= [-1, 1]){
	translate([i*ancho_fijacion/2,0,dbof]){
		
		translate([0,0,-10])
		cylinder(r=m3_diameter/2,h=30,$fn=20);
		rotate([0,180,90])
		screw(r=m3_diameter/2+0.2, slant=false, head_drop=3, h=50, $fn=6);
		translate([0,10,-1.5])
		cube([6,20,3],center=true);
	}}

//	translate([-ancho_fijacion/2,0,xc_largo-dbof]){
//		rotate([0,0,90])
//		cylinder(r=m3_diameter/2,h=30,$fn=20);
//		screw(r=m3_diameter/2+0.2, slant=false, head_drop=3, h=50, $fn=6);
//		translate([0,10,1.5])
//		cube([6,20,3],center=true);
//	}

//	translate([-ancho_fijacion/2,14,xc_largo-dbof])
//	rotate([90,0,0])
//	//cylinder(r=m3_diameter/2,h=100,$fn=6);
//	screw(r=m3_diameter/2, slant=false, head_drop=10, h=50, $fn=6);
	
//	translate([ancho_fijacion/2,14,dbof])
//	rotate([90,0,0])
//	//cylinder(r=m3_diameter/2,h=100,$fn=6);
//	screw(r=m3_diameter/2, slant=false, head_drop=10, h=50, $fn=6);
//	translate([-ancho_fijacion/2,14,dbof])
//	rotate([90,0,0])
//	//cylinder(r=m3_diameter/2,h=100,$fn=6);
//	screw(r=m3_diameter/2, slant=false, head_drop=10, h=50, $fn=6);

}

module fija_correa(){
 difference(){
	union(){
	translate([-ancho_fijacion/2,-(5),0])
	cube([ancho_fijacion,(5)*2,grueso_fijacion+fge]);
	translate([ancho_fijacion/2,0,0])
	cylinder(r=5,h=grueso_fijacion+fge,$fn=25);
	translate([-ancho_fijacion/2,0,0])
	cylinder(r=5,h=grueso_fijacion+fge,$fn=25);
	}
	// hueco correa
	translate([-belt_ancho/2,-(dbof),grueso_fijacion]) 
	cube([belt_ancho,(5)*2,20]);

	//agujeros tornillos
	translate([ancho_fijacion/2,0,-10+2])
	screw(r=m3_diameter/2, slant=false, head_drop=10, h=50, $fn=15);
	translate([-ancho_fijacion/2,0,-10+2])
	screw(r=m3_diameter/2, slant=false, head_drop=10, h=50, $fn=15);

	//dientes fijación correa
 	for ( i = [0 : 33] ){
   		translate([-belt_ancho/2,25-i*belt_tooth_distance,grueso_fijacion-belt_grueso]) 
		 cube([belt_ancho,1.2,3]);
	}
 

 }
}

module carro_x(){
	//rail fijación correa
	//cube([10,x_end_largo-20-12,10],center=true);
	//translate([-belt_ancho/2,-(x_end_largo-20-12)/2+grueso_fijacion,0])
	translate([-belt_ancho*1.5/2,-(40-12)/2+grueso_fijacion,0])
	//cube([belt_ancho,(x_end_largo-20-12)/2-grueso_fijacion,xc_largo]);
	cube([belt_ancho*1.5,(40-12)/2-grueso_fijacion,9.3]);

	translate([-belt_ancho*1.5/2,-(40-12)/2+grueso_fijacion,xc_largo-9.3])
	//cube([belt_ancho,(x_end_largo-20-12)/2-grueso_fijacion,xc_largo]);
	cube([belt_ancho*1.5,(40-12)/2-grueso_fijacion,9.3]);

	
	difference(){
	carro_x_base();
	carro_x_holes();
	}
}

carro_x();

if (impresion){
	//fijaciones
	translate([-15,-18,0])
	rotate([0,0,180])
	fija_correa();

	translate([15,-18,0])
	rotate([0,0,180])
	fija_correa();


} else {
	translate([-24+alt_f,-bearing_size-17,45])
	rotate([270,90,0])
	import("/Users/jmmunoz/Dropbox/3d/0\ para\ imprimir/direct_extruder_complete2.stl");
	
	translate([54+alt_f,-12,30])
	rotate([90,0,-90])
	import("/Users/jmmunoz/gits/CatPrinter/acc/CatNozzle2.stl");
	
	translate([0,0,90])
	rotate([180,0,0]) {
		translate([-24+alt_f,-bearing_size-17,45])
		rotate([270,90,0])
		import("/Users/jmmunoz/Dropbox/3d/0\ para\ imprimir/direct_extruder_complete2.stl");
		
		translate([54+alt_f,-12,30])
		rotate([90,0,-90])
		import("/Users/jmmunoz/gits/CatPrinter/acc/CatNozzle2.stl");
	}
	
	
	
	//fijaciones
	translate([0,-(x_end_largo-20-12)/2,dbof])
	rotate([90,0,180])
	fija_correa();
	
	translate([0,-(x_end_largo-20-12)/2,xc_largo-dbof])
	rotate([90,0,180])
	fija_correa();
}