// esquina para new printer by Chema
// Mod basado en
// PRUSA iteration3
// Y axis motor end
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org
 
include <inc/config.scad>
extra_long=6;
impresion=true;

module esquinam_base(){
 translate([0,-3,0]) cube_fillet([8,40+5,34+2],top=[20,2,5,2]); // plate touching the back wall
 translate([0+4,-5,0]) 
 cube_fillet([41,5.01,22-4], vertical=[1,1,1,1], top=[2,2,2,10], center=false); //refuerzo lateral
 
 translate([0+4,-5,0]) cube_fillet([50-4,15,5]); // plate touching the motor (1/2)
 translate([0,-5+4,0]) cube_fillet([18,50-4,5]); // plate touching the motor (2/2)
	translate([11+extra_long/2,5,altura/2]) rotate([0,0,90]) 
	//soporte barra eje Y
	cube_fillet([ancho+2,fondo+extra_long,altura], vertical=[3,3,3,9], top=[2,2,2,2], center=true);
 if (brimw>0){
 translate([0+4-brimw,-5-brimw,0]) cube_fillet([50-4+brimw*2,15+brimw*2,brimh]); // plate touching the motor (1/2)
 translate([0-brimw,-5+4-brimw,0]) cube_fillet([18+brimw*2,50-4+brimw*2,brimh]); // plate touching the motor (2/2)
	translate([11+extra_long/2,5,altura/2]) rotate([0,0,90]) 
	//soporte barra eje Y
	cube_fillet([ancho+2,fondo+extra_long,altura], vertical=[3,3,3,9], top=[2,2,2,2], center=true);

 }
}

module esquinam_holes(){

 // Frame mounting screw holes
 translate([10,6,30]) rotate([0,90+180,0])
 screw(r=m3_diameter/2,r2=m3_nut_diameter, slant=false, head_drop=4, h=20, $fn=20,$fnn=6);
 translate([10,13+20,10]) rotate([0,90+180,0])
 screw(r=m3_diameter/2,r2=m3_nut_diameter, slant=false, head_drop=4, h=20, $fn=20,$fnn=6);
 translate([10,13+10,10+20]) rotate([0,90+180,0])
 screw(r=m3_diameter/2,r2=m3_nut_diameter, slant=false, head_drop=4, h=20, $fn=20,$fnn=6);

 //tornillo lateral
 translate([35,1,10]) rotate([0,90+180,90])
 screw(r=m3_diameter/2,r2=m3_nut_diameter, slant=false, head_drop=3, h=20, $fn=20,$fnn=6);


  // Hueco para barra lisa
  translate([2-3,5.5,altura-2]) rotate([270,0,270]) pushfit_rod(diam_x,100);
  // Bridas
	translate([16+3.5,5.5,altura-6.1])
	rotate([0,90,0])
   	brida(r=6);

	//Hueco centro para motor
	translate([30,22,-1])
	cylinder(r1=11.5,r2=10,h=30,$fn=30);

 // motor mounting
 translate([25+4.3,21,-1]){
 //translate([15.5,15.5,-1]) cylinder(h = 20, r=1.8, $fn=30);
 
 translate([15.5,-15.5,-1]) cylinder(h = 20, r=1.8, $fn=30);
 translate([-15.5,15.5,-1]) cylinder(h = 20, r=1.8, $fn=30);
 translate([-15.5,-15.5,47]) //cylinder(h = 200, r=1.8, $fn=30);
 rotate([180,0,0]) screw(r=m3_diameter/2, slant=false, head_drop=41, h=70, $fn=20);
 }

}

// Final part
module esquinam_holder(){
 difference(){
  esquinam_base();
  esquinam_holes();
 }
}

if (impresion){
esquinam_holder();
translate([0,-22,0]) mirror([0,1,0])
esquinam_holder();

//translate ([30,22,8]) rotate ([180,0,0]) {
//nema17(h=8,holes=0,shadow=5, polea=12);}
}