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
	for(i=[0:30]){
	translate([0,0,i/pasod]){
	translate([0,i>15?9-(i/(4)):5,-1])
	cube([34-i/paso,1,1],center=true);
	difference(){
		translate([0,(i>15?(8+i/2)/despv:i/despv),0]) rotate([-i/despv,0,0])
		cube_fillet([34-i/paso,34-(i>15?(30-(10.77+i/3))/despv:i/despv),1], vertical=[15-i/2,15-i/2,15-i/2,15-i/2],center=true);
		translate([0,(i>15?(8+i/2)/despv:i/despv),0]) rotate([-i/despv,0,0])
		cube_fillet([34-2-i/paso,34-2-(i>15?(30-(10.77+i/3))/despv:i/despv),7], vertical=[15-i/2,15-i/2,15-i/2,15-i/2],center=true);
	}}}
}

module pletina(){
	translate([-ancho_pl/2,22,0]) rotate([90,0,0]){
	difference(){
		cube_fillet([ancho_pl,30,3]);
		translate([(ancho_pl-10)/2,30-18+1,-1])
		cube_fillet([10,18,5],vertical=[0,0,3,3]);
		translate([(ancho_pl-4.5)/2+25,30-10+1+1,-1])
		cube_fillet([4.5,10,5],vertical=[0,0,2,2]);
		translate([(ancho_pl-4.5)/2-25,30-10+1+1,-1])
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
	translate([0,4,6])
	rotate([-15,0,0])
	pletina();
}

if(impresion){
 ventila();
// translate([0,32,23])
// rotate([75,0,0])
// cylinder(r=3,h=55,$fn=15);
}