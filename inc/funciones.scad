// Nueva impresora by Chema <josema@pentabyte.es>
// Funciones que se usan en otros archivos
// GNU GPL v3
// Mod from
// Josef Průša <josefprusa@me.com>
// Václav 'ax' Hůla <axtheb@gmail.com>
// Vlnofka <>
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

module screw(h=20, r=2, r_head=3.5, head_drop=0, slant=true, poly=false, $fn=0, $fnn=0){
    //makes screw with head
    //for substraction as screw hole
    if (poly) {
        cylinder_poly(h=h, r=r, $fn=$fn);
    } else {
        cylinder(h=h, r=r, $fn=$fn);
    }
    if (slant) {
		if($fnn == 0) {
		translate([0, 0, head_drop-0.01]) cylinder(h=r_head, r2=0, r1=r_head, $fn=$fn);
		}else{
        translate([0, 0, head_drop-0.01]) cylinder(h=r_head, r2=0, r1=r_head, $fn=$fnn);
		}
    }

    if (head_drop > 0) {
		if($fnn == 0) {
        translate([0, 0, -0.01]) cylinder(h=head_drop+0.01, r=r_head, $fn=$fn);
		}else{
		translate([0, 0, -0.01]) cylinder(h=head_drop+0.01, r=r_head, $fn=$fnn);
		}
    }
}

module nema17(places=[1,1,1,1], size=15.5, h=10, holes=false, polea=false, shaft=true, shadow=false, $fn=24){
    for (i=[0:3]) {
        if (places[i] == 1) {
            rotate([0, 0, 90*i]) translate([size, size, 0]) {
                if (holes) {
                    #rotate([0, 0, -90*i])  translate([0,0,-h]) screw(r=1.7, slant=false, head_drop=13, $fn=$fn, h=h+12);
                } else {
                    //rotate([0, 0, -90*i]) cylinder(h=h, r=5.5, $fn=$fn);
                }
            }
        }
    }
    if (shadow != false) {
        translate ([0, 0, shadow+21+3]) cube([42,42,42], center = true);
    //flange
        translate ([0, 0, shadow+21+3-21-1]) cylinder(r=11,h=2, center = true, $fn=20);
     }

	if (polea != false) {
	translate ([0,0,-4-4]) cylinder(r=polea/2,h=16,center=true);
	translate ([0,0,-4-12]) cylinder(r=(polea/2)+2,h=1,center=true);
	translate ([0,0,-4-12+10]) cylinder(r=(polea/2)+2,h=1,center=true);
	}
	
	if(shaft){
   //shaft
        translate ([0, 0, shadow+21+3-21-7-5]) cylinder(r=2.5,h=24, center = true);
	}


}

module polea(diam=12,alto=9,imp=false){

  if(imp){
	difference(){
		union(){
		 cylinder(r=diam/2+0.3,h=alto/2,center=true);
		translate ([0,0,-alto/4]) 
		 cylinder(r=(diam/2)+2,h=1,center=true);
//		translate ([0,0,alto/2]) 
//		 cylinder(r=(diam/2)+2,h=1,center=true);
		}
	 translate ([0,0,alto/4-1.5])
	 cylinder(r=623_od/2+0.3,h=alto/2,center=true);
	 #cylinder(r=623_od/2-1,h=100,center=true);
	}
  }else{
	difference(){
		union(){
		 cylinder(r=diam/2,h=alto,center=true);
		translate ([0,0,-alto/2]) 
		 cylinder(r=(diam/2)+2,h=1,center=true);
		translate ([0,0,alto/2]) 
		 cylinder(r=(diam/2)+2,h=1,center=true);
		}
	 cylinder(r=1.6,h=100,center=true);
	}
  }	
}

module nut(d,h,horizontal=true){
    cornerdiameter =  (d / 2) / cos (180 / 6);
    cylinder(h = h, r = cornerdiameter, $fn = 6);
    if(horizontal){
        for(i = [1:6]){
            rotate([0,0,60*i]) translate([-cornerdiameter-0.2,0,0]) rotate([0,0,-45]) cube([2,2,h]);
        }
    }
}

// Based on nophead research
module polyhole(d, h, center=false) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}

// make it interchangeable between this and cylinder
module cylinder_poly(r, h, center=false){
    polyhole(d=r*2, h=h, center=center);
}

module fillet(radius, height=100, $fn=0) {
    //this creates actal fillet
	if (radius > -0.0001){
	    translate([-radius, -radius, -height/2-0.01])
	        difference() {
	            cube([radius*2, radius*2, height+0.02]);
	            cylinder(r=radius, h=height+0.02, $fn=$fn);
	        }
	}else{
	    //translate([-radius/2, -radius/2, -height/2-0.01])
		translate([0, 0, -height/2-0.01])
	        union() {
	            cube([-radius*2, -radius*2, height+0.02]);
	            cylinder(r=-radius, h=height+0.02, $fn=$fn);
	        }
	
		}
}

