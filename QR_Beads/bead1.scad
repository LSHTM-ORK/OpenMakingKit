rotate([180,0,0])difference(){
cylinder(r=3,h=10,$fn=60, center=false);
cylinder(r=1.5,h=400, $fn=60, center = false);
translate([0,0,1])cylinder(r=3,h=1,$fn=60, center=false);
translate([0,0,3])cylinder(r=3,h=1,$fn=60, center=false);
translate([0,0,5])cylinder(r=3,h=1,$fn=60, center=false);
translate([0,0,7])cylinder(r=3,h=1,$fn=60, center=false);
translate([0,0,9])cylinder(r=3,h=1,$fn=60, center=false);
}

