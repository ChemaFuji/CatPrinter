// New printer MOD by Chema

// Y carriage prototype V2
// GNU GPL v3


include <inc/config.scad>
use <inc/bearing.scad>
include <y_end_motor.scad>
include <y_end_idler.scad>
include <tensor-y.scad>

impresion=false; //para posicionar...
altura_bearing=5;
zipw=3.5+0.5;
ziph=2+0.5;
diam_x=8.1; //Diámetro de la barra lisa 8.1 PLA, 8.4 ABS
belt_space=10; //paso para las correas

module yc_base(){
	// Bloque principal
	translate([-yc_alto/2,-yc_ancho+7.25,0]) 
	 cube(size = [yc_alto,yc_ancho-13.5,yc_largo], center = false);


	// Bearing holder
	difference(){
		translate([0,0,yc_largo/2])
		cube_fillet([x_rod_distance+10+diam_x,bearing_size,yc_largo],center=true);
//		translate([0,0,-5])
//		cylinder(r=bearing_diameter/2,h=100,$fn=20);
	}
	//Bloque secundario
		translate([0,-25-3,yc_largo/2])
		cube_fillet([x_rod_distance+10+diam_x,bearing_size,yc_largo],center=true);

	//refuerzos
	difference(){
	 union(){
		translate([0,-14,yc_largo/2])
		cube([x_rod_distance-12,bearing_size,yc_largo], center=true);
		translate([0,-14,5])
		cube_fillet([x_rod_distance+18,bearing_size+8,10], vertical=[0,0,0,0], top=[0,3,0,3], center=true);
	 }
		for(i=[-1,1]){
		//translate([i*16,-12.5,-5])
		translate([i*(16),-14,-5]){
		hull(){
		cylinder(r=6.5,h=100,$fn=20);
		translate([4*i,0,0])
		cylinder(r=6.5,h=100,$fn=20);
		}}
	}}

}

module yc_holes(){

	//para ver dentro
	//translate([0,-50,-10]) cube([100,100,100]);

	//hueco bearings eje Y
	translate([0,0,-5])
	cylinder(r=bearing_diameter/2,h=100,$fn=20);



		//huecos para poleas
	translate(v=[0,-yc_ancho/2-4-9,10-2]) 
	 cube_fillet(size = [belt_space,30,22-3], vertical=[2,2,0,0], top=[8,2,0,2], center = true);
	translate(v=[0,-yc_ancho/2-4-9,yc_largo-10+2]) 
	 cube_fillet(size = [belt_space,30,22-3], vertical=[2,2,0,0], bottom=[8,2,0,2], center = true);
		//paso a través de la correa
	translate(v=[0,-yc_ancho/2+11.5,yc_largo/2]) 
	 cube(size = [belt_space+2,6,100], center = true);

		//mejora acceso, gasto de plástico
	for (i=[-1,1]){
		translate([i*(x_rod_distance/2+5+diam_x/2),0,yc_largo]) 
		rotate([90,0,0])
		cylinder(r=20,h=100,$fn=40,center=true);
	}
	for (i=[-1,1]){
		translate([i*(x_rod_distance/2-4),0,12]) 
		rotate([90,0,0])
		cylinder(r=8,h=100,$fn=40,center=true);
	}	
	
	translate([0,0,28-0.5]) 
	rotate([90,0,0]){
	cylinder(r=7,h=100,$fn=40,center=true);
	translate([0,0+2,-2.9])
	cylinder(r=12,h=20,$fn=40,center=true);
	}

//		  // Brida verticales
//		  translate([10,-yc_alto-6,yc_largo/2-5])  
//			cube([yc_ancho*2,zipw,ziph], center=true);
//		  translate([10,-yc_alto-6,yc_largo/2+5])  
//			cube([yc_ancho*2,zipw,ziph], center=true);
//		  //Horizontal
//		  translate([10,-yc_alto-6,yc_largo/2+(impresion?15.3:0)])
//			rotate([0,90,0])  
//			cube([yc_ancho,5,4], center=true);

	
	//screws poleas 
	translate ([40,-28.5-1,(yc_largo-40)/2]) rotate ([0,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=32, h=100, $fn=10);
	translate ([20,-28.5-1,yc_largo-(yc_largo-40)/2]) rotate ([0,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=10, h=50, $fn=10);
	
	translate ([-2-15,-28.5-1,(yc_largo-40)/2]) rotate ([180,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=4+5, h=50, $fn=6);
	translate ([-2-20,-28.5-1,yc_largo-(yc_largo-40)/2]) rotate ([180,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=4+10, h=50, $fn=6);

	//screws fijaciones barras
//	translate ([50,-15+1,yc_largo/2]) 
//	rotate ([0,-90,0]) 
//	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=0, h=150);
//	translate ([50,-15+1-15,yc_largo/2]) 
//	rotate ([0,-90,0]) 
//	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=0, h=150);

	//huecos barras
	for (i=[-1,1]){
		translate ([i*x_rod_distance/2,30,yc_largo/2]) 
		rotate ([90,180,0]) 
		pushfit_rod(diam_x,100);
	}

}

module fija_shaft(par=true){
	translate([0,0,12]) rotate([-90,180,0]) difference(){
		translate([0,0,10-1]) 
	 	 cube_fillet([18,25+4,14-2], vertical=[3,3,3,3], top=[2,2,2,2], center=true);
		translate([0,0,0]){
		  // Hueco para barra lisa
		  translate([0,-100,10+6-4]) rotate([0,90,90]) cylinder(h = 230, r=4.2, $fn=30); 
		  // Brida
		  translate([-ancho*1.5,5,9])  cube([ancho*3,zipw,20]);

		  // Brida verticales
			rotate([0,90,0]){
		  translate([-yc_ancho/2,7,0]){ 
			translate([0,0,-5]) 
			cube([yc_ancho*2,zipw,ziph], center=true);
		  //%translate([-yc_ancho/2+10,-yc_alto-6,yc_largo/2+5])  
			translate([0,0,5])
			cube([yc_ancho*2,zipw,ziph], center=true);
			}}

		  // Tornillos
//		  translate([0,7,13]) 
//			%rotate([180,0,0]) screw(r=m3_diameter/2+0.1,slant=false,head_drop=4,h=50, $fn=par?12:6);
		  translate([0,7-15,13]) 
			rotate([180,0,0]) 
			//screw(r=m3_diameter/2+0.1,slant=false,head_drop=4,h=50, $fn=par?6:12);
			cylinder(r=m3_diameter/2+0.1,h=50,$fn=12);
		}
	}

}

module barrasX(){
	cylinder(r=4,h=100);
	translate([-x_rod_distance,0,0])
	cylinder(r=4,h=100);
}


// Final prototype
module yc_plain(){
 difference(){
  yc_base();
  yc_holes();
 }
}

yc_plain();

if(impresion){

	mirror([0,1,0])
	//rotate([0,0,180])
	translate([0,80,0])
	yc_plain();
//	translate([20,0,-3])
//	rotate([90,0,90])
//	fija_shaft();
//	translate([-26,-50,-3])
//	rotate([90,0,90])
//	fija_shaft(par=false);

} else {

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
}

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