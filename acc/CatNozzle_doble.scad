// catnozzle v0.0.0 alfa
// bloque calefactor
// GNU GPL v3
// Chema (josema@pentabyte.es) and contributors

largo = 25;
ancho = 30;
alto = 10;
rpral = 6/2;
term = 1.5;
cal = 6/2;
plet_long=65+10;

module bloquecal()
{

	difference() {
		//bloque
		cube([largo,ancho,alto]);
		
		//hueco del portafilamento
		translate([3+rpral+2, ancho/2, -1])
		cylinder(h = alto+2, r1 = rpral, r2=rpral);
		
		//hueco del calefactor
		rotate([90,0,0])
		translate([3+rpral*2+cal+term*3+2, alto/2, -ancho-1])
		cylinder(h = ancho+2, r= cal, $fn=30);

		//hueco del termistor
		rotate([90,0,0])
		translate([3+rpral*2+term*1.5, alto/2, -ancho-1])
		cylinder(h = ancho+2, r= term/1.5, $fn=10);

		//hueco roscado fijación
		rotate([0,90,0])
		translate([-alto/2, ancho/2, -1])
		cylinder(h = 5, r= 1.5, $fn=30);
	}


}

bloquecal();


translate([0,40,0]){
bloquecal();
translate([10-2,15,-5]){
cylinder(r=3,h=55,$fn=20);
cylinder(r=4,h=6,$fn=6);
translate([0,0,-3])
cylinder(r1=1,r2=3.5,h=3,$fn=16);

}}

translate([10-2,15,-5]){
cylinder(r=3,h=55,$fn=20);
cylinder(r=4,h=6,$fn=6);
translate([0,0,-3])
cylinder(r1=1,r2=3.5,h=3,$fn=16);

translate([0,20,53]){
		difference(){
		cube([20,plet_long,4], center = true);
		//translate([0,0,53])
		translate([0,30,1]) cylinder(r=2,h=10,$fn=10,center=true);
		//translate([0,0,53])
		translate([0,-30,1]) cylinder(r=2,h=10,$fn=10,center=true);
		}
	
	}
}