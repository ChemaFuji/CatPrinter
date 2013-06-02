//Poleas

include<inc/config.scad>

for (i=[0:3]) {
translate([20*i,0,0])
polea(imp=true);
translate([20*i,20,0])
polea(imp=true);
}

for (i=[0:3]) {
translate([20*i,40,0])
polea(imp=true);
translate([20*i,60,0])
polea(imp=true);
}