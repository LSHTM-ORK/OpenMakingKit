h1=101;

//color("blue",1)translate([0,0,-10])import("Jon_model.STL",centre=TRUE);

difference()
{
cube([167.6,30.7,h1]);
cube([6.4,27.8,h1]);    
translate([167.6-6.3,0,0])cube([6.4,27.8,h1]);    
translate([10.35,6,0])cube([147.4,27.8,h1+3]);    
cube(3,5,3);
translate([0,27,10])cube([2,7,3]);
translate([0,27,42.5])cube([2,7,3]);
translate([0,27,55.5])cube([2,7,3]);
translate([0,27,88])cube([3,7,3]);
translate([165.5,27,10])cube([2.5,7,3]);
translate([165.5,27,42.5])cube([2.5,7,3]);
translate([165.5,27,55.5])cube([2.5,7,3]);
translate([164.5,27,88])cube([3.5,7,3]);
}
