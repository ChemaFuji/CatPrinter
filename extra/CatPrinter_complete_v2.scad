// New printer MOD by Chema

// Complete CatPrinter V2
// GNU GPL v3


include <../inc/config.scad>
use <../inc/bearing.scad>
include <../y_end_motor.scad>
include <../y_end_idler.scad>
include <../tensor-y.scad>
include <../carro-y_new3.scad>
include <../Z-axis.scad>
include <../carro-x_new.scad>

//la longitud de las barras del eje X viene dada por el tamaño de los carros Y 
//(yc_ancho=43 por 2 al ser dos carros) más el largo del carro X (40mm),
//es algo aproximado ya que los extrusores o soportes de hotend pueden ocupar algo más,
//más el espacio que se quiera imprimir
//p. ej. 250mm de impresión sería 86+40+250

longX=86+40+250;

//la longitud de las barras del eje Y viene dada por el área de impresión que 
// queremos en ese eje que es, para dos extrusores, la separación entre ellos 
// y el carro X (unos 10mm cada uno, un total de 20mm para CatNozzle)
// mas el espacio que ocupa el carro Y (24mm = separación entre poleas del carro Y+10)
// mas el espacio del y_end_idler (22mm = fondo) mas el espacio en el y_end_motor
// que es fondo+extra_long (22+6 aprox. ya que no llega el carro Y al tope)
// así será 20+34+22+28+longitud imprimible deseada
//p. ej. para tener 25cm es 20+34+22+28+250

longY=20+34+22+28+250;

//la longitud del eje Z depende de la altura que se quiera poder imprimir
//a ésta se le ha de sumar
//la altura del carro Z (50mm)
//esto último es aprox ya que la fijación del hotend no queda exactamente alineada con la barra
//del eje Y y esto está aún en desarrollo... Se calcula una altura de 60mm para hotend

//ej, queremos 200mm de altura de impresión pues longZ=250

longZ=250;

impresion=false;

//Para exportar a DXF las posiciones de los soportes
//quitar el doble slash de la linea projection y elegir la posición:

//para la cara de los idler:
//alturaZ=-430;
//rotacion=270;

//para la cara de motores y soportes eje Z
alturaZ=1;
rotacion=90;

//para exportar sólo planos de montaje (2D)
//projection(cut=true) translate([0,0,alturaZ]) rotate([0,rotacion,0])

//para vista normal
translate([0,0,0]) rotate ([0,180,-90])

{

zaxis();

translate([93+285-5,-longX/2,-longZ])
rotate([90,90,270])
ejeY();

translate([93+285-5,longX/2,-longZ])
rotate([90,90,270])
mirror([0,1,0])
ejeY();


translate([352-5,140-100,-longZ])
rotate([0,270,90])
carro_x_montado();

}


module ejeY(){
	yc_plain();
	
	
	//barra eje Y
	#translate([0,0,-60]) cylinder(r=4,h=440);

	
	// poleas
	translate ([0,-28.5-1,(yc_largo-sep_pol)/2]) rotate ([0,-90,0]) 
	 polea(diam=12,alto=8);
	translate ([0,-28.5-1,yc_largo-(yc_largo-sep_pol)/2]) rotate ([0,-90,0]) 
	 polea(diam=12,alto=8);
		
	//barras eje X	
	#translate([x_rod_distance/2,11,yc_largo/2]) rotate ([90,0,0])
		barrasX(205);
		
	
	// Y_end_motor
	translate([-altura+2,5.5,115+265-5]) mirror([0,1,0]) rotate([0,90,0]){
	 difference(){
	  esquinam_base();
	  esquinam_holes();
	 }
	
	//motor
	translate ([30,22,8]) rotate ([180,0,0]) {
	#nema17(h=8,holes=0,shadow=5, polea=12);}
	}
	
	//Y_end_idler
	translate([-24,5.5,-40-20]) rotate ([0,270,180])
	esquina_holder();
	
	//tensor
	translate([-11.5,-24.5+2,-30-20]) rotate ([0,0,0])
	y_tens();
}
