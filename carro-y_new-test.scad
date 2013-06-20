// New printer MOD by Chema

// Y carriage prototype V2
// GNU GPL v3


include <inc/config.scad>
use <inc/bearing.scad>
include <y_end_motor.scad>
include <y_end_idler.scad>
include <tensor-y.scad>
include <carro-y_new.scad>

impresion=false;

yc_plain();


	//barra eje Y
	#translate([0,0,-100]) cylinder(r=4,h=200);

	
	// poleas
	translate ([0,-28.5-1,(yc_largo-40)/2]) rotate ([0,-90,0]) 
	//translate ([0,-28.5,(yc_largo-40)/2]) rotate ([0,-90,0]) 
	 polea(diam=12,alto=8);
	translate ([0,-28.5-1,yc_largo-(yc_largo-40)/2]) rotate ([0,-90,0]) 
	 polea(diam=12,alto=8);
	
//	//fijaciones barras X
//	translate([-3+0.5,-10,yc_largo/2])
//	rotate([0,90,-90])
//	fija_shaft();
//	translate([-yc_alto+3+0.5,-10,yc_largo/2])
//	rotate([0,-90,90])
//	fija_shaft(par=false);

	//barras eje X	
	//%translate([-3+16,-7,yc_largo/2]) rotate ([90,0,0]){
	#translate([x_rod_distance/2,20,yc_largo/2]) rotate ([90,0,0])

		barrasX();
	
	//translate([-yc_alto+16.5,-50,yc_largo/2])
	//rotate([90,0,0])
	//carro_x();


// Y_end_motor
translate([-altura+2,5.5,95+20]) mirror([0,1,0]) rotate([0,90,0]){
 difference(){
  esquinam_base();
  esquinam_holes();
 }

//motor
translate ([30,22,8]) rotate ([180,0,0]) {
#nema17(h=8,holes=0,shadow=5, polea=12);}
}

//Y_end_idler
translate([-24,5.5,-40-20]) rotate ([0,270,180])
esquina_holder();

//tensor
translate([-11.5,-24.5+2,-30-20]) rotate ([0,0,0])
y_tens();