
box = 1;
lid = 1;
usbstopper = 1;
buttons1 = 1;
buttons2 = 1;

if(box==1)
{
//main box
difference()
{
//main shell   
union(){    
cube([32,30.5,20],center=false);
translate([-1.5,0,0])cube([3.5,30.5,20],center=false);
translate([31,0,0])cube([3.5,30.5,20],center=false);
translate([-1.5,30,0])cube([36,57,20],center=false);

}

//internal space
translate([2.5,2,2])cube([27,26.5,24],center=false);
//window for screen
translate([3.5,3.5,0])cube([25,17,26],center=false);
// SD card slot
translate([10,24,8])cube([12,12,13],center=false);
// USB slot
translate([4,-3,3])cube([12,8,7],center=false);
//buttonhole(lower)
translate([-2,7,6])rotate([0,90,0]) cylinder(h=40,r=3,$fn=60);
//buttonhole(upper)
translate([-2,14,6])rotate([0,90,0]) cylinder(h=40,r=3,$fn=60);
//switch access
translate([-2,20.5,5])cube([8,6,2],center=false);
//buttoninners
translate([1,2,2])cube([2,17,8],center=false);
translate([29,2,2])cube([2,17,8],center=false);
//sdcard extra space
//translate([8,26,2])cube([16,3,25],center=false);
//somewhere for battery
translate([0.5,32,2])cube([32,52,20],center=false);

//leave somewhere for wires
translate([2.5,22,18])cube([26,20,20],center=false);
}
}


if(buttons1==1)
{
//buttons1
//rotate([0,90,180])translate([-1.5,-21,-2])color("blue")
{
translate([-18,2.5,0])cube([7,16,0.5],center=false);
translate([-14.5,7,0])cylinder(h=8,r=2.5,$fn=60);
translate([-14.5,14,0])cylinder(h=8,r=2.5,$fn=60);
}
}

if(buttons2==1)
{    
//buttons2
translate([-8,0,0])
{
translate([-18,2.5,0])cube([7,16,0.5],center=false);
translate([-14.5,7,0])cylinder(h=8,r=2.5,$fn=60);
translate([-14.5,14,0])cylinder(h=8,r=2.5,$fn=60);
}
}


if(lid==1)
{
//lid
translate([37,0,0])cube([36,87,2],center=false);

}

if (usbstopper==1)
{
// USB plug
translate([0,0,9])rotate([90,0,0])
{
difference()
{
union(){
translate([4,-8,3])cube([11.7,2.5,6.7],center=false);
translate([3,-9,2])cube([13.5,1,8.5],center=false);
}
translate([5,-7,4])cube([9.5,5,4.5],center=false);
}
}
}