#add perl module for datamatrix
#https://github.com/mstratman/Barcode-DataMatrix

#probably best to install perl module from within R so it goes in the right version of perl

#system("cpanm Barcode::DataMatrix")

code<-"It is_Easy_When_You_Know_How"

perlcommand<-paste("/usr/local/bin/perl Barcoder.pl ",code," > x.txt",sep="")
system(perlcommand)

a<-read.csv("x.txt",header=F,colClasses = c("character"))
a<-as.data.frame(strsplit(as.character(a$V1),split = ""))

dm.block.size=1.5
qrsize<-(dim(a)[1]*dm.block.size)+dm.block.size
platethickness<-1.5

scadline<-paste("rotate([180,0,0])difference(){translate([",qrsize/2,",",qrsize/2,",0])  cube(size=[",qrsize+(2*dm.block.size),",",qrsize+(2*dm.block.size),",",platethickness,"], center=true);",sep="")
write.table(scadline,file = paste(code,".scad",sep=""),append = F,quote = F,row.names = F,col.names = F)
scadline<-paste("rotate([180,0,0]){",sep="")
write.table(scadline,file = paste(code,"_pos.scad",sep=""),append = F,quote = F,row.names = F,col.names = F)




for (i in 1:nrow(a))

{

  for (j in 1:ncol(a))
  {
    if (a[i,j]==1)
    scadline<-paste("translate([",j*dm.block.size,",",i*dm.block.size,",0])  cube(size = [",dm.block.size,",",dm.block.size,",",platethickness,"], center = true);",sep = "")
    write.table(scadline,paste(code,".scad",sep=""),append = T,quote = F,row.names = F,col.names = F)
    write.table(scadline,paste(code,"_pos.scad",sep=""),append = T,quote = F,row.names = F,col.names = F)

  }

  # system("OpenSCAD ")




}

write.table("}",paste(code,".scad",sep=""),append = T,quote = F,row.names = F,col.names = F)
write.table("}",paste(code,"_pos.scad",sep=""),append = T,quote = F,row.names = F,col.names = F)

