#add perl module for datamatrix
#https://github.com/mstratman/Barcode-DataMatrix

#probably best to install perl module from within R so it goes in the right version of perl

#system("cpanm Barcode::DataMatrix")

code<-"109"

perlcommand<-paste("/usr/local/bin/perl Barcoder.pl ",code," > x.txt",sep="")
system(perlcommand)
addring=TRUE
a<-read.csv("x.txt",header=F,colClasses = c("character"))
a<-as.data.frame(strsplit(as.character(a$V1),split = ""))

dm.block.size=1
qrsize<-(dim(a)[1]*dm.block.size)+dm.block.size
platethickness<-6
barcodethickness<-1
addholes=TRUE


#Print the barcode
{
  scadline<-paste("use <write.scad>")
  write.table(scadline,file = paste(code,"_pos.scad",sep=""),append = F,quote = F,row.names = F,col.names = F)
  scadline<-paste("difference(){")
  write.table(scadline,file = paste(code,"_pos.scad",sep=""),append = T,quote = F,row.names = F,col.names = F)

  scadline<-paste("rotate([0,0,0])translate([0,0,0]){",sep="")
  write.table(scadline,file = paste(code,"_pos.scad",sep=""),append = T,quote = F,row.names = F,col.names = F)

  scadline<-paste("union(){",sep="")
  write.table(scadline,file = paste(code,"_pos.scad",sep=""),append = T,quote = F,row.names = F,col.names = F)

  scadline<-paste("rotate([180,0,90])translate([1,3,",(0.5*platethickness)-barcodethickness,'])write("',code,'",h=5,t=1,center=false);',sep="")
  write.table(scadline,file = paste(code,"_pos.scad",sep=""),append = T,quote = F,row.names = F,col.names = F)



}
for (i in 1:nrow(a))

{

  for (j in 1:ncol(a))
  {
    if (a[i,j]==1)
      scadline<-paste("translate([",j*dm.block.size,",",i*dm.block.size,",",0.5*(platethickness-barcodethickness),"])  cube(size = [",dm.block.size,",",dm.block.size,",",barcodethickness,"], center=true);",sep = "")
    write.table(scadline,paste(code,"_pos.scad",sep=""),append = T,quote = F,row.names = F,col.names = F)

  }
}
scadline<-paste("}",sep="")
write.table(scadline,file = paste(code,"_pos.scad",sep=""),append = T,quote = F,row.names = F,col.names = F)
write.table(scadline,file = paste(code,"_pos.scad",sep=""),append = T,quote = F,row.names = F,col.names = F)



scadline<-paste("}",sep="")
write.table(scadline,file = paste(code,"_pos.scad",sep=""),append = T,quote = F,row.names = F,col.names = F)



#write circle with holes for barcode
scadline<-paste("use <write.scad>")
write.table(scadline,file = paste(code,".scad",sep=""),append = F,quote = F,row.names = F,col.names = F)
scadline<-paste("rotate([0,0,0])difference(){translate([",qrsize/2,",",qrsize/2,",0])  cylinder(r=",qrsize/1.3,",h=",platethickness,",$fn=60, center=true);",sep="")
write.table(scadline,file = paste(code,".scad",sep=""),append = T,quote = F,row.names = F,col.names = F)

scadline<-paste("rotate([180,0,90])translate([1,3,",(0.5*platethickness)-barcodethickness,'])write("',code,'",h=5,t=1,center=false);',sep="")
write.table(scadline,file = paste(code,".scad",sep=""),append = T,quote = F,row.names = F,col.names = F)


if(addholes==TRUE){
  #add holes to bead
  scadline<-paste("rotate([90,90,0])translate([",0,",",qrsize/2,",",platethickness,"])  cylinder(r=1.5,h=400, $fn=60, center=true);",sep = "")
  write.table(scadline,paste(code,".scad",sep=""),append = T,quote = F,row.names = F,col.names = F)


  for (i in 1:nrow(a))

  {

    for (j in 1:ncol(a))
    {
      if (a[i,j]==1)
        scadline<-paste("translate([",j*dm.block.size,",",i*dm.block.size,",",platethickness-barcodethickness,"])  cube(size = [",dm.block.size,",",dm.block.size,",",platethickness,"], center=true);",sep = "")
      write.table(scadline,paste(code,".scad",sep=""),append = T,quote = F,row.names = F,col.names = F)

    }
  }

  scadline<-paste("}",sep="")
  write.table(scadline,file = paste(code,".scad",sep=""),append = T,quote = F,row.names = F,col.names = F)


}




