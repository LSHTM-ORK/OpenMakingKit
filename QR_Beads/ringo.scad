rotate([180,0,0])difference(){
translate([8.25,8.25,-3.25]) cylinder(r=12.5,h=6.5, center=true);
translate([8.25,8.25,-3.25]) cylinder(r=11,h=6.5, center=true);
rotate([90,90,0])translate([3.25,13,0])  cylinder(r=1.5,h=400, $fn=60, center = true);
rotate([90,90,0])translate([3.25,3.25,0])  cylinder(r=1.5,h=400, $fn=60, center = true);
}
