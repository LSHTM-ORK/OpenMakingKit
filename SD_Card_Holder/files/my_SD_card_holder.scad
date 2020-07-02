translate([0,56,0])tray();
translate([0,28,0])tray();
translate([0,0,0])tray();


module tray()
{//Tell me how many cards you have:

/* [Slot Count] */
//The number of SD cards to accomodate
slotCount=15;

/* [Hidden] */
height=20;

shrinkFactor=1.01;
buffer=2*shrinkFactor;
cardWidth=25*shrinkFactor;
cardThickness=2.5*shrinkFactor;
length=slotCount*(cardThickness+buffer)+buffer;
width=cardWidth+buffer*2;

echo("holder is ",length,"x",width);

difference()
  {
  cube([length,width,height]);

  for (i=[0:slotCount-1])
    card(i);
    
  translate([-1,width/2,height/2])
    rotate([0,90,0])
      cylinder(d=height*0.9,h=length+2,$fs=.5,$fa=5);
  }
 module card(position)
  {
  translate([buffer+position*(cardThickness+buffer),width/2-cardWidth/2,1])
    cube([cardThickness,cardWidth,height+1]);
  }
  }
  
  
  
  
  
  
  

