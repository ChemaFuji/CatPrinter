// New printer MOD by Chema

// X carriage prototype
// GNU GPL v3

include <inc/config.scad>
use <inc/bearing.scad>

impresion=true; //para posicionar...

aligerado=true; //menos plástico, menos warping

fijaciones=true; //si ponemos las fijaciones o no a imprimir

alt_f=-13; //altura extra de los agujeros de anclaje extrusores
dbof=5-0.8; //distancia al borde del carro de los agujeros de fijación correa
sep_ext=30; //separación de agujeros del extrusor

module carro_x_base(){

	// Bearing holder
	//los +1 en los anchos son para evitar problemas en el slicer

	translate ([x_rod_distance/2,0,0]) 
	 soporte_bearing(largo=xc_largo,ancho=x_rod_distance/2+1,brimw=brimw,brimh=brimh);	

	translate ([-x_rod_distance/2,0,0]) rotate([0,0,180]) 
	 soporte_bearing(largo=xc_largo,ancho=x_rod_distance/2+1,brimw=brimw,brimh=brimh);	

	//rail fijación correa
	vertical=[0,0,0,0];
	horizontal=[0,0,3,3];
	horizontal2=[3,3,0,0];
		//cube([20,40-12,10], center=true);
		translate([-belt_ancho+alt_f,-14,0]){
			translate([-belt_ancho+3,0,0])
			cube_fillet([belt_ancho*4-alt_f,xc_ancho/2-bearing_size/2+1,xc_largo],vertical,horizontal);
			translate([-belt_ancho+3-brimw,-brimw,0])
			cube_fillet([belt_ancho*4-alt_f+brimw*2,xc_ancho/2-bearing_size/2+1+brimw,brimh],vertical,horizontal);
		}
		
		translate([-belt_ancho+alt_f,bearing_size/2-1,0]){
			translate([-belt_ancho+3,0,0])
			cube_fillet([belt_ancho*4-alt_f,xc_ancho/2-bearing_size/2-1,xc_largo],vertical,horizontal2);
			translate([-belt_ancho+3-brimw,0,0])
			cube_fillet([belt_ancho*4-alt_f+brimw*2,xc_ancho/2-bearing_size/2-1+brimw,brimh],vertical,horizontal2);
		}

}

module carro_x_holes(){

	//agujeros correa
	translate([0,0,dbof])
	cube ([belt_ancho*1.5,100,belt_grueso+1],center=true);
	translate([0,0,xc_largo-dbof])
	cube ([belt_ancho*1.5,100,belt_grueso+1],center=true);

	//agujeros fijaciones correas agujeros a 3mm bajo fijación (tbf), tornillos+tuercas
	for (i= [-1, 1]){
	translate([i*ancho_fijacion/2,0,xc_largo-dbof-grueso_fijacion-fge-tbf]){
		
		translate([0,0,-20])
		
		cylinder(r=m3_diameter/2+0.2,h=30,$fn=20);
		rotate([0,0,90])
		screw(r=m3_diameter/2, r_head=m3_nut_diameter/2, slant=false, head_drop=3, h=50, $fn=6);
		translate([0,10,1.5])
		cube([6,20,3],center=true);
	}}
	for (i= [-1, 1]){
	translate([i*ancho_fijacion/2,0,dbof+grueso_fijacion+fge+tbf]){
		
		translate([0,0,-10])
		cylinder(r=m3_diameter/2+0.2,h=30,$fn=20);
		rotate([0,180,90])
		screw(r=m3_diameter/2, r_head=m3_nut_diameter/2, slant=false, head_drop=3, h=50, $fn=6);
		translate([0,10,-1.5])
		cube([6,20,3],center=true);
	}}

