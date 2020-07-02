use <write/Write.scad>

color( "red", 1.0 ){
//add text
translate([-10,-5,-2]){
translate([15,15,30]) write("Hist",t=2,h=6,space=.8,center=false, font = "letters.dxf");
translate([40,15,30]) write("Arbo",t=2,h=6,space=.8,center=false, font = "letters.dxf");
translate([65,15,30]) write("Bruc",t=2,h=6,space=.8,center=false, font = "letters.dxf");
translate([90,15,30]) write("Rick",t=2,h=6,space=.8,center=false, font = "letters.dxf");
translate([115,15,30]) write("Lept",t=2,h=6,space=.8,center=false, font = "letters.dxf");
translate([140,15,30]) write("Cr/Le",t=2,h=6,space=.8,center=false, font = "letters.dxf");
    
translate([15,7.5,30]) write("1 mL",t=2,h=6,space=.8,center=false, font = "letters.dxf");
translate([40,7.5,30]) write("1 mL",t=2,h=6,space=.8,center=false, font = "letters.dxf");
translate([65,7.5,30]) write("250 uL",t=2,h=6,space=.8,center=false, font = "letters.dxf");
translate([90,7.5,30]) write("200 uL",t=2,h=6,space=.8,center=false, font = "letters.dxf");
translate([115,7.5,30]) write("150 uL",t=2,h=6,space=.8,center=false, font = "letters.dxf");
translate([140,7.5,30]) write("50 uL",t=2,h=6,space=.8,center=false, font = "letters.dxf");
    
translate([20,67.5,30]) write("Archive",t=2,h=6,space=.8,center=false, font = "letters.dxf");


translate([65,68,30]) write("b-r-l",t=2,h=6,space=.8,center=false, font = "letters.dxf");
translate([95,68,30]) write("r-l-b",t=2,h=6,space=.8,center=false, font = "letters.dxf");
translate([125,68,30]) write("l-b-r",t=2,h=6,space=.8,center=false, font = "letters.dxf");
    

}
translate([0,55,28]) cube([150,3,2]);

}


