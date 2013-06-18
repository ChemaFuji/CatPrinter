// New printer MOD by Chema

// CatNozzle fan
// GNU GPL v3

include <../inc/config.scad>

// se ha de trabajar más, crear solapas que dirijan ventilación hacia la varilla,
// salvando el bloque calefactor
// también el soporte

module ventila(){
	difference(){
		//base fijación ventilador
		cube_fillet(size=[40,40,3], vertical=[3,3,3,3], top=[0,0,0,0],center=true);
		for (i=[-1,1]) { 
			for(j=[-1,1]){
				translate([i*15,j*15,0])
					%cylinder(r=m3_diameter/2,h=20,center=true);
			}
		}
		cylinder(r=16,h=20,center=true);
	}
}

translate([0,0,1.5])
ventila();
