difference()
{
rotate([90,0,0])
union()
{
translate([0,0,0])
difference()
{
cylinder(h=15,d=16.6,$fn=60);
cylinder(h=15,d=13,$fn=60);
}

translate([0,0,15])
difference()
{
cylinder(h=15,r1=8.3,r2=15,$fn=60);
cylinder(h=15,r1=5.5,r2=14,$fn=60);
}
}

translate([-13,-35,-38.4])cube([50,20,30.5]);
}
translate([-13,-30,-8.3])cube([26,15,1]);