	//huecos fijaciones
	translate([0,0,-1]){
		difference(){
			union(){
				translate([-ancho_fijacion/2,-(largo_fijacion/2),0])
				cube([ancho_fijacion,largo_fijacion,grueso_fijacion+fge+3]);
				for(i=[-1,1]){
					translate([i*(ancho_fijacion-2)/2,0,0])
					cylinder(r=largo_fijacion/2,h=grueso_fijacion+fge+3,$fn=25);
				}
			}
				// hueco correa
			translate([-(belt_ancho+0.5)/2,-largo_fijacion/2-1,grueso_fijacion+2]) 
			cube([belt_ancho+0.5,(largo_fijacion/2+1)*2,10]);
		}
	}

	translate([0,0,xc_largo+1])rotate([180,0,0]){
		difference(){
			union(){
				translate([-ancho_fijacion/2,-(largo_fijacion/2),0])
				cube([ancho_fijacion,largo_fijacion,grueso_fijacion+fge+3]);
				for(i=[-1,1]){
					translate([i*(ancho_fijacion-2)/2,0,0])
					cylinder(r=largo_fijacion/2,h=grueso_fijacion+fge+3,$fn=25);
				}
			}
				// hueco correa
			translate([-(belt_ancho+0.5)/2,-largo_fijacion/2-1,grueso_fijacion+2]) 
			cube([belt_ancho+0.5,(largo_fijacion/2+1)*2,10]);
		}
	}


	//agujeros fijaciones extrusores, tornillos+tuercas
	rotate([90,0,0])
	for (i= [-1, 1]){
	translate([alt_f,xc_largo/2+i*sep_ext/2,xc_ancho/2-2.5-tbf+1-1]){	
		translate([0,0,-20])
		
		cylinder(r=1.6,h=30,$fn=20);
		rotate([0,0,90])
		//screw(r=m3_diameter/2, r_head=m3_nut_diameter, slant=false, head_drop=2.5, h=50, $fn=20, $fnn=6);
		cylinder(r=m3_nut_diameter/2,h=2.5,$fn=6);
		translate([0,i*10,1.5-0.25])
		cube([m3_nut_size,20,2.5],center=true);
	}}
	rotate([90,0,0])
	for (i= [-1, 1]){
	translate([alt_f,xc_largo/2+i*sep_ext/2,-xc_ancho/2+0.5+tbf-1+2]){	
		translate([0,0,-20])
		
		cylinder(r=1.6,h=30,$fn=20);
		rotate([0,0,90])
		//screw(r=m3_diameter/2, r_head=m3_nut_diameter, slant=false, head_drop=2.5, h=50, $fn=20, $fnn=6);
		cylinder(r=m3_nut_diameter/2,h=2.5,$fn=6);
		translate([0,i*10,1.5-0.25])
		cube([m3_nut_size,20,2.5],center=true);
	}}

	if(aligerado){
		translate([0,0,xc_largo/2])
		rotate([90,0,0]){
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
		translate([-24+alt_f,-bearing_size-17-3,70])
		rotate([270,90,0])
		import("/Users/jmmunoz/Dropbox/3d/0\ para\ imprimir/direct_extruder_complete2.stl");
		
		translate([54+alt_f,-12-5.5,55])
		rotate([90,0,-90])
		import("/Users/jmmunoz/gits/CatPrinter/acc/CatNozzle2.stl");
	}
	
	
	if(fijaciones){	
		//fijaciones
		translate([0,0,0])
		rotate([0,0,180])
		fija_correa();
		
		translate([0,0,xc_largo])
		rotate([180,0,180])
		fija_correa();
	}

}



if (impresion){
	carro_x();
	if(fijaciones){
		//fijaciones
		translate([-15-brimw,-20-2*brimw,0.21])
		rotate([0,0,180])
		fija_correa();
	
		translate([15+brimw,-20-2*brimw,0.21])
		rotate([0,0,180])
		fija_correa();

//		translate([0,0,-1])
//		rotate([0,0,180])
//		fija_correa();

	}

} else {
	//carro_x_montado();
}