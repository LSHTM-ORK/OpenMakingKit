use <write/Write.scad>

// Pick a color below for STL export, or "ALL" to show all colors. */
current_color = "ALL";
//current_color = "black";
//current_color = "white";
//current_color = "red";


multicolor("white"){
//color("blue",1)translate([0,0,-10])import("Jon_model.STL",centre=TRUE);
difference(){
union()
{
//front section    
cube([150,130,30]);
//back section for tubes    
translate([0,125,0]) cube([150,90,40]);



    
//ramp up to level2    
translate([0,125,30]) rotate([90,0,90]) cylinder(r=10,h=150,$fn=60);
translate([0,200,30]) cube([150,10,20]);

//ramp up to level3    
translate([0,190,30]) rotate([90,0,90]) cylinder(r=22,h=150,$fn=60);

rotate([-20,0,0])translate([0,170,110]) cube([150,11,80]);
translate([0,210,0]) cube([150,30,80]);
translate([0,220,0]) cube([150,30,120]);


//round front  
translate([0,0,8]) rotate([90,0,90]) cylinder(r=22,h=150,$fn=60);    
   
    
}

///get rid of some underneath to allow removal from plate
translate([0,50,0]) cube([10,10,2]);
translate([0,210,0]) cube([10,10,2]);
translate([140,50,0]) cube([10,10,2]);
translate([140,210,0]) cube([10,10,2]);
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

translate([65,68,30]) write("b-r-l",t=2,h=6,space=.8,center=false, font = "letters.dxf");
translate([95,68,30]) write("r-l-b",t=2,h=6,space=.8,center=false, font = "letters.dxf");
translate([125,68,30]) write("l-b-r",t=2,h=6,space=.8,center=false, font = "letters.dxf");
 

translate([20,67.5,30]) write("Archive",t=2,h=6,space=.8,center=false, font = "letters.dxf");
    

}
translate([0,55,28]) cube([150,3,2]);
//add FIEBRE!    
translate([15,209,60]) rotate([70,0,0])write("FIEBRE",t=1,h=30,space=1,center=false, font = "letters.dxf");   
//add slot for tablet
rotate([-20,0,0])translate([0,160,110]) cube([150,15,210]);

translate([-3,0,0])
{
//add holes for big tubes in front section    
translate([15,37,11]) cylinder(h=60,d=8.25,$fn=30);
translate([40,37,11]) cylinder(h=60,d=8.25,$fn=30);
translate([65,37,20]) cylinder(h=60,d=8.25,$fn=30);
translate([90,37,20]) cylinder(h=60,d=8.25,$fn=30);
translate([115,37,20]) cylinder(h=60,d=8.25,$fn=30);
translate([140,37,20]) cylinder(h=60,d=8.25,$fn=30);


    
//add holes for lids in front section
translate([15,25,28]) cylinder(h=60,d=9.5,$fn=30);
translate([40,25,28]) cylinder(h=60,d=9.5,$fn=30);
translate([65,25,28]) cylinder(h=60,d=9.5,$fn=30);
translate([90,25,28]) cylinder(h=60,d=9.5,$fn=30);
translate([115,25,28]) cylinder(h=60,d=9.5,$fn=30);
translate([140,25,28]) cylinder(h=60,d=9.5,$fn=30);
}



translate([-3,0,0])
{
//add holes for tubes in mid section    
translate([15,100,15]) cylinder(h=60,d=8.25,$fn=30);
translate([40,100,15]) cylinder(h=60,d=8.25,$fn=30);
translate([65,100,20]) cylinder(h=60,d=8.25,$fn=30);
translate([90,100,20]) cylinder(h=60,d=8.25,$fn=30);
translate([115,100,20]) cylinder(h=60,d=8.25,$fn=30);
translate([140,100,18]) cylinder(h=60,d=8.25,$fn=30);

//add holes for lids in mid section
translate([15,80,28]) cylinder(h=60,d=9.5,$fn=30);
translate([40,80,28]) cylinder(h=60,d=9.5,$fn=30);
translate([65,80,28]) cylinder(h=60,d=9.5,$fn=30);
translate([90,80,28]) cylinder(h=60,d=9.5,$fn=30);
translate([115,80,28]) cylinder(h=60,d=9.5,$fn=30);
translate([140,80,28]) cylinder(h=60,d=9.5,$fn=30);
}

translate([-3,0,0])
{
//add holes for randomiser in mid section    
translate([80,65,20]) cylinder(h=60,d=8,$fn=30);
translate([110,65,20]) cylinder(h=60,d=8,$fn=30);
translate([140,65,20]) cylinder(h=60,d=8,$fn=30);

}




//add holes for tubes in back section
translate([15,150,25]) cylinder(h=60,d=12.5,$fn=30);
translate([45,150,25]) cylinder(h=60,d=12.5,$fn=30);
translate([75,150,25]) cylinder(h=60,d=12.5,$fn=30);
translate([105,150,25]) cylinder(h=60,d=12.5,$fn=30);
translate([135,150,25]) cylinder(h=60,d=12.5,$fn=30);

//add holes for lids in back section
translate([15,130,35]) cylinder(h=60,d=12.5,$fn=30);
translate([45,130,35]) cylinder(h=60,d=12.5,$fn=30);
translate([75,130,35]) cylinder(h=60,d=12.5,$fn=30);
translate([105,130,35]) cylinder(h=60,d=12.5,$fn=30);
translate([135,130,35]) cylinder(h=60,d=12.5,$fn=30);

//remove bit underneath front
translate([0,-25,-20])cube([150,50,20]);

//add some screwholes for feet
translate([20,15,-20])cylinder(h=30,d=4,$fn=30);
translate([130,15,-20])cylinder(h=30,d=4,$fn=30);
translate([20,220,-20])cylinder(h=30,d=4,$fn=30);
translate([130,220,-20])cylinder(h=30,d=4,$fn=30);
}

//add studs for one handed opening
translate([9,148,25]) rotate(45,0,0) cube([3,3,2]);
translate([39,148,25]) rotate(45,0,0)  cube([3,3,3]);
translate([69,148,25]) rotate(45,0,0)  cube([3,3,3]);
translate([99,148,25]) rotate(45,0,0)  cube([3,3,3]);
translate([129,148,25]) rotate(45,0,0)  cube([3,3,3]);

}





 




// ADD Model 2 : Text

multicolor( "red"){
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
//add FIEBRE!    
translate([15,209,60]) rotate([70,0,0])write("FIEBRE",t=1,h=30,space=1,center=false, font = "letters.dxf");   
translate([0,55,28]) cube([150,3,2]);

}






/* Similar to the color function, but can be used for generating multi-color models for printing.
 * The global current_color variable indicates the color to print.
 */
module multicolor(color) {
    if (current_color != "ALL" && current_color != color) { 
        // ignore our children.
        // (I originally used "scale([0,0,0])" which also works but isn't needed.) 
    } else {
        color(color)
        children();
    }        
}

