// New printer MOD by Chema

// Y tension prototype V2
// GNU GPL v3

include<inc/config.scad>

impresion=true;

ytens_alto=15+5+2;
ytens_ancho=23;
ytens_largo=12;

module y_tens_base(){
	// Bloque
	translate([0,0,0]) 
	 cube(size = [ytens_ancho,ytens_largo,ytens_alto], center=false);
	if(brimw>0){
		translate([-brimw,0,-brimw]) 
		 cube(size = [ytens_ancho+brimw*2,brimh,ytens_alto+brimw*2], center=false);
	
	}
	//refuerzo
//	translate([0,ytens_largo/2,0])
//	rotate([0,90,0])
//	cylinder(r=ytens_largo/2,h=ytens_ancho);

}

module y_tens_holes(){
	//general
	//translate([5,(ytens_largo-50)/2,5])
	translate([ytens_ancho/2,ytens_largo/2+(brimw>0?1+brimh:0),ytens_alto/2+5+1])
	cube_fillet([13-3,ytens_largo+2,ytens_alto], vertical=[0,0,0,0], bottom=[0,3,0,3], center=true);

	//screws poleas 
//	translate ([ytens_ancho+0.5,ytens_largo/2,ytens_alto-5]) rotate ([0,-90,0]) 
//	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=2, h=50, $fn=10);
	translate ([-0.5,ytens_largo/2,ytens_alto-5]) rotate ([-90,0,-90]) 
	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=2, h=48, $fnn=6, $fn=10);

	//screws tensor
	translate ([ytens_ancho/2,ytens_largo/2,6+2]) rotate ([0,180,0]) 
	 screw(r=m4_diameter/2+0.1, slant=false, head_drop=3+2, h=50, $fnn=6,$fn=12);
//	translate ([ytens_ancho/2,5,6]) rotate ([0,180,0]) 
//	 screw(r=m3_diameter/2+0.1, slant=false, head_drop=3, h=50, $fn=6);


}


// Final prototype
module y_tens(){
 difference(){
  y_tens_base();
  y_tens_holes();
 }
//polea
 if(impresion==false){
	translate([ytens_ancho/2,ytens_largo/2,ytens_alto-5])
	rotate([0,90,0])
	polea(diam=12,alto=8);
 }
}

if (impresion){
	//y_tens();
	rotate([90,0,0]){ //para mejorar la impresión
	y_tens();
	 rotate([0,180,0])
	translate([-ytens_ancho,0,5+brimw*2])
	y_tens();
	
//	translate([ytens_ancho/2,ytens_largo/2,ytens_alto-5])
//	rotate([0,90,0])
//	polea();
	
	}
}
