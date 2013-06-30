// New Printer by Chema
// GNU GPL v3
// Z carriage prototype V1

include <inc/config.scad>

impresion=false;

module motorz_base(){
	 translate([0,-5,0]) 
		cube_fillet([8,47,36], top=[20,2,20,2]); // plate touching the back wall

 translate([0+0,-5,0]) 
 cube_fillet([45,5.01,19], vertical=[1,1,3,2], top=[2,2,2,15], center=false); //refuerzo lateral
 
 translate([0+4,-5,0]) cube_fillet([50-4,15,5],top=[1,1,1,1]); // plate touching the motor (1/2)
 translate([0,-5+4,0]) cube_fillet([18,50-4,5],top=[1,1,1,1]); // plate touching the motor (2/2)

 //BRIM 
 if(brimw>0){
	 translate([4-brimw,-5-brimw,0]) 
		cube_fillet([50-4+2*brimw,15+2*brimw,brimh]); // plate touching the motor (1/2)
	 translate([0-brimw,-5+4-brimw,0]) 
		cube_fillet([18+brimw*2,50-4+brimw*2,brimh]); // plate touching the motor (2/2)

 }

}

module motorz_holes(){
 
 // Frame mounting screw holes
 translate([-1,5,10+5-5]) rotate([0,90,0]) cylinder(h = 20, r=1.8, $fn=30); //en la fijación barra
 translate([-1,5+31,10]) rotate([0,90,0]) cylinder(h = 20, r=1.8, $fn=30);
 translate([-1,5+15.5,10+20]) rotate([0,90,0]) cylinder(h = 20, r=1.8, $fn=30); //arriba

 // Frame mounting screw nut holes
 translate([4+1,5,10+5-5]) rotate([90,0,90]) cylinder(h = 50, r=3.1, $fn=6); //en la fijación barra
 translate([4+1,5+31,10]) rotate([90,0,90]) cylinder(h = 20, r=m3_nut_diameter/2, $fn=6);
 translate([4+1,5+15.5,10+20]) rotate([90,0,90]) cylinder(h = 20, r=m3_nut_diameter/2, $fn=6);
 //translate([4,13+10-3.1,10+20]) cube([10,6.2,10]);

 //aligerado
	translate([5,20,15]) rotate([0,90,0])
	cylinder(r=9,h=20,$fn=30,center=true);

	//Hueco centro para motor
	translate([30,22,-1])
	cylinder(r1=11.5,r2=10,h=30,$fn=30);

 // motor mounting
 translate([25+4.3,21,-1]){
 //translate([15.5,15.5,-1]) cylinder(h = 20, r=1.8, $fn=30);
 
 translate([15.5,-15.5,-1]) cylinder(h = 20, r=1.8, $fn=30);
 translate([-15.5,15.5,-1]) cylinder(h = 20, r=1.8, $fn=30);
 translate([-15.5,-15.5,-1]) cylinder(h = 20, r=1.8, $fn=30);
 }

}

// Final part motorz
module motorz(){
 difference(){
  motorz_base();
  motorz_holes();
 }
}

module esquinaz_base(){
	 translate([4,0,36/2]) 
	 cube_fillet([8,40,36],top=[20,2,20,2],center=true); // plate touching the back wall

	translate([(fromw+2)/2+0.3,0,28/2]) 
	cube_fillet([fromw+2.2,20,28], vertical=[3,3,3,3], top=[2,2,2,2], center=true);
	
	if(brimw>0){
		 translate([4,0,brimh/2]) 
		 cube_fillet([8+2*brimw,40+2*brimw,brimh],center=true); // plate touching the back wall
		translate([(fromw+2)/2+0.3,0,brimh/2]) 
		cube_fillet([fromw+2.2+2*brimw,20+2*brimw,brimh], vertical=[3,3,3,3], center=true);

	}
}

module esquinaz_holes(barra=false){

 // Frame mounting screw holes
 for(i=[-1,1]){
	translate([-6,i*13.5,5]) rotate([0,90,0]) cylinder(h = 20, r=1.8, $fn=30);
 }

	translate([-6,0,32]) rotate([0,90,0]) cylinder(h = 20, r=1.8, $fn=30);
 

// translate([-1,13,5]) rotate([0,90,0]) cylinder(h = 20, r=1.8, $fn=30);
// translate([-1,10+10,10+20]) rotate([0,90,0]) cylinder(h = 20, r=1.8, $fn=30);

// // Frame mounting screw nut holes
// translate([4,10-5,10+5]) rotate([90,0,90]) cylinder(h = 20, r=m3_nut_diameter/2, $fn=6);
// translate([4,10+20,10+5]) rotate([0,90,0]) cylinder(h = 20, r=m3_nut_diameter/2, $fn=6);
// translate([4,10+10,10+20]) rotate([0,90,0]) cylinder(h = 20, r=m3_nut_diameter/2, $fn=6);
//// translate([4,10+10-3.1,10+20+5]) cube([10,6.2,10]);

  // Hueco para barra lisa
  if(barra){
  	#translate([fromw,0,-longZ/2+20]) rotate([0,0,0]) cylinder(h = longZ+40, r=4.1, $fn=30, center=true); 
  }
  	translate([fromw,0,-140]) rotate([0,0,0]) cylinder(h = 350, r=4.1, $fn=30, center=true); 
  

  // Bridas
  //translate([13,-15,altura-8]) rotate([0,0,90]) cube([ancho*2,3.5,2]);
	translate([fromw-4,0,6])
	//rotate([0,90,0])
   	brida(r=6);
	translate([fromw-4,0,18])
	//rotate([0,90,0])
   	brida(r=6);

}

// Final part esquinaZ
module esquinaz(barra=false){
 difference(){
  esquinaz_base();
  esquinaz_holes(barra=barra);
 }
}

module carroz_base(){
 if(rfn){ //con refuerzo
	for(i=[-1,1]){
		translate([0,i*(cz_largo/2-cz_fondo),0])
		cube_fillet([cz_fondo,cz_fondo*2,cz_alto],vertical=[7,7,7,7],center=true);
		if(brimw>0){
			translate([0,i*(cz_largo/2-cz_fondo),-cz_alto/2+brimh/2])
			cube_fillet([cz_fondo+2*brimw,cz_fondo*2+brimw*2,brimh],vertical=[7,7,7,7],center=true);
		}
	}
	//travesaño entre pilares
	translate([0,0,-cz_alto/2+20/2])
	cube_fillet([cz_fondo/2,cz_largo-cz_fondo,20],vertical=[0,0,0,0],top=[0,3,0,3],center=true);
	if(brimw>0){
		translate([0,0,-cz_alto/2+brimh/2])
		cube_fillet([cz_fondo/2+2*brimw,cz_largo-cz_fondo+2*brimw,brimh],vertical=[0,0,0,0],center=true);
	
	}
 }else{ //sin refuerzo
	cube_fillet([cz_fondo,cz_largo,cz_alto],vertical=[7,7,7,7],center=true);
	if(brimw>0){
		cube_fillet([cz_fondo+brimw*2,2*brimw+cz_largo,brimh],vertical=[7,7,7,7],center=true);
	}
 }

 //fijaciones brazos
 for(i=[-1,1]){
	translate([cz_fondo,i*(cz_largo/2-cz_fondo/4),0])
	cube_fillet([cz_fondo*2.5,cz_fondo/2,cz_alto],vertical=[7,7,7,7],top=[5,0,5,-35],center=true);
	if(brimw>0){
		translate([cz_fondo,i*(cz_largo/2-cz_fondo/4),-cz_alto/2+brimh/2])
		cube_fillet([cz_fondo*2.5+2*brimw,cz_fondo/2+2*brimw,brimh],vertical=[7,7,7,7],center=true);

	}
 }
 if(impresion){
	//sin extras
 }else{
	 //Brazos
	 for(i=[-1,1]){
		 %translate([250/2+cz_fondo/2,i*(cz_largo/2-cz_fondo/2-grm/2),0])
		 difference(){
			 cube([250,grm,cz_alto],center=true);
			 translate([0,0,58]) rotate([0,7,0])
			 cube([350,grm*2,100],center=true);
	 }}
	
	 //plataforma impresión
	 translate([280/2+cz_fondo/2,0,-cz_alto/2-grm/2])
	 %cube([280,250,grm],center=true);
	 //refuerzo carroZ
 	 translate([-cz_fondo/2+grm/2-0.1,0,35/2-cz_alto/2])
	 %cube([grm,cz_largo-2*cz_fondo,35],center=true);

 }
}

module carroz_holes(){
 //para ver dontro de la viga
 //translate([-5,0,-40]) cube ([100,100,100]);

 //aligerando 
 if(rfn){ //con refuerzo
	//espacio para el refuerzo posterior
	translate([-cz_fondo/2+grm/2-0.1,0,100/2-cz_alto/2+(brimw?brimh:0)])
	cube([grm,cz_largo-2*cz_fondo,100],center=true);

	// tornillos de fijación del refuerzo
	for(i=[-1,1]){
		translate([-30,i*((cz_largo-2*cz_fondo)/2-10),4]) rotate([0,90,0])
		cylinder(r=m3_diameter/2,h=50,$fn=20);
		translate([-30,i*10,-17]) rotate([0,90,0])
		cylinder(r=m3_diameter/2,h=50,$fn=20);
	}
	
 }else{ //sin refuerzo

	 for(i=[-1,1]){
		difference(){
			translate([cz_fondo/2+esp,i*cz_largo/4-(i*5),0])
			cube_fillet([cz_fondo,cz_largo/2-30,cz_alto-12],vertical=[cur,cur,cur,cur],bottom=[cur,cur,cur,cur],center=true);
			translate([0,0,cz_alto*1.2]) rotate([0,90,0])
			cylinder(r2=sep_z/4,r1=sep_z-18,h=65,$fn=40,center=true);
		}
	 }
	
	 for(i=[-1,1]){
		difference(){
			translate([-cz_fondo/2-esp,i*cz_largo/4-(i*5),0])
			cube_fillet([cz_fondo,cz_largo/2-30,cz_alto-12],vertical=[cur,cur,cur,cur],bottom=[cur,cur,cur,cur],center=true);
			translate([0,0,cz_alto*1.2]) rotate([0,90,0])
			cylinder(r1=sep_z/4,r2=sep_z-18,h=65,$fn=40,center=true);
		}
	 }
	
	// Hueco central
	translate([0,0,cz_alto*1.2]) rotate([0,90,0])
	cylinder(r=sep_z/2-6,h=30,center=true);

 } //fin del if del refuerzo

 //hueco del sinfin
 translate([0,0,-55]) rotate([0,0,0]) cylinder(h = 170, r=2.6, $fn=30, center=true); 

 //huecos barras lisas
 for(i=[-1,1]){
 	translate([0,i*sep_z/2,0]) rotate([0,0,0]) cylinder(h = 170, r=bearing_diameter/2, $fn=30, center=true); 
 }

 // tornillos de fijación de brazos
 for(i=[-1,1]){
	translate([18,i*(cz_largo/2-0),-15]) rotate([90,0,0])
	cylinder(r=m3_diameter/2,h=50,$fn=20,center=true);
	translate([30,i*(cz_largo/2-cz_fondo/4),0]) rotate([180,0,0])
	screw(r=m3_diameter/2+0.1, slant=false, head_drop=13, h=50, $fn=6);
 }

 //hueco de la tuerca sinfín
 translate([0,0,-cz_alto/2+8])
 cylinder(r=m5_nut_diameter/2,h=4,$fn=6,center=true);
 translate([-cz_fondo/2,0,-cz_alto/2+8])
 cube([20,m5_nut_size,4], center=true);

}
module carroz(){
 difference(){
	carroz_base();
	carroz_holes();
 }
}

module zaxis(){
	//carro Z
	translate([fromw,0,-50])
	carroz();

	//Soportes inferiores barras
	for(i=[-1,1]){
		translate([0,i*sep_z/2,0])
		esquinaz(barra=true);
	}

	//Soportes superiores barras
	for(i=[-1,1]){
		translate([0,i*sep_z/2,-longZ])
		esquinaz(barra=false);
	}


	//Soporte Motor
	translate([0,-21,0]){
		motorz();
		translate ([29.5,21,-3]) rotate ([0,0,0]) 
		nema17(h=8,holes=true,shadow=5, polea=0);
		
	}

}

if (impresion){

	//carro Z
	translate([0,0,cz_alto/2])
	carroz();
	
	//Soportes inferiores barras
	for(i=[-1,1]){
		translate([15,i*25,0])
		esquinaz(barra=false);
	}

	//Soportes superiores barras
	for(i=[-1,1]){
		translate([65,i*55,0]) rotate([0,0,180])
		esquinaz(barra=false);
	}

	//Soporte Motor
	translate([90,5,0]) rotate([0,0,180])
		motorz();

}else{

	//zaxis();

}

