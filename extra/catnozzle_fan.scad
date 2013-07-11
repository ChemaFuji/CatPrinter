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

module ventila_base(){
	difference(){
		//base fijación ventilador
		cube_fillet(size=[40,40,3], vertical=[3,3,3,3], top=[0,0,0,0],center=true);
		for (i=[-1,1]) { 
			for(j=[-1,1]){
				translate([i*15,j*15,0])
					cylinder(r=m3_diameter/2,h=20,center=true);
			}
		}
		cylinder(r=16,h=20,center=true);
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
	translate([0,5,-1.45])
	cube([34,grosp,0.1],center=true); 
	translate([0,9-posc/4,-1+posc/pasod])
	cube([34-posc/paso,grosp,0.1],center=true);}

	//primera parte conducto
	difference(){
	hull(){
	
		translate([0,0,0]) rotate([0,0,0])
		cube_fillet([34,34,0.01],vertical=[15,15,15,15],center=true);
		translate([0,0,posc/pasod])translate([0,((8+posc/2)/despv),0]) rotate([-posc/despv,0,0])
		cube_fillet([34-posc/paso,34-((30-(10.77+posc/3))/despv),0.01], vertical=[15-posc/2,15-posc/2,15-posc/2,15-posc/2],center=true);

	}
	
	hull(){
		translate([0,(0),-0.05]) rotate([0,0,0])
		cube_fillet([34-grosp*2,34-grosp*2,0.01], vertical=[15,15,15,15],center=true);

		translate([0,0,posc/pasod+0.05]) translate([0,((8+posc/2)/despv),0]) rotate([-posc/despv,0,0])
		cube_fillet([34-2*grosp-posc/paso,34-2*grosp-((30-(10.77+posc/3))/despv),0.01], vertical=[15-posc/2,15-posc/2,15-posc/2,15-posc/2],center=true);

	}}


	//segunda parte pala
	hull(){
	translate([0,9-posc/4,-1+posc/pasod])
	cube([34-posc/paso,grosp,0.1],center=true);
	translate([0,9-posf/4,-1+posf/pasod])
	cube([34-posf/paso,grosp,0.1],center=true);}

	//segunda parte conducto
	difference(){
	hull(){
		translate([0,0,posc/pasod])translate([0,((8+posc/2)/despv),0]) rotate([-posc/despv,0,0])
		cube_fillet([34-posc/paso,34-((30-(10.77+posc/3))/despv),0.01], vertical=[15-posc/2,15-posc/2,15-posc/2,15-posc/2],center=true);

		translate([0,0,posf/pasod])translate([0,((8+posf/2)/despv),0]) rotate([-posf/despv,0,0])
		cube_fillet([34-posf/paso,34-((30-(10.77+posf/3))/despv),0.01], vertical=[15-posf/2,15-posf/2,15-posf/2,15-posf/2],center=true);

	}
	
	hull(){
		translate([0,0,posc/pasod-0.05]) translate([0,((8+posc/2)/despv),0]) rotate([-posc/despv,0,0])
		cube_fillet([34-2*grosp-posc/paso,34-2*grosp-((30-(10.77+posc/3))/despv),0.01], vertical=[15-posc/2,15-posc/2,15-posc/2,15-posc/2],center=true);

		translate([0,0,posf/pasod+0.05]) translate([0,((8+posf/2)/despv),0]) rotate([-posf/despv,0,0])
		cube_fillet([34-2*grosp-posf/paso,34-2*grosp-((30-(10.77+posf/3))/despv),0.01], vertical=[15-posf/2,15-posf/2,15-posf/2,15-posf/2],center=true);
	}}


}

module pletina(){
	translate([-ancho_pl/2,22,-5]) rotate([90,0,0]){
	difference(){
		cube_fillet([ancho_pl,35,3]);
		translate([(ancho_pl-15)/2,30-18+3,-1])
		cube_fillet([15,25,5],vertical=[0,0,3,3]);
		translate([(ancho_pl-4.5)/2+25,30-10+1+5,-1])
		cube_fillet([4.5,10,5],vertical=[0,0,2,2]);
		translate([(ancho_pl-4.5)/2-25,30-10+1+5,-1])
		cube_fillet([4.5,10,5],vertical=[0,0,2,2]);
		

	}
	}
}

module ventila(){
 difference(){
	translate([0,5,1.5])
	ventila_base();
	translate([0,10,30])
	rotate([90,0,0])
	cylinder(r=3,h=10,$fn=16);
	
	
 }
	difference(){
	translate([0,4,6])
	rotate([-15,0,0])
	pletina();
	translate([-50,-50,-10]) cube([100,100,10]);
	}
}

if(impresion){
 ventila();
// translate([0,32,23])
// rotate([75,0,0])
// cylinder(r=3,h=55,$fn=15);
}