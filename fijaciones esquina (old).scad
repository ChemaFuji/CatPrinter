// Nueva impresora by Chema
// Esquinas
// GNU GPL v3
// Chema Muñoz (josema@pentabyte.es)

include <inc/config.scad>

// *************** Esquina *************************

module agujeros_esquina(){
 translate([-11,-11,0]){
  // fijación pared abajo
  translate([0,fondo/2,altura-17]) rotate([0,90,0]) translate([0,0,-5]) cylinder(h = 270, r=1.6, $fn=30);
  // Fijación pared arriba
  translate([(ancho+4)/2,0,altura-12]) rotate([0,90,90]) translate([0,0,-5]) cylinder(h = 270, r=1.6, $fn=30);
  // Acceso para el tornillo
  translate([11,0,14+bajos]) rotate([0,0,90]) rotate([0,90,0]) translate([0,0,-5]) {
	cylinder(h = 270, r=4, $fn=30);
	translate([7,0,20])
	cube(size=[14,8,50],center=true);
	}
  // Agujero del tornillo
  translate([11,11,00]) rotate([0,0,0]) translate([0,0,-5]) cylinder(h = 20, r=1.6, $fn=30);

  // Hueco para barra lisa
  translate([(ancho+4)/2,2-5,altura-2]) rotate([0,90,90]) cylinder(h = 23, r=4.2, $fn=30); 
  // Brida
  translate([-5,(fondo/2)-2,altura-8])  cube([ancho*2,3.5,2]);
 }
}

// Final
module esquina(){
 // Rotate the part for better printing
 translate([0,0,11]) rotate([-90,180,0]) difference(){
	translate([0,0,altura/2]) cube_fillet([ancho,fondo,altura], vertical=[3,3,8,3], top=[2,2,2,2], center=true);
  	agujeros_esquina();
 }
}
// ***********************************************

esquina();
translate ([15.5,0+8,-5]) rotate ([90,0,0]) {
nema17(h=8,holes=true,shadow=5, polea=12);}

//translate ([0,-bearing_size/2-21,0]) cube([5,x_rod_distance+21,5]);