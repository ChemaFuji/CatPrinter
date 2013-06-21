// PRUSA Mendel  
// Default metric sizes
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

// DONT CHANGE THIS FILE! ALTER VALUES IN CONFIGURATION.SCAD INSTEAD

// RODS

threaded_rod_diameter = 8 + margen;
threaded_rod_diameter_horizontal = 8 + margen;
smooth_bar_diameter = 8 + margen/2;
smooth_bar_diameter_horizontal = 8 + margen/2;

// Nuts and bolts

m8_diameter = 8 + margen; //8mm
m8_nut_diameter = 15 + margen; //15mm (diámetro) || 13mm (entre caras)
m8_nut_size = 13 + margen;

m5_diameter = 5 + margen; //5mm
m5_nut_diameter = 9.24 + margen; //9.24mm (diámetro) || 8mm (entre caras)
m5_nut_size = 8 + margen;

m4_diameter = 4 + margen; //4mm
m4_nut_diameter = 8.08 + margen; //8.08mm (diámetro) || 7mm (entre caras)
m4_nut_size = 7 + margen;

m3_diameter = 3 + margen; //3mm
m3_nut_diameter = 6.35 + margen; //6.35mm (diámetro) || 5.5mm (entre caras)
m3_nut_size = 5.5 + margen;

// Bushing holder

bushing_core_diameter = smooth_bar_diameter;
bushing_material_thickness = 1;

// Motors

motor_shaft = 5 + margen;