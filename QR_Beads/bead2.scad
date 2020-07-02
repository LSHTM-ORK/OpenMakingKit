rotate([180,0,0])difference(){
cylinder(r=3,h=10,$fn=60, center=false);
cylinder(r=1.5,h=400, $fn=60, center = false);
translate([0,0,0])cylinder(r=3,h=1,$fn=60, center=false);
translate([0,0,2])cylinder(r=3,h=1,$fn=60, center=false);
translate([0,0,4])cylinder(r=3,h=1,$fn=60, center=false);
translate([0,0,6])cylinder(r=3,h=1,$fn=60, center=false);
translate([0,0,8])cylinder(r=3,h=1,$fn=60, center=false);
}

