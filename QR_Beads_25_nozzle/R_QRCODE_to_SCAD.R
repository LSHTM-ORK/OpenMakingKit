#add
code<-"123122"

library(qrcode)
a<-qrcode::qrcode_gen(code,dataOutput = T,ErrorCorrectionLevel = "L",mask = 7,softLimitFlag = T)
qrsize<-dim(a)[1]+1


scadline<-paste("difference(){translate([",qrsize/2,",",qrsize/2,",0])  cube(size=[",qrsize+1,",",qrsize+1,",0.9], center=true);",sep="")
write.table(scadline,file = paste(code,".scad",sep=""),append = F,quote = F,row.names = F,col.names = F)

for (i in 1:nrow(a))

{

    for (j in 1:ncol(a))
    {
      if (a[i,j]==1)
      scadline<-paste("translate([",i,",",j,",0])  cube(size = [1,1,1], center = true);",sep = "")
      write.table(scadline,paste(code,".scad",sep=""),append = T,quote = F,row.names = F,col.names = F)
      write.table(scadline,paste(code,"_pos.scad",sep=""),append = T,quote = F,row.names = F,col.names = F)

    }

 # system("OpenSCAD ")




}

write.table("}",paste(code,".scad",sep=""),append = T,quote = F,row.names = F,col.names = F)

