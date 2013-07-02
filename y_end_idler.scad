// esquina para new printer by Chema
// Mod basado en
// PRUSA iteration3
// Y axis end idler
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org 

include <inc/config.scad>
altura_extra=6;
impresion=true;

module esquina_base(){
	 translate([0,-6,0]) cube_fillet([8,44,36],top=[20,2,5,2]); // plate touching the back wall
	translate([11,5,(altura+altura_extra)/2]) rotate([0,0,90]) 
	cube_fillet([ancho+2+2,fondo,altura+altura_extra], vertical=[3,3,3,3], top=[2,2,2,2], center=true);
 if(brimw>0){
 	translate([0-brimw,-6-brimw,9]) cube_fillet([8+brimw*2,44+brimw*2,brimh]); // plate touching the back wall
	translate([11,5,brimh/2+9]) rotate([0,0,90]) 
	cube_fillet([ancho+2+2+brimw*2,fondo+brimw*2,brimh], vertical=[3,3,3,3], center=true);

 }
}

module esquina_holes(){

 // Frame mounting screw holes
 translate([25,10-5,10+5]) rotate([0,90+180,0])//rotate([0,90,0]) 
 screw(r=m3_diameter/2,r2=m3_nut_diameter, slant=false, head_drop=19, h=35, $fn=20,$fnn=6);
 translate([10,10+20,10+5]) rotate([0,90+180,0])
 screw(r=m3_diameter/2,r2=m3_nut_diameter, slant=false, head_drop=4, h=20, $fn=20,$fnn=6);
 translate([10,10+10,10+20]) rotate([0,90+180,0])
 screw(r=m3_diameter/2,r2=m3_nut_diameter, slant=false, head_drop=4, h=20, $fn=20,$fnn=6);

  // Hueco para barra lisa
  translate([2-3,5.5,altura-2+altura_extra]) rotate([270,0,270]) pushfit_rod(diam_x,100);

  // Bridas
	translate([16,5.5,altura-6.1+altura_extra-2.5])
	rotate([0,90,0])
   	brida(r=6,h=4,size=[21,18,4]);

  //Hueco tensor
	//translate([-1,5.5+28.5-10,altura-4.1+altura_extra])
	translate([-1,5.5+sep_tensor,altura-2.1+altura_extra])
	rotate([0,90,0])
	cylinder(r=m4_diameter/2+0.2,h=30);
	

  //Un poco menos de plástico
	translate([-10,-10,-1])
	cube([90,90,10]);
}

// Final part
module esquina_holder(){
 difference(){
  esquina_base();
  esquina_holes();
 }

}

if(impresion){
	translate([0,0,-9]) 
	esquina_holder();
	translate([0,-24,-9]) mirror([0,1,0])
	esquina_holder();
}