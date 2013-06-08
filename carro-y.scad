// New printer MOD by Chema

// Y carriage prototype
// GNU GPL v3


include <inc/config.scad>
use <inc/bearing.scad>

impresion=false; //para posicionar...
altura_bearing=5;
zipw=3.5+0.5;
ziph=2+0.5;

module yc_base(){
	// Bloque principal
//	translate([-yc_alto,-yc_ancho+bearing_size/2,0]) 
//	 cube(size = [yc_alto,yc_ancho,yc_largo], center = false);
	translate([-yc_alto+0.5,-yc_ancho+7.25,0]) 
	 cube(size = [yc_alto,yc_ancho-13.5,yc_largo], center = false);

	// Bearing holder
	translate ([altura_bearing,0,0]) 
	 soporte_bearing(largo=yc_largo,ancho=y_rod_distance/2);
//	translate ([-y_rod_distance+xc_ancho,0,0]) rotate([0,0,180]) 
//	 soporte_bearing(largo=yc_largo,ancho=y_rod_distance/2);

}

module yc_holes(){
	
		//huecos para poleas
	translate(v=[-yc_alto/2,-yc_ancho/2-4-9,10]) 
	//cube(size = [yc_alto-grueso*2,30,22], center = true);
	 cube(size = [belt_ancho*2,30,22], center = true);
	translate(v=[-yc_alto/2,-yc_ancho/2-4-9,yc_largo-10]) 
	 cube(size = [belt_ancho*2,30,22], center = true);
		//paso a través de la correa
	translate(v=[-yc_alto/2,-yc_ancho/2+11.5,yc_largo/2]) 
	 cube(size = [belt_ancho*2,6,100], center = true);

		//mejora acceso, gasto de plástico
	translate(v=[-yc_alto/2-6,-yc_ancho/2+8.5+2.5,yc_largo-10+2]) 
	 cube(size = [yc_alto+1,12-5,22-5], center = true);
	translate(v=[-yc_alto/2-6,-yc_ancho/2+8.5+2.5,8]) 
	 cube(size = [yc_alto+1,12-5,22-5], center = true);
		//mejora tamaño impresión
	translate(v=[-yc_alto/2-3,-yc_ancho/2+22,yc_largo-10+2]) 
	 cube(size = [yc_alto-4,20,22], center = true);


		  // Brida verticales
		  translate([-yc_ancho/2+10,-yc_alto-6,yc_largo/2-5])  
			cube([yc_ancho*2,zipw,ziph], center=true);
		  translate([-yc_ancho/2+10,-yc_alto-6,yc_largo/2+5])  
			cube([yc_ancho*2,zipw,ziph], center=true);
		  //Horizontal
		  translate([-yc_ancho/2+10,-yc_alto-6,yc_largo/2+(impresion?15.3:0)])
			rotate([0,90,0])  
			cube([yc_ancho,5,4], center=true);

	
	//screws poleas 
	translate ([0,-28.5,(yc_largo-40)/2]) rotate ([0,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=2, h=50, $fn=10);
	translate ([0,-28.5,yc_largo-(yc_largo-40)/2]) rotate ([0,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=2, h=50, $fn=10);
	
	translate ([-yc_alto-2,-28.5,(yc_largo-40)/2]) rotate ([180,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=4, h=50, $fn=6);
	translate ([-yc_alto-2,-28.5,yc_largo-(yc_largo-40)/2]) rotate ([180,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=4, h=50, $fn=6);

	//screws fijaciones barras
	translate ([50,-15+1,yc_largo/2]) 
	rotate ([0,-90,0]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=0, h=150);
	translate ([50,-15+1-15,yc_largo/2]) 
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
	translate([30,50,0])
	yc_plain();
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
	//translate ([-yc_alto/2,-28.5,(yc_largo-40)/2]) rotate ([0,-90,0]) 
	translate ([0,-28.5,(yc_largo-40)/2]) rotate ([0,-90,0]) 
	 polea(diam=12,alto=8);
	translate ([-yc_alto/2,-28.5,yc_largo-(yc_largo-40)/2]) rotate ([0,-90,0]) 
	 polea(diam=12,alto=8);
	
	translate([-3+0.5,-10,yc_largo/2])
	rotate([0,90,-90])
	fija_shaft();
	translate([-yc_alto+3+0.5,-10,yc_largo/2])
	rotate([0,-90,90])
	fija_shaft(par=false);

	//barras eje X	
	//%translate([-3+16,-7,yc_largo/2]) rotate ([90,0,0]){
	#translate([4+5+0.5,-7,yc_largo/2]) rotate ([90,0,0]){
	cylinder(r=4,h=100);
	translate([-x_rod_distance+0,0,0])
	cylinder(r=4,h=100);
	
	
	}
	
	//translate([-yc_alto+16.5,-50,yc_largo/2])
	//rotate([90,0,0])
	//carro_x();
}