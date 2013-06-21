sep_z=150; //separación entre las esquinas
fromw=29.5; //separación barra lisa de la pared
cz_fondo=20; //fondo del carro Z
cz_alto=50;
cz_largo=sep_z+20;
 esp=6/2; //la mitad del espesor que queremos en la viga
 cur=cz_fondo/2-esp;
i=1;
	mikowski(){
	difference(){
		translate([cz_fondo/2+esp+30,i*cz_largo/4-(i*5),0])
		cube([cz_fondo,cz_largo/2-30,cz_alto-12],center=true);
		translate([0,0,cz_alto*1.2]) rotate([0,90,0])
		cylinder(r=sep_z/2,h=150,center=true);
	} 
	translate([cz_fondo/2+esp+30,i*cz_largo/4-(i*5),0])
	sphere(cur);
	}