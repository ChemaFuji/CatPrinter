// esquina para new printer by Chema
// Mod basado en
// PRUSA iteration3
// Y axis motor end
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org
 
include <inc/config.scad>
extra_long=12;

module esquinam_base(){
 difference(){
	 translate([0,0,0]) cube([8,40,34]); // plate touching the back wall
	 translate([-1,0,36])
	 rotate([0,90,0])
	 cylinder(r=19,h=10,$fn=40);
 }
 translate([0+4,-5,0]) 
 cube_fillet([41,5.01,22-4], vertical=[1,1,1,1], top=[2,2,2,-15+2], center=false); //refuerzo lateral
 
 translate([0+4,-5,0]) cube([50-4,15,5]); // plate touching the motor (1/2)
 translate([0,-5+4,0]) cube([18,50-4,5]); // plate touching the motor (2/2)
	translate([11+extra_long/2,5,altura/2]) rotate([0,0,90]) 
	//soporte barra eje Y
	cube_fillet([ancho+2,fondo+extra_long,altura], vertical=[3,3,3,9], top=[2,2,2,2], center=true);

}

module esquinam_holes(){
 // corner cutouts
 translate([0.5,40-0.5,0]) rotate([0,0,-45+90]) translate([-15,0,-1]) cube([30,30,51]);
 translate([-4+11,40+5+5,0]) rotate([0,0,-45-0]) translate([0,0,-1]) cube([30,30,51]);
 translate([10,20,12+30]) rotate([-45,0,0]) rotate([0,-90,0]) translate([0,-5,0]) cube([30,50,30]);
 translate([50-2.5,-5+2.5,0]) rotate([0,0,-45-90]) translate([-15,0,-1]) cube([30,30,51]);
 translate([50-1.5,10-1.5,0]) rotate([0,0,-45]) translate([-15,0,-1]) cube([30,30,51]);

 // Frame mounting screw holes
 //translate([-1,10,10+5-5]) rotate([0,90,0]) cylinder(h = 20, r=1.8, $fn=30); //en la fijación barra
 translate([-1,13+20,10]) rotate([0,90,0]) cylinder(h = 20, r=1.8, $fn=30);
 translate([-1,13+10,10+20]) rotate([0,90,0]) cylinder(h = 20, r=1.8, $fn=30); //arriba

 // Frame mounting screw nut holes
 //%translate([4,10,10+5-5]) rotate([0,90,0]) cylinder(h = 50, r=3.1, $fn=30); //en la fijación barra
 translate([4+1,13+20,10]) rotate([0,90,0]) cylinder(h = 20, r=m3_nut_diameter/2, $fn=6);
 translate([4+1,13+10,10+20]) rotate([0,90,0]) cylinder(h = 20, r=m3_nut_diameter/2, $fn=6);
 //translate([4,13+10-3.1,10+20]) cube([10,6.2,10]);

  // Hueco para barra lisa
  #translate([2-3,5.5,altura-2]) rotate([0,90,0]) cylinder(h = 230, r=4.2, $fn=30); 
//  // Brida
//  translate([13,-15,altura-8]) rotate([0,0,90]) cube([ancho*2,3.5,2]);
  // Bridas
	translate([7+1,5.5,altura-6.1])
	rotate([0,90,0])
   	brida(r=6);
	translate([16+3.5,5.5,altura-6.1])
	rotate([0,90,0])
   	brida(r=6);
	translate([28,5.5,altura-6.1])
	rotate([0,90,0])
   	brida(r=6);

	//Hueco centro para motor
	translate([30,22,-1])
	cylinder(r1=11.5,r2=10,h=30,$fn=30);

  //Hueco para tornillo motor oculto
//  translate([23.1,1.1,5]) rotate([0,0,90])
//  cube_fillet([15,14,15], vertical=[1,1,1,8], top=[12,12,2,2], center=false);
//	cube([15,14,15]);
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
 translate([0,-17,0]) mirror([0,1,0]) difference(){
  esquinam_base();
  esquinam_holes();
 }
}

//esquinam_holder();
//translate ([30,22,8]) rotate ([180,0,0]) {
//nema17(h=8,holes=0,shadow=5, polea=12);}