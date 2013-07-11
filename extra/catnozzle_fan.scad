// New printer MOD by Chema

// CatNozzle fan
// GNU GPL v3

include <../inc/config.scad>

// se ha de trabajar más, crear solapas que dirijan ventilación hacia la varilla,
// salvando el bloque calefactor
// también el soporte

impresion=true;
ancho_pl=70; //ancho de la pletina
paso=1.25; //paso para cierre curva en X, mas pequeño más se estrecha
pasod=1.3; //paso de altura, mas pequeño mas largo el cono
despv=2; //desplazamiento vertical del foco fan, mas pequeño mas se inclina hacia arriba (Y)
posc=16; //lugar en que cambia la curva
posf=30; //lugar en que termina la curva
grosp=0.8; //grosor paredes conducto
curva1=[15,15,15,15];
curva2=[7,7,7,7];
curva3=[1,1,1,1];
fhole=36; //hueco del ventilador
fhole2=25; //ancho en el punto de inflexión
fhole3=12; //ancho final
posh2=6; //posición vertical en el punto de inflexión
posh3=10; //posición vertical al final
giro1=8;
giro2=20;

module ventila_base(){
	difference(){
		union(){
		//base fijación ventilador
		cube_fillet(size=[40,40,3], vertical=[3,3,3,3], top=[0,0,0,0],center=true);
		if (brimw>0){
		translate([0,0,-1.5]){
		cube_fillet(size=[40+brimw*2,40+brimw*2,brimh], vertical=[3,3,3,3], top=[0,0,0,0],center=true);
		translate([0,14,0])
		cube_fillet(size=[40+brimw*4,3.5+brimw*2,brimh], vertical=[3,3,3,3], top=[0,0,0,0],center=true);
		}
		}
		}
		cylinder(r1=18,r2=16,h=20,center=true);
	}
	//cylinder(r=16,h=20,center=true);

	//conducto primer sistema
//	for(i=[0:30]){
//	translate([0,0,i/pasod]){
//	translate([0,i>15?9-(i/(4)):5,-1])
//	cube([34-i/paso,1,1],center=true);
//	difference(){
//		translate([0,(i>15?(8+i/2)/despv:i/despv),0]) rotate([-i/despv,0,0])
//		cube_fillet([34-i/paso,34-(i>15?(30-(10.77+i/3))/despv:i/despv),1], vertical=[15-i/2,15-i/2,15-i/2,15-i/2],center=true);
//		translate([0,(i>15?(8+i/2)/despv:i/despv),0]) rotate([-i/despv,0,0])
//		cube_fillet([34-2-i/paso,34-2-(i>15?(30-(10.77+i/3))/despv:i/despv),7], vertical=[15-i/2,15-i/2,15-i/2,15-i/2],center=true);
//	}}}

	//primera parte pala interna
	hull(){
	translate([0,5,-1.45-0.2])
	cube([fhole,grosp,0.1],center=true); 
	translate([0,9-posc/4,-1+posc/pasod])
	cube([fhole-posc/paso,grosp,0.1],center=true);}

	//segunda parte pala
	hull(){
	translate([0,9-posc/4,-1+posc/pasod])
	cube([fhole-posc/paso,grosp,0.1],center=true);
	translate([0,9-posf/4,-1+posf/pasod])
	cube([fhole-posf/paso,grosp,0.1],center=true);}


	//primera parte conducto
	difference(){
	hull(){
	
		translate([0,0,0]) rotate([0,0,0])
		cube_fillet([fhole,fhole,0.01],vertical=curva1,center=true);

		translate([0,0,posc/pasod])translate([0,posh2,0]) rotate([-giro1,0,0])
		cube_fillet([fhole-posc/paso,fhole2,0.01], vertical=curva2,center=true);

	}
	
	hull(){
		translate([0,(0),-0.05]) rotate([0,0,0])
		cube_fillet([fhole-grosp*2,fhole-grosp*2,0.01], vertical=curva1,center=true);

		translate([0,0,posc/pasod+0.05]) translate([0,posh2,0]) rotate([-giro1,0,0])
		cube_fillet([fhole-2*grosp-posc/paso,fhole2-2*grosp,0.01], vertical=curva2,center=true);

	}}


