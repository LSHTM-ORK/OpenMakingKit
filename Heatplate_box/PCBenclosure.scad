  difference()
 { 
translate([-67,0,0])cube([67,47,19]);
//PCB layer
translate([-51,4,2])cube([49,41,17]);
//power jack space
translate([-65,19,2])cube([16,26,17]);
//power jack hole in wall
translate([-62,25,3])cube([13,26,13]);
//screen
translate([-38.5,33.6,0])cube([23,10,17]);
//button 1
translate([-39,25.5,0])cylinder(r=2,h=2,$fn=30);
translate([-27.5,25.5,0])cylinder(r=2,h=2,$fn=30);
translate([-17.44,25.5,0])cylinder(r=2,h=2,$fn=30);     
//relay
translate([-23,4,0])cube([13,16.3,17]);
//connector for power wires
translate([-43,4,2])cube([21.5,8.5,17]);
//connector for thermal probe
translate([-43,4,2])cube([21.5,8.5,17]);

//runnel for wires 
translate([-59,1,2])cube([57,6,17]);
//runnel for wires 
translate([-61,1,2])cube([5,25,17]);
//runnel for wires 
translate([-10,0,12])cube([5,25,5]);
//runnel for wire2s
//translate([6.5,2,3])cube([7,26,13]);
// screen
//translate([28,2,3])cube([7,26,13])
 } 
   
    
    
  