
difference()
{

union()
{
difference()
{

union(){
cube([160,15,5]);
translate([72.5,0,0])cube([15,149,5]);
translate([72.5,-20,0])cube([15,50,25]);

}

translate([5,5,0])cube([150,5,5]);
translate([5,5,0])cube([150,5,5]);

//make triangle support
translate([72.5,-11,27])rotate([-29,0,0])cube([15,55,25]);

//add slot to vertical slider
translate([77.5,-5,0])cube([5,149,5]);

}

//add stalk for eyepiece clamp
translate([72.5,-50,0])cube([15,100,5]);

//put on big block for eyepiece clamp
translate([50,-70,0])cube([60,50,40]);
}


//add outer cylinder for eyepiece
translate([80,-45,0])cylinder(h = 60, d = 40, $fn=60);

//slice eyepiece region
translate([45,-45,0])cube([70,2,50]);

//add screwholes
translate([55,-5,10])rotate([90,0,0])cylinder(h = 80, d = 5, $fn=60);
translate([55,-5,20])rotate([90,0,0])cylinder(h = 80, d = 5, $fn=60);
translate([55,-5,30])rotate([90,0,0])cylinder(h = 80, d = 5, $fn=60);
translate([105,-5,10])rotate([90,0,0])cylinder(h = 80, d = 5, $fn=60);
translate([105,-5,20])rotate([90,0,0])cylinder(h = 80, d = 5, $fn=60);
translate([105,-5,30])rotate([90,0,0])cylinder(h = 80, d = 5, $fn=60);

}


difference()
{
//add inner cylinder for eyepiece
translate([80,-45,0])cylinder(h = 40, d = 39, $fn=60);
translate([80,-45,0])cylinder(h = 40, d = 33, $fn=60);

//slice eyepiece region
translate([45,-45,0])cube([70,2,50]);
}

//add clamps left right bottom

translate([-50,0,0])
{
difference(){    
cube([40,15,20]);
translate([11,0,16])cube([17,25,20]);
translate([19.5,10.5,0])cylinder(h = 80, d = 5, $fn=60); 
translate([0,0,6])cube([40,6,20]);    
rotate([45,0,0])translate([0,0,0])cube([40,8.5,20]);    

}
}


//add clamps left right bottom

translate([-50,20,0])
{
difference(){    
cube([40,15,20]);
translate([11,0,16])cube([17,25,20]);
translate([19.5,10.5,0])cylinder(h = 80, d = 5, $fn=60); 
translate([0,0,6])cube([40,6,20]);    
rotate([45,0,0])translate([0,0,0])cube([40,8.5,20]);    

}
}

//add clamps left right bottom

translate([-50,40,0])
{
difference(){    
cube([40,15,20]);
translate([11,0,16])cube([17,25,20]);
translate([19.5,10.5,0])cylinder(h = 80, d = 5, $fn=60); 
translate([0,0,6])cube([40,6,20]);    
rotate([45,0,0])translate([0,0,0])cube([40,8.5,20]);    

}
}

//add washers

translate([-100,20,0])
{
difference(){    
cylinder(h = 2, d = 15, $fn=60); 
cylinder(h = 2, d = 5, $fn=60); 
}
}

translate([-100,40,0])
{
difference(){    
cylinder(h = 2, d = 15, $fn=60); 
cylinder(h = 2, d = 5, $fn=60); 
}
}

translate([-100,60,0])
{
difference(){    
cylinder(h = 2, d = 15, $fn=60); 
cylinder(h = 2, d = 5, $fn=60); 
}
}
