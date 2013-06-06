// New printer MOD by Chema

// Y carriage prototype
// GNU GPL v3


include <inc/config.scad>
use <inc/bearing.scad>

impresion=true; //para posicionar...
altura_bearing=5;

module x_end_base(){
	// Bloque principal
//	translate([-x_end_alto,-x_end_ancho+bearing_size/2,0]) 
//	 cube(size = [x_end_alto,x_end_ancho,x_end_largo], center = false);
	translate([-x_end_alto+0.5,-x_end_ancho+7.25,0]) 
	 cube(size = [x_end_alto,x_end_ancho-13.5,x_end_largo], center = false);

	// Bearing holder
	translate ([altura_bearing,0,0]) 
	 soporte_bearing(largo=x_end_largo,ancho=y_rod_distance/2);
//	translate ([-y_rod_distance+xc_ancho,0,0]) rotate([0,0,180]) 
//	 soporte_bearing(largo=x_end_largo,ancho=y_rod_distance/2);
}

module x_end_holes(){
	
		//huecos para poleas
	translate(v=[-x_end_alto/2,-x_end_ancho/2-4,10]) 
	//cube(size = [x_end_alto-grueso*2,30,22], center = true);
	 cube(size = [belt_ancho*2,30,22], center = true);
	translate(v=[-x_end_alto/2,-x_end_ancho/2-4,x_end_largo-10]) 
	 cube(size = [belt_ancho*2,30,22], center = true);
		//paso a través de la correa
	translate(v=[-x_end_alto/2,-x_end_ancho/2+11.5,x_end_largo/2]) 
	 cube(size = [belt_ancho*2,6,100], center = true);
		//mejora acceso, gasto de plástico
	translate(v=[-x_end_alto/2,-x_end_ancho/2+8.5,x_end_largo-10+2]) 
	 cube(size = [x_end_alto+1,12,22], center = true);
	translate(v=[-x_end_alto/2,-x_end_ancho/2+8.5,8]) 
	 cube(size = [x_end_alto+1,12,22], center = true);
		//mejora tamaño impresión
	translate(v=[-x_end_alto/2-3,-x_end_ancho/2+22,x_end_largo-10+2]) 
	 cube(size = [x_end_alto-4,20,22], center = true);


		  // Brida verticales
		  translate([-x_end_ancho/2+10,-x_end_alto-6,x_end_largo/2-5])  
			cube([x_end_ancho*2,3.5,2], center=true);
		  translate([-x_end_ancho/2+10,-x_end_alto-6,x_end_largo/2+5])  
			cube([x_end_ancho*2,3.5,2], center=true);
		  //Horizontal
		  translate([-x_end_ancho/2+10,-x_end_alto-6,x_end_largo/2+(impresion?15.3:0)])
			rotate([0,90,0])  
			cube([x_end_ancho,5,4], center=true);

	
	//screws poleas 
	translate ([0,-28.5,(x_end_largo-40)/2]) rotate ([0,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=2, h=50, $fn=10);
	translate ([0,-28.5,x_end_largo-(x_end_largo-40)/2]) rotate ([0,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=2, h=50, $fn=10);
	
	translate ([-x_end_alto-2,-28.5,(x_end_largo-40)/2]) rotate ([180,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=4, h=50, $fn=6);
	translate ([-x_end_alto-2,-28.5,x_end_largo-(x_end_largo-40)/2]) rotate ([180,-90,0]) 
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
		translate([0,0,10-1]) 
	 	 cube_fillet([18,25+4,14-2], vertical=[3,3,3,3], top=[2,2,2,2], center=true);
		translate([0,0,0]){
		  // Hueco para barra lisa
		  translate([0,-100,10+6-4]) rotate([0,90,90]) cylinder(h = 230, r=4.2, $fn=30); 
		  // Brida
		  translate([-ancho*1.5,5,9])  cube([ancho*3,3.5,20]);

		  // Brida verticales
			rotate([0,90,0]){
		  translate([-x_end_ancho/2,7,0]){ 
			translate([0,0,-5]) 
			cube([x_end_ancho*2,3.5,2], center=true);
		  //%translate([-x_end_ancho/2+10,-x_end_alto-6,x_end_largo/2+5])  
			translate([0,0,5])
			cube([x_end_ancho*2,3.5,2], center=true);
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

// Final prototype
module x_end_plain(){
 difference(){
  x_end_base();
  x_end_holes();
 }
}

x_end_plain();

if(impresion){

	mirror([0,1,0])
	//rotate([0,0,180])
	translate([30,50,0])
	x_end_plain();
	translate([20,0,-3])
	rotate([90,0,90])
	fija_shaft();
	translate([-26,-50,-3])
	rotate([90,0,90])
	fija_shaft(par=false);

} else {

	//barra eje Y
	#translate([altura_bearing,0,-100]) cylinder(r=4,h=200);

	
	// poleas
	translate ([-x_end_alto/2,-28.5,(x_end_largo-40)/2]) rotate ([0,-90,0]) 
	 polea(diam=12,alto=8);
	translate ([-x_end_alto/2,-28.5,x_end_largo-(x_end_largo-40)/2]) rotate ([0,-90,0]) 
	 polea(diam=12,alto=8);
	
	translate([-3+0.5,-10,x_end_largo/2])
	rotate([0,90,-90])
	fija_shaft();
	translate([-x_end_alto+3+0.5,-10,x_end_largo/2])
	rotate([0,-90,90])
	fija_shaft(par=false);

	//barras eje X	
	//%translate([-3+16,-7,x_end_largo/2]) rotate ([90,0,0]){
	#translate([4+5+0.5,-7,x_end_largo/2]) rotate ([90,0,0]){
	cylinder(r=4,h=100);
	translate([-x_rod_distance+0,0,0])
	cylinder(r=4,h=100);
	
	
	}
	
	//translate([-x_end_alto+16.5,-50,x_end_largo/2])
	//rotate([90,0,0])
	//carro_x();
}