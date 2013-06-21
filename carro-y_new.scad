// New printer MOD by Chema

// Y carriage prototype V2
// GNU GPL v3


include <inc/config.scad>
use <inc/bearing.scad>

impresion=true; //para imprimir las piezas

module yc_base(){
	// Bloque principal
	translate([-yc_alto/2,-yc_ancho+7.25,0]) 
	 cube(size = [yc_alto,yc_ancho-13.5,yc_largo], center = false);
	if(brimw>0){
		translate([0,-14,0])
		cube_fillet([x_rod_distance+10+diam_x+2*brimw,bearing_size*2+12+brimw*2,brimh],center=true);
	//echo ("brimw es: ",brimw," y brimh es: ",brimh);
	}


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
	// %cube(size = [belt_space+2,6,100], center = true);
	 cube_fillet(size = [belt_space+2,6,100], center = true);

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
	
	//screws poleas 
	translate ([40,-28.5-1,(yc_largo-40)/2]) rotate ([0,-90,0]) 
	 screw(r=m3_diameter/2, slant=false, head_drop=32, h=100, $fn=10);
	translate ([20,-28.5-1,yc_largo-(yc_largo-40)/2]) rotate ([0,-90,0]) 
	 screw(r=m3_diameter/2, slant=false, head_drop=10, h=50, $fn=10);
	
	translate ([-2-15,-28.5-1,(yc_largo-40)/2]) rotate ([180,-90,0]) 
	 screw(r=m3_diameter/2, slant=false, head_drop=4+5, h=50, $fn=6);
	translate ([-2-20,-28.5-1,yc_largo-(yc_largo-40)/2]) rotate ([180,-90,0]) 
	 screw(r=m3_diameter/2, slant=false, head_drop=4+10, h=50, $fn=6);

	//huecos barras
	for (i=[-1,1]){
		translate ([i*x_rod_distance/2,30,yc_largo/2]) 
		rotate ([90,180,0]) 
		pushfit_rod(diam_x,100);
	}

}


// Final prototype
module yc_plain(){
 difference(){
  yc_base();
  yc_holes();
 }
}

if(impresion){

	yc_plain();
	mirror([0,1,0])
	//rotate([0,0,180])
	translate([0,90,0])
	yc_plain();


//	translate([20,0,-3])
//	rotate([90,0,90])
//	fija_shaft();
//	translate([-26,-50,-3])
//	rotate([90,0,90])
//	fija_shaft(par=false);

} 