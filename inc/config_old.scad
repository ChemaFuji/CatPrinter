// New Printer by Chema
// GNU GPL v3

// Mod basado en
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

// Esquinas:
altura = 40;
fondo = 22;
ancho = 18;
bajos = 6;

grueso=5;

//x_end data y-carriage
x_end_alto=33-10;
x_end_largo=55;
x_end_ancho=35+8;

//altura polea respecto barra superior
//pos barra altura-2 del motor
//pos polea (shaft motor 24mm, polea 18mm alto) 6mm sobre motor (+-2mm)
//espacio para polea (altura) = 12-14mm

//x_rod_distance = (altura-2+grueso-x_end_alto)*2; //29.25*2;
//x_rod_distance = 29.25*2-10;
x_rod_distance = 31+10; //x_end_alto+8;
y_rod_distance = 55;

bearing_diameter = 10.5;
thinwall = 2+1;
bearing_size = bearing_diameter + 2 * thinwall;

623_id=3;
623_od=10;
623_h=4;

//x-carriage
xc_alto=29.25;
xc_largo=90-50;
xc_ancho=altura-2+grueso-x_end_alto;



// PLEASE SELECT ONE OF THE CONFIGURATIONS BELOW
// BY UN-COMMENTING IT

// Uncomment for metric settings
// METRIC METRIC METRIC METRIC METRIC METRIC METRIC METRIC 

include <metric.scad>;

// Uncomment for imperial settings
// IMPERIAL IMPERIAL IMPERIAL IMPERIAL IMPERIAL IMPERIAL IMPERIAL 

//include <sae.scad>;

// LM8UU
linear = false;


// CHANGE ONLY THE STUFF YOU KNOW
// IT WILL REPLACE DEFAULT SETTING

// RODS

// threaded_rod_diameter = 0;
// threaded_rod_diameter_horizontal = 0;
// smooth_bar_díameter = 0;
// smooth_bar_díameter_horizontal = 0;

// Nuts and bolts

// m8_diameter = 0;
// m8_nut_diameter = 0;

// m4_diameter = 0;
// m4_nut_diameter = 0;

// m3_diameter = 0;
// m3_nut_diameter = 0;

// Bushing holder

// bushing_core_diameter = smooth_bar_díameter;
// bushing_material_thickness = 0;


///counted stuff
m3_nut_diameter_bigger = ((m3_nut_diameter  / 2) / cos (180 / 6))*2;

// funciones 
include <funciones.scad>


// Select your belt type ******************************************************

//T2.5
//belt_tooth_distance = 2.5;
//belt_tooth_ratio = 0.5;

//T5 (strongly discouraged)
//belt_tooth_distance = 5;
//belt_tooth_ratio = 0.75;

//HTD3
//belt_tooth_distance = 3;
//belt_tooth_ratio = 0.75;

//MXL
//belt_tooth_distance = 2.032;
//belt_tooth_ratio = 0.64;

//GT2
belt_tooth_distance = 2;
belt_tooth_ratio = 0.5;
belt_grueso = 0.75;
belt_ancho = 6;

