// catnozzle v0.7.5 beta
// bloque calefactor
// GNU GPL v3
// Chema (josema@pentabyte.es) and contributors

include<../extra/catnozzle_fan.scad>
impresion=false;


largo = 25; //medidas del bloque calefactor
ancho = 30;
alto = 10;
rpral = 6/2;
term = 1.5;
cal = 6/2;
lais = 12; //largo extra del aislamiento

module bloque_base(){

		color("gainsboro") cube([largo,ancho,alto]);

		//aislamiento trespa
	translate([0,-lais/2,10]){
	 difference(){
		color("green") cube([largo,ancho+lais,6]);
		translate([3+rpral+2, (ancho+lais)/2,1])
		cylinder(r1=3,r2=5,h=6,$fn=16);
		translate([largo/2,4.5,-1]) cylinder(r=1.5,h=10,$fn=10);
		translate([largo/2,ancho+lais-4.5,-1]) cylinder(r=1.5,h=10,$fn=10);
		
	 }
	}
	translate([0,-lais/2,-6]){
	 difference(){
		color("green") cube([largo,ancho+lais,6]);
		translate([3+rpral+2, (ancho+lais)/2,-.1])
		cylinder(r1=3.5,r2=5,h=6,$fn=16);
		translate([largo/2,4.5,-1]) cylinder(r=1.5,h=10,$fn=10);
		translate([largo/2,4.5,-1]) cylinder(r=3,h=4,$fn=10);
		translate([largo/2,ancho+lais-4.5,-1]) cylinder(r=1.5,h=10,$fn=10);	
		translate([largo/2,ancho+lais-4.5,-1]) cylinder(r=3,h=4,$fn=10);	
	 }
	}
}

module bloquecal()
{

	difference() {
		//bloque
		bloque_base();
		
		//hueco del portafilamento
		translate([3+rpral+2, ancho/2, -15])
		color("gainsboro") cylinder(h = alto+50, r = rpral);
		
		//hueco del calefactor
		rotate([90,0,0])
		translate([3+rpral*2+cal+term*3+2, alto/2, -ancho-1])
		color("gainsboro") cylinder(h = ancho+2, r= cal, $fn=30);

		//hueco del termistor
		rotate([90,0,0])
		translate([3+rpral+term*1.5, alto/2, -ancho-1])
		color("gainsboro") cylinder(h = ancho+2, r= term/1.5, $fn=10);

		//hueco roscado fijación
//		rotate([0,90,0])
//		translate([-alto/2, ancho/2, -1])
//		cylinder(h = 5, r= 1.5, $fn=30);
	}


}

bloquecal();

translate([10-2,15,-5]){
difference(){
color("gainsboro") cylinder(r=3,h=55,$fn=20);
cylinder(r=1.75,h=56,$fn=20);

}
cylinder(r=4,h=6,$fn=6);
translate([0,0,-3])
cylinder(r1=1,r2=3.5,h=3,$fn=16);

difference(){
		translate([0,0,53])
		color("gainsboro") cube([20,65,4], center = true);
		translate([0,0,-1])
		color("gainsboro") cylinder(r=1.75,h=65,$fn=10);
		translate([0,0,53])
		color("gainsboro") translate([0,25,1]) cylinder(r=2,h=10,$fn=10,center=true);
		translate([0,0,53])
		color("gainsboro") translate([0,-25,1]) cylinder(r=2,h=10,$fn=10,center=true);
		
	
	}
}

translate([32+4+3,15,24-2.5])
rotate([90+15,0,270])
ventila();