	//segunda parte conducto
	difference(){
	hull(){
		translate([0,0,posc/pasod])translate([0,posh2,0]) rotate([-giro1,0,0])
		cube_fillet([fhole-posc/paso,fhole2,0.01], vertical=curva2,center=true);

		translate([0,0,posf/pasod])translate([0,posh3,0]) rotate([-giro2,0,0])
		cube_fillet([fhole3,fhole2+2,0.01], vertical=curva3,center=true);

	}
	
	hull(){
		translate([0,0,posc/pasod-0.05]) translate([0,posh2,0]) rotate([-giro1,0,0])
		cube_fillet([fhole-2*grosp-posc/paso,fhole2-2*grosp,0.01], vertical=curva2,center=true);

		translate([0,0,posf/pasod+0.05]) translate([0,posh3,0]) rotate([-giro2,0,0])
		cube_fillet([fhole3-2*grosp,fhole2-2*grosp+2,0.01], vertical=curva3,center=true);
	}}


}

module pletina(){
	translate([-ancho_pl/2,22,-5]) rotate([90,0,0]){
	difference(){
		cube_fillet([ancho_pl,35,3]);
		translate([(ancho_pl-15)/2,30-18+6,-1])
		cube_fillet([15,25,5],vertical=[0,0,3,3]);
		translate([(ancho_pl-4.5)/2+25,30-10+1+5,-1])
		cube_fillet([4.5,10,5],vertical=[0,0,2,2]);
		translate([(ancho_pl-4.5)/2-25,30-10+1+5,-1])
		cube_fillet([4.5,10,5],vertical=[0,0,2,2]);
	translate([35,02+1,14+2])
	rotate([-90+giro2,0,0])
	hull(){
		translate([0,(0),-3]) rotate([0,0,0])
		cube_fillet([fhole-grosp,fhole-grosp,0.01], vertical=curva1,center=true);

		translate([0,0,posc/pasod+0.05]) translate([0,posh2,0]) rotate([-giro1,0,0])
		cube_fillet([fhole-grosp-posc/paso,fhole2-grosp,0.01], vertical=curva2,center=true);
	}
	
	translate([55+4,5,-10])
	rotate([0,0,-30])
	cube([30,30,30]);
	mirror([1,0,0])
	translate([-15+4,5,-10])
	rotate([0,0,-30])
	cube([30,30,30]);


	}
	}
}

module ventila(){
 difference(){
  union(){
	translate([0,5,1.5])
	ventila_base();
	difference(){
	translate([0,-0.5,6])
	rotate([-giro2,0,0])
	pletina();
	translate([-50,-50,-10]) cube([100,100,10]);
	}

  }
	translate([0,35+8,15])
	rotate([69,0,0])
	cylinder(r=5,h=100,$fn=16);
	translate([0,5,1.5])
	for (i=[-1,1]) { 
		for(j=[-1,1]){
			translate([i*16,j*16,20]) rotate([180,0,90])
				//cylinder(r=m3_diameter/2,h=20,center=true,$fn=8);
			 screw(r=m3_diameter/2, r_head=m3_nut_diameter/2,slant=false, head_drop=20, h=50, $fn=10, $fnn=6);
		}
	}
	
//	translate([25,10,0])
//	rotate([0,30,0])
//	cube([30,30,30]);
//	mirror([1,0,0])
//	translate([25,10,0])
//	rotate([0,30,0])
//	cube([30,30,30]);
		
	
 }
}

if(impresion){
 ventila();
// translate([0,32,23])
// rotate([70,0,0])
// cylinder(r=3,h=55,$fn=15);
}