// PRUSA iteration3
// Bearing holders
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org
// Mod by Chema (2013) for new printer

include<config.scad>

module horizontal_bearing_base(bearings=1){
 translate(v=[0,0,6]) cube(size = [24,8+bearings*25,12], center = true);	
}
module horizontal_bearing_holes(bearings=1){
 cutter_lenght = 10+bearings*25;
 one_holder_lenght = 8+25;
 holder_lenght = 8+bearings*25;
 
 // Main bearing cut
 difference(){
  translate(v=[0,0,12+1.5]) rotate(a=[90,0,0]) translate(v=[0,0,-cutter_lenght/2]) cylinder(h = cutter_lenght, r=bearing_diameter/2, $fn=50);
  // Bearing retainers
  translate(v=[0,1-holder_lenght/2,3+1.5]) cube(size = [24,6,8], center = true);
  translate(v=[0,-1+holder_lenght/2,3+1.5]) cube(size = [24,6,8], center = true);
 }
 
 // Ziptie cutouts
 ziptie_cut_ofset = 0;
 for ( i = [0 : bearings-1] ){
  // For easier positioning I move them by half of one 
  // bearing holder then add each bearign lenght and then center again
  translate(v=[0,-holder_lenght/2,0]) translate(v=[0,one_holder_lenght/2+i*25,0]) difference(){
   union(){
    translate(v=[0,2-6-2,12]) rotate(a=[90,0,0]) translate(v=[0,0,0]) cylinder(h = 4, r=12.5, $fn=50);
    translate(v=[0,2+6+2,12]) rotate(a=[90,0,0]) translate(v=[0,0,0]) cylinder(h = 4, r=12.5, $fn=50);
   }
   translate(v=[0,10,12]) rotate(a=[90,0,0]) translate(v=[0,0,0]) cylinder(h = 24, r=10, $fn=50);
  }
 }
 
}

module horizontal_bearing_test(){
 difference(){
  horizontal_bearing_base(1);
  horizontal_bearing_holes(1);
 }
 translate(v=[30,0,0]) difference(){
  horizontal_bearing_base(2);
  horizontal_bearing_holes(2);
 }
 translate(v=[60,0,0]) difference(){
  horizontal_bearing_base(3);
  horizontal_bearing_holes(3);
 }
}





module vertical_bearing_base(largo=60,ancho=bearing_size,$fn=60,brimw=0){
 translate(v=[-(ancho)/2,0,largo/2]) 
  cube(size = [ancho+(brimw*2),bearing_size+(brimw*2),largo], center = true);
  cylinder(h = largo, r=bearing_size/2+brimw, $fn = $fn);
}

module vertical_bearing_holes(largo=60,corte=false,$fn=60){
  translate(v=[0,0,-1]) cylinder(h = largo+2, r=bearing_diameter/2, $fn = $fn);
	if(corte){
    		rotate(a=[0,0,-largo]) translate(v=[bearing_diameter/2+thinwall,0,largo/2]) 
		cube(size = [bearing_diameter+thinwall,1,largo+2], center = true);
	}
}

module soporte_bearing(largo=25,ancho=bearing_size,corte=false,$fn=60,brimw=0,brimh=0.4){
	difference(){
	if(brimw>0){
		union(){
		vertical_bearing_base(largo=largo,ancho=ancho,$fn=$fn,brimw=0);
		vertical_bearing_base(largo=brimh,ancho=ancho,$fn=$fn,brimw=brimw);
		}

	} else {
	vertical_bearing_base(largo=largo,ancho=ancho,$fn=$fn);
	}
	vertical_bearing_holes(largo=largo,corte=corte);
	}
}
//soporte_bearing(largo=30,ancho=50,corte=true,brimw=5,brimh=0.4);
//%cube ([10,12,25]);
//translate([-50,0,0]) cube([50,10,30]);
//translate([-50+bearing_size/2,0,0]) cube([50,10,10]);
//horizontal_bearing_test();