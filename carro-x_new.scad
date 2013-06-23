// New printer MOD by Chema

// X carriage prototype
// GNU GPL v3

include <inc/config.scad>
use <inc/bearing.scad>

impresion=true; //para posicionar print-friendly

aligerado=true; //menos plástico, menos warping

fijaciones=true; //si ponemos las fijaciones o no 

alt_f=-13; //altura extra de los agujeros de anclaje extrusores
dbof=5; //distancia al borde del carro de los agujeros de fijación correa
sep_ext=30; //separación de agujeros del extrusor
prof=-4; //profundidad de las tuercas extrusor

module carro_x_base(){

	// Bearing holder
	//los +1 en los anchos son para evitar problemas en el slicer

	translate ([x_rod_distance/2,0,0]) 
	 soporte_bearing(largo=xc_largo,ancho=x_rod_distance/2+1,brimw=brimw,brimh=brimh);	

	translate ([-x_rod_distance/2,0,0]) rotate([0,0,180]) 
	 soporte_bearing(largo=xc_largo,ancho=x_rod_distance/2+1,brimw=brimw,brimh=brimh);	

	difference(){
	union(){
	translate([0,0,xc_largo/2])
	cube_fillet([x_rod_distance-bearing_size+2*thinwall+4,xc_ancho,xc_largo],vertical=[3,1,1,3],center=true);
	translate([0,0,brimh/2]) //brim
	cube_fillet([x_rod_distance-bearing_size+2*thinwall+4+2*brimw,xc_ancho+2*brimw,brimh],vertical=[3,1,1,3],center=true);

	}
	for(i=[-1,1]){
		translate([i*x_rod_distance/2,0,25])
		cylinder(r=bearing_size/2,h=55,center=true);
	}}
}

module carro_x_holes(){

	//agujeros correa nuevos sólo para ver por donde pasa la correa
//	for(j=[-1,1]){
//	translate([0,j*(sep_pol-15)/2,0])
//	%hull(){
//		for(i=[-1,1]){
//		translate([i*belt_ancho/1.5,0,30])
//		cylinder(r=belt_grueso*2,h=100,$fn=10,center=true);
//		}
//	}}
	
	//agujero vertical fijaciones
	difference(){
		translate([0,0,24])
		cube_fillet([ancho_fijacion+6,largo_fijacion+5-2,50],vertical=[2,2,1,1],center=true);
		translate([0,-6.5,24]) //raíl para fijar correa
		cube_fillet([belt_ancho,belt_grueso*4,50],vertical=[1,1,1,1],center=true);
	}

	//agujeros fijaciones correas agujeros a 3mm bajo fijación (tbf), tornillos+tuercas
	rotate([270,0,0])
	for(j=[true,false]){
	for (i= [-1, 1]){
	translate([i*ancho_fijacion/2,j?-dbof:-xc_largo+dbof,-xc_ancho/2-0.1]){
		rotate([0,0,90]) //para que las tuercas queden en posición print-friendly
		screw(r=m3_diameter/2, r_head=m3_nut_diameter/2, slant=false, head_drop=2, h=50, $fn=12,$fnn=6);
	}}}

	//agujeros fijaciones extrusores, tornillos+tuercas
	rotate([90,0,0])
	for (i= [-1, 1]){
	for (j=[-1,1]){
	translate([alt_f,xc_largo/2+i*sep_ext/2,j*xc_ancho/2+j*prof]){	
		translate([0,0,-20])
		
		cylinder(r=m3_diameter/2,h=30,$fn=20);
		rotate([0,0,90])
		//screw(r=m3_diameter/2, r_head=m3_nut_diameter, slant=false, head_drop=2.5, h=50, $fn=20, $fnn=6);
		cylinder(r=m3_nut_diameter/2,h=3,$fn=6,center=true);
		translate([0,i*10,0])
		cube([m3_nut_size,20,3],center=true);
	}}}

	//Huecos para aligerar
	if(aligerado){
		translate([0,0,xc_largo/2])
		rotate([90,0,0]){
			resize([18,22,50])
			cylinder(r=7,h=50,$fn=30, center=true);
			for(i=[-1,1]){
				translate([i*35,0,0])
				cylinder(r=14,h=50,$fn=30, center=true);
			}
		}
	}

}

module carro_x(){
	
	difference(){
	carro_x_base();
	carro_x_holes();
	// esto es para ver dentro
	//translate([0,-30,-1]) cube([30,100,100]);
	}
}




module carro_x_montado(){
	carro_x();
	translate([-24+alt_f,-bearing_size-17-5,20])
	rotate([270,90,0])
	import("/Users/jmmunoz/Dropbox/3d/0\ para\ imprimir/direct_extruder_complete2.stl");
	
	translate([54+alt_f,-12-7.7,5.5])
	rotate([90,0,-90])
	import("/Users/jmmunoz/gits/CatPrinter/acc/CatNozzle2.stl");
	
	translate([0,0,90])
	rotate([180,0,0]) {
		translate([-24+alt_f,-bearing_size-17-5,70])
		rotate([270,90,0])
		import("/Users/jmmunoz/Dropbox/3d/0\ para\ imprimir/direct_extruder_complete2.stl");
		
		translate([54+alt_f,-12-5.5,55])
		rotate([90,0,-90])
		import("/Users/jmmunoz/gits/CatPrinter/acc/CatNozzle2.stl");
	}
	
	
	if(fijaciones){	
		//fijaciones
		for(i=[true,false]){
			translate([0,-3+2.2,i?dbof:xc_largo-dbof])
			rotate([270,0,180])
			fija_correa();
		}
	}

}



if (impresion){
	carro_x();
	if(fijaciones){
		//fijaciones
		for(i=[-1,1]){
			translate([i*(10+brimw),-20-2*brimw,brimh/2])
			rotate([0,0,180])
			fija_correa();
		}
	}

} else {
	//carro_x_montado();
}