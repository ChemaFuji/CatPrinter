// New Printer by Chema
// GNU GPL v3

// Mod basado en
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

margen=0.2; //margen en diámetro para los agujeros
brimh=0.4; //altura de capa para brim
brimw=5; //cuanto brim (5)

// Extremos eje Y
altura = 20; //original 40
fondo = 22;
ancho = 18;
bajos = 6;

grueso=5;

//Carro Y
	yc_alto=19; //33-10-6+2;
	yc_largo=55-4;
	yc_ancho=35+8;
	sep_pol=24; //separación entre ejes de poleas

	
	//altura polea respecto barra superior
	//pos barra altura-2 del motor
	//pos polea (shaft motor 24mm, polea 18mm alto) 6mm sobre motor (+-2mm)
	//espacio para polea (altura) = 12-14mm
	
	//x_rod_distance = (altura-2+grueso-yc_alto)*2; //29.25*2;
	//x_rod_distance = 29.25*2-10;
	x_rod_distance = 31+10; //separación de barras eje X
	y_rod_distance = 55; //separación de barras eje Y (en caso de dos barras) Obsoleto
	diam_x=8.1; //Diámetro de la barra lisa del eje X 8.1 PLA, 8.4 ABS
	belt_space=10; //paso para las correas


bearing_diameter = 10+margen; //diámetro de los cojinetes lineales
thinwall = 2+1; //pared en los cojinetes
bearing_size = bearing_diameter + 2 * thinwall;

sep_tensor=18.5-2; //espacio entre el eje del tensor y la barra lisa eje Y

//Medidas bearing 623
623_id=3;
623_od=10;
623_h=4;

//Carro X
	xc_largo=40; //largo del carro X
	//xc_ancho=altura-2+grueso-yc_alto;
	xc_ancho=sep_pol; //espacio entre ejes poleas en carro Y (==ancho carro X)
	//fijaciones correa carro X
	grueso_fijacion=4; //este grueso incluye el grosor de la correa (0.75mm para GT2==belt_grueso)
	ancho_fijacion=12; //entre centros de los agujeros
	largo_fijacion=10; 
	red_fijacion=0.4; //cuanto más pequeña es la fijación con respecto a su hueco en el carro X
	fge=1.0; //grueso extra de la fijación correa
	tbf=3.5; //espacio entre fijación y su tuerca

// Carro Z
	rfn=true; //¿lleva refuerzo?
	grm=6; //grosor material refuerzo
	sep_z=150; //separación entre las esquinas
	fromw=29.5; //separación barra lisa de la pared
	cz_fondo=20; //fondo del carro Z
	cz_alto=50;
	cz_largo=sep_z+20;
	 esp=6/2; //la mitad del espesor que queremos en la viga
	 cur=cz_fondo/2-esp;

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
m5_nut_diameter_bigger = ((m5_nut_diameter  / 2) / cos (180 / 6))*2;

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

