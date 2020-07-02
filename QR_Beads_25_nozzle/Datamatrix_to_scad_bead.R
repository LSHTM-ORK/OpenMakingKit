#add perl module for datamatrix
#https://github.com/mstratman/Barcode-DataMatrix

#probably best to install perl module from within R so it goes in the right version of perl

#system("cpanm Barcode::DataMatrix")

code<-"001"

perlcommand<-paste("/usr/local/bin/perl Barcoder.pl ",code," > x.txt",sep="")
system(perlcommand)

a<-read.csv("x.txt",header=F,colClasses = c("character"))
a<-as.data.frame(strsplit(as.character(a$V1),split = ""))

dm.block.size=0.5
qrsize<-(dim(a)[1]*dm.block.size)+dm.block.size
platethickness<-1
extrabead=0

#write initial circle
scadline<-paste("rotate([180,0,0])difference(){translate([",qrsize/2,",",qrsize/2,",-",(platethickness+extrabead)/2,"])  cylinder(r=",qrsize/1.3,",h=",(platethickness+3),", center=true);",sep="")
write.table(scadline,file = paste(code,".scad",sep=""),append = F,quote = F,row.names = F,col.names = F)
scadline<-paste("rotate([180,0,0])translate([0,0,-",platethickness/2,"]){",sep="")
write.table(scadline,file = paste(code,"_pos.scad",sep=""),append = F,quote = F,row.names = F,col.names = F)




for (i in 1:nrow(a))

{

  for (j in 1:ncol(a))
  {
    if (a[i,j]==1)
    scadline<-paste("translate([",j*dm.block.size,",",i*dm.block.size,",0])  cube(size = [",dm.block.size,",",dm.block.size,",",platethickness,"], center=true);",sep = "")
    write.table(scadline,paste(code,".scad",sep=""),append = T,quote = F,row.names = F,col.names = F)
    write.table(scadline,paste(code,"_pos.scad",sep=""),append = T,quote = F,row.names = F,col.names = F)

  }

  # system("OpenSCAD ")




}

#add holes to bead
#scadline<-paste("rotate([90,90,0])translate([",(platethickness+3)/2,",",qrsize/4,",0])  cylinder(r=1.5,h=400, $fn=60, center=true);",sep = "")
#write.table(scadline,paste(code,".scad",sep=""),append = T,quote = F,row.names = F,col.names = F)
#scadline<-paste("rotate([90,90,0])translate([",(platethickness+3)/2,",",3*(qrsize/4),",0])  cylinder(r=1.5,h=400, $fn=60, center=true);",sep = "")
#write.table(scadline,paste(code,".scad",sep=""),append = T,quote = F,row.names = F,col.names = F)

#close loop
write.table("}",paste(code,".scad",sep=""),append = T,quote = F,row.names = F,col.names = F)
write.table("}",paste(code,"_pos.scad",sep=""),append = T,quote = F,row.names = F,col.names = F)

#add ring around edge
#scadline<-paste("rotate([180,0,0])difference(){translate([",qrsize/2,",",qrsize/2,",-",(platethickness+3)/2,"])  cylinder(r=",qrsize/1.2,",h=",(platethickness+3),",$fn=60, center=true);",sep="")
#write.table(scadline,paste(code,"_pos.scad",sep=""),append = T,quote = F,row.names = F,col.names = F)
#scadline<-paste("translate([",qrsize/2,",",qrsize/2,",-",(platethickness+3)/2,"])  cylinder(r=",qrsize/1.3,",h=",(platethickness+3),",$fn=60, center=true);",sep="")
#write.table(scadline,paste(code,"_pos.scad",sep=""),append = T,quote = F,row.names = F,col.names = F)
#add holes to bringead
#scadline<-paste("rotate([90,90,0])translate([",(platethickness+3)/2,",",qrsize/4,",0])  cylinder(r=1.5,h=400, $fn=60, center=true);",sep = "")
#write.table(scadline,paste(code,"_pos.scad",sep=""),append = T,quote = F,row.names = F,col.names = F)
#scadline<-paste("rotate([90,90,0])translate([",(platethickness+3)/2,",",3*(qrsize/4),",0])  cylinder(r=1.5,h=400, $fn=60, center=true);}",sep = "")
#write.table(scadline,paste(code,"_pos.scad",sep=""),append = T,quote = F,row.names = F,col.names = F)