module cube_fillet(size, radius=-1, vertical=[3,3,3,3], top=[0,0,0,0], bottom=[0,0,0,0], center=false, $fn=0){
    //
    if (center) {
        cube_fillet_inside(size, radius, vertical, top, bottom, $fn);
    } else {
        translate([size[0]/2, size[1]/2, size[2]/2])
            cube_fillet_inside(size, radius, vertical, top, bottom, $fn);
    }
}

module cube_negative_fillet(size, radius=-1, vertical=[3,3,3,3], top=[0,0,0,0], bottom=[0,0,0,0], $fn=0){

    j=[1,0,1,0];

    for (i=[0:3]) {
        if (radius > -1) {
            rotate([0, 0, 90*i]) translate([size[1-j[i]]/2, size[j[i]]/2, 0]) fillet(radius, size[2], $fn=$fn);
        } else {
            rotate([0, 0, 90*i]) translate([size[1-j[i]]/2, size[j[i]]/2, 0]) fillet(vertical[i], size[2], $fn=$fn);
			
        }
        rotate([90*i, -90, 0]) translate([size[2]/2, size[j[i]]/2, 0 ]) fillet(top[i], size[1-j[i]], $fn=$fn);
        rotate([90*(4-i), 90, 0]) translate([size[2]/2, size[j[i]]/2, 0]) fillet(bottom[i], size[1-j[i]], $fn=$fn);

    }
}



module cube_fillet_inside(size, radius=-1, vertical=[3,3,3,3], top=[0,0,0,0], bottom=[0,0,0,0], $fn=0){
    //makes CENTERED cube with round corners
    // if you give it radius, it will fillet vertical corners.
    //othervise use vertical, top, bottom arrays
    //when viewed from top, it starts in upper right corner (+x,+y quadrant) , goes counterclockwise
    //top/bottom fillet starts in direction of Y axis and goes CCW too


    if (radius == 0) {
        cube(size, center=true);
    } else {
        difference() {
            cube(size, center=true);
            cube_negative_fillet(size, radius, vertical, top, bottom, $fn);
        }
    }
}

module pushfit_rod(diameter,length){
 cylinder(h = length, r=diameter/2, $fn=30);
 translate(v=[0,-diameter/4,length/2]) cube(size = [diameter,diameter/2,length], center = true);
 translate(v=[0,-diameter/2-2,length/2]) cube(size = [diameter,1,length], center = true);
}

module brida(w=4,h=2.5,r=10,size=[0,0,0]){
	difference(){
		resize(size)
	     cylinder(h = w, r=r+h, $fn=50, center=true);
	   	resize(size-[h,h,0])
	     cylinder(h = w*2, r=r, $fn=50, center=true);
	  }
}

module fija_correa(){
 difference(){
	union(){
		translate([0,0,(grueso_fijacion+fge)/2])
		cube([ancho_fijacion,(largo_fijacion/2-red_fijacion)*2,grueso_fijacion+fge],center=true);
		if(brimw>0){
			cube([ancho_fijacion+2*brimw,(largo_fijacion/2-red_fijacion)*2+2*brimw,brimh],center=true);
			for(i=[-1,1]){
				translate([i*(ancho_fijacion-2)/2,0,0])
				cylinder(r=largo_fijacion/2-red_fijacion+brimw,h=brimh,$fn=25,center=true);
			}
		}
		for(i=[-1,1]){
			translate([i*(ancho_fijacion-2)/2,0,(grueso_fijacion+fge)/2])
			cylinder(r=largo_fijacion/2-red_fijacion,h=grueso_fijacion+fge,$fn=25,center=true);
		}
	} //fin union

	// hueco correa
	translate([-belt_ancho/2-1,largo_fijacion,grueso_fijacion]) rotate([90,0,0])
	cube([belt_ancho+2,largo_fijacion,20]);

	//agujeros tornillos
	translate([ancho_fijacion/2,0,-largo_fijacion+2])
	screw(r=m3_diameter/2, slant=false, head_drop=0, h=50, $fn=15);
	translate([-ancho_fijacion/2,0,-largo_fijacion+2])
	screw(r=m3_diameter/2, slant=false, head_drop=0, h=50, $fn=15);

	//dientes fijación correa
 	for ( i = [0 : 33] ){
   		translate([-belt_ancho/2-1,25-i*belt_tooth_distance,grueso_fijacion-belt_grueso]) 
		 cube([belt_ancho+2,1.2,3]);
	}
 

 } //fin difference
}
