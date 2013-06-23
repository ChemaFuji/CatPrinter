// New printer MOD by Chema

// Y carriage prototype V3 
// closer pulleys
// GNU GPL v3


include <inc/config.scad>
use <inc/bearing.scad>

impresion=true; //para imprimir las piezas print-frinedly
yc_largo=34; //debería ser sep_pol+10


module yc_base(){
	// Bloque principal
	translate([-yc_alto/2,-yc_ancho+bearing_size/2,0]) 
	 cube_fillet(size = [yc_alto,yc_ancho-13.5,yc_largo], vertical=[0,0,0,0],top=[0,0,3,0],bottom=[0,0,3,0],center = false);
	
	if(brimw>0){
		translate([0,-bearing_size/4,brimh/2])
		cube_fillet([x_rod_distance+12+diam_x+2*brimw,bearing_size*1.5+brimw*2,brimh],center=true);
		translate([-yc_alto/2-brimw,-yc_ancho+bearing_size/2-brimw,0]) 
	 	cube_fillet(size = [yc_alto+brimw*2,yc_ancho-13.5+brimw*2,brimh],center = false);

	}

	// Bearing holder
	difference(){
		translate([0,-bearing_size/4,yc_largo/2])
		cube_fillet([x_rod_distance+12+diam_x,bearing_size*1.5,yc_largo],center=true);
	}

	//refuerzos
	difference(){
//	 union(){
		translate([0,-14,yc_largo/2])
		cube([x_rod_distance-12,bearing_size,yc_largo], center=true);
//		translate([0,-14,5])
//		%cube_fillet([x_rod_distance+18,bearing_size+8,10], vertical=[0,0,0,0], top=[0,3,0,3], center=true);
//	 }
		for(i=[-1,1]){
		//translate([i*16,-12.5,-5])
		translate([i*(16),-14-8.5,-5]){
		//hull(){
		cylinder(r=6.5,h=100,$fn=20);
		//translate([4*i,0,0])
//		%cylinder(r=6.5,h=100,$fn=20);
		}//}
	}}

}

module yc_holes(){

	//para ver dentro
	//translate([0,-50,-10]) cube([100,100,100]);

	//hueco bearings eje Y
	translate([0,0,-5])
	cylinder(r=bearing_diameter/2,h=100,$fn=20);



		//huecos para poleas
	//for(i=[true,false]){
	translate(v=[0,-yc_ancho/2-13,10-2+(brimw?brimh*2.5:0)]) 
	 cube_fillet([belt_space,30,22-3-(brimw?brimh*5:0)], vertical=[2,2,0,0], top=[8,5,0,5], center = true);
	
	translate(v=[0,-yc_ancho/2-4-9,yc_largo-10+5]) 
	 cube_fillet(size = [belt_space,30,22-4], vertical=[2,2,0,0], bottom=[8,2,0,2], center = true);
		//paso a través de la correa
	translate(v=[0,-yc_ancho/2+11.5,yc_largo/2]) 
	// %cube(size = [belt_space+2,6,100], center = true);
	cube_fillet(size = [belt_space+2,6-1,100], center = true);

		//mejora acceso, gasto de plástico arriba
	for (i=[-1,1]){
		translate([i*(x_rod_distance/2+5+diam_x/2),0,yc_largo+8]) 
		//rotate([90,0,0])
		//%cylinder(r=20,h=100,$fn=40,center=true);
		cube_fillet([40,100,30],vertical=[0,0,0,0],bottom=[0,5,0,5],center=true);
	}
		//abajo
	for (i=[-3,-2,2,3]){
		translate([i*(x_rod_distance/5),0,8/2+2]) 
		rotate([90,0,0])
		resize([6,10.5,0])
		cylinder(r=8,h=100,$fn=40,center=true);
		//cube_fillet([8,100,8],vertical=[0,0,0,0],top=[0,5,0,5],bottom=[0,5,0,5],center=true);
	}	
	
	//cilindro pequeño y grande
	//translate([0,0,28-0.5-2]) 
	translate([0,0,yc_largo/2]) 
	rotate([90,0,0]){
	//cilindro pequeño
//	cylinder(r=6,h=100,$fn=40,center=true);
	for(i=[-1,1]){
		translate([i*7.5,-1,0])
		//cilindro grande
		resize([10,20,0])
		cylinder(r=12,h=27,$fn=40,center=true);
	}}
	
	//screws poleas 
//	translate ([40,-28.5-1,(yc_largo-40)/2]) rotate ([0,-90,0]) 
//	 screw(r=m3_diameter/2, slant=false, head_drop=28, h=100, $fn=10);
//	translate ([20,-28.5-1,yc_largo-(yc_largo-40)/2]) rotate ([0,-90,0]) 
//	 screw(r=m3_diameter/2, slant=false, head_drop=10, h=50, $fn=10);
//	
	for(i=[true,false]){
		translate ([-2-15,-28.5-1,i?(yc_largo-sep_pol)/2:yc_largo-(yc_largo-sep_pol)/2]) rotate ([180,-90,0]) 
		 screw(r=m3_diameter/2, slant=false, head_drop=4+5, h=50, $fn=10, $fnn=6);
	}
//	translate ([-2-20,-28.5-1,yc_largo-(yc_largo-40)/2]) rotate ([180,-90,0]) 
//	 screw(r=m3_diameter/2, slant=false, head_drop=4+10, h=50, $fn=6);

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
translate([-5,-10,24])
%cube([10,10,10]);
translate([-5,-10,0])
%cube([10,10,10]);
	rotate([0,0,180])
	yc_plain();
	//rotate([0,0,180])
	//el otro en espejo
	mirror([1,0,0])
	
	translate([0,-30,0])
	yc_plain();

		// poleas
//	for(i=[true,false]){
//		translate ([0,-28.5-1,i?(yc_largo-sep_pol)/2:yc_largo-(yc_largo-sep_pol)/2]) rotate ([0,-90,0]) 
//		 polea(diam=12,alto=8);
//	}

} 