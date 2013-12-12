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

corte1=false;
corte2=false;
corte3=false;

module bloque_base(){

		color("gainsboro") cube([largo,ancho,alto]);

		//aislamiento trespa
	translate([0,-lais/2,10.2]){
	 difference(){
		color("green") cube([largo,ancho+lais,6]);
		translate([3+rpral+2, (ancho+lais)/2,1])
		cylinder(r1=3,r2=5,h=6,$fn=16);
		translate([largo/2,4.5,-1]) cylinder(r=1.5,h=10,$fn=10);
		translate([largo/2,ancho+lais-4.5,-1]) cylinder(r=1.5,h=10,$fn=10);
		
	 }
	}
	translate([0,-lais/2,-6.2]){
	 difference(){
		color("green") cube([largo,ancho+lais,6]);
		translate([3+rpral+2, (ancho+lais)/2,1.01]){
		//cylinder(r1=3.5,r2=5,h=6,$fn=16);
			cylinder(r=6,h=5,$fn=16);
			translate([0,0,-1.05])
			cylinder(r=5,h=2,$fn=16);
		}
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
		translate([3+rpral*2+cal+term*3+2, alto/2, -ancho-1+4])
		color("gainsboro") cylinder(h = ancho+2, r= cal, $fn=30);

		//hueco del termistor
		rotate([90,0,0])
		translate([3+rpral+term*1.5, alto/2, -ancho/2+5])
		color("gainsboro") cylinder(h = ancho+2, r= term/1.5, $fn=10);

		//hueco roscado fijación
//		rotate([0,90,0])
//		translate([-alto/2, ancho/2, -1])
//		cylinder(h = 5, r= 1.5, $fn=30);
	}


}

module pletinalu(){
difference(){
		//Pletina superior
		translate([0,0,53])
		color("gainsboro") cube([20,65,4], center = true);
		//agujero central roscado M6
		translate([0,0,-1])
		color("gainsboro") cylinder(r=3.2,h=65,$fn=10);
		translate([0,0,53])
		//agujeros de fijación
		color("gainsboro") translate([0,25,1]) cylinder(r=2,h=10,$fn=10,center=true);
		translate([0,0,53])
		color("gainsboro") translate([0,-25,1]) cylinder(r=2,h=10,$fn=10,center=true);
		
	
	}
}

module nozzle(){
 difference(){
	 union(){
		translate([0,0,3])
		cylinder(r=5.5,h=5,$fn=6);
		translate([0,0,0])
		cylinder(r1=1,r2=4.5,h=3,$fn=16);
	 } 
	union(){
		translate([0,0,3.5])
		cylinder(r=3.2,h=5,$fn=20);
		translate([0,0,1])
		cylinder(r1=.5,r2=2.5,h=3,$fn=16);
		cylinder(r=.2,h=2,$fn=10);
	}
 }
}

difference(){

union(){
bloquecal();

translate([10-2,15,-5-3]){
difference(){
// Varilla roscada y hueca
translate([0,0,3.5])
color("gainsboro") cylinder(r=3,h=53,$fn=20);
cylinder(r=1.75,h=86,$fn=20);

}
//Nozzle
nozzle();

translate([0,0,1])
pletinalu();

}

//soporte ventilador
translate([32+4+3-2,15,24-2.5+2+0.9])
rotate([90+20,0,270])
ventila();
}

if (corte1){
	translate([25+18.5,0,0])
	cube([50,100,100],center=true);
	}
if(corte2){
	translate([25+8,0,0])
	cube([50,100,100],center=true);
}
if(corte3){
}
}