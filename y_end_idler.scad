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
 difference(){
	 translate([0,0,0]) cube([8,40,35]); // plate touching the back wall
	 translate([-1,-4,36])
	 rotate([0,90,0])
	 cylinder(r=19,h=10,$fn=40);
 }
	translate([11,5,(altura+altura_extra)/2]) rotate([0,0,90]) 
	cube_fillet([ancho+2+2,fondo,altura+altura_extra], vertical=[3,3,3,3], top=[2,2,2,2], center=true);
}

module esquina_holes(){

 // corner cutouts
 translate([0.5,40-0.5,0]) rotate([0,0,-45+90]) translate([-15,0,-1]) cube([30,30,51]);
 translate([-4+11,40+5+5,0]) rotate([0,0,-45-0]) translate([0,0,-1]) cube([30,30,51]);
 translate([10,20+5,12+30]) rotate([-45,0,0]) rotate([0,-90,0]) translate([0,-5,0]) cube([30,50,30]);
 translate([50-2.5,-5+2.5,0]) rotate([0,0,-45-90]) translate([-15,0,-1]) cube([30,30,51]);
 translate([50-1.5,10-1.5,0]) rotate([0,0,-45]) translate([-15,0,-1]) cube([30,30,51]);

 // Frame mounting screw holes
 translate([-1,10-5,10+5]) rotate([0,90,0]) cylinder(h = 20, r=1.8, $fn=30);
 translate([-1,10+20,10+5]) rotate([0,90,0]) cylinder(h = 20, r=1.8, $fn=30);
 translate([-1,10+10,10+20]) rotate([0,90,0]) cylinder(h = 20, r=1.8, $fn=30);

 // Frame mounting screw nut holes
 translate([4,10-5,10+5]) rotate([90,0,90]) cylinder(h = 20, r=m3_nut_diameter/2, $fn=6);
 translate([4,10+20,10+5]) rotate([0,90,0]) cylinder(h = 20, r=m3_nut_diameter/2, $fn=6);
 translate([4,10+10,10+20]) rotate([0,90,0]) cylinder(h = 20, r=m3_nut_diameter/2, $fn=6);
// translate([4,10+10-3.1,10+20+5]) cube([10,6.2,10]);

  // Hueco para barra lisa
  translate([2-3,5.5,altura-2+altura_extra]) rotate([0,90,0]) cylinder(h = 50, r=4.1, $fn=30); 

  // Bridas
  //translate([13,-15,altura-8]) rotate([0,0,90]) cube([ancho*2,3.5,2]);
	translate([6,5.5,altura-6.1+altura_extra-2.5])
	rotate([0,90,0])
   	//brida(r=6);
	brida(r=6,h=4,size=[21,18,4]);
	translate([16,5.5,altura-6.1+altura_extra-2.5])
	rotate([0,90,0])
	//resize([25,50,100])
   	brida(r=6,h=4,size=[21,18,4]);



  //Hueco tensor
	//translate([-1,5.5+28.5-10,altura-4.1+altura_extra])
	translate([-1,5.5+sep_tensor,altura-2.1+altura_extra])
	rotate([0,90,0])
	cylinder(r=m4_diameter/2+0.2,h=30);
	

  //Un poco menos de plástico
	translate([-10,-10,-1])
	cube([90,90,10]);

//  translate([23.1,1.1,5]) rotate([0,0,90])
//  cube_fillet([15,14,15], vertical=[1,1,1,8], top=[12,12,2,2], center=false);
//	cube([15,14,15]);
// // motor mounting
// translate([25+4.3,21,-1]){
// //translate([15.5,15.5,-1]) cylinder(h = 20, r=1.8, $fn=30);
// 
// translate([15.5,-15.5,-1]) cylinder(h = 20, r=1.8, $fn=30);
// translate([-15.5,15.5,-1]) cylinder(h = 20, r=1.8, $fn=30);
// translate([-15.5,-15.5,47]) //cylinder(h = 200, r=1.8, $fn=30);
// //rotate([180,0,0]) screw(r=m3_diameter/2, slant=false, head_drop=40, h=70, $fn=20);
//
// }

}

// Final part
module esquina_holder(){
 difference(){
  esquina_base();
  esquina_holes();
 }
// translate([0,-17,0]) mirror([0,1,0]) difference(){
//  esquina_base();
//  esquina_holes();
// }
}

if(impresion){
translate([0,0,-9]) 
esquina_holder();
translate([0,-17,-9]) mirror([0,1,0])
esquina_holder();
}
//translate ([30,22,8]) rotate ([180,0,0]) {
//nema17(h=8,holes=0,shadow=5, polea=12);}