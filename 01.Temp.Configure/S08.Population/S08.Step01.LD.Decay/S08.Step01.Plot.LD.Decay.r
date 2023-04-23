# ============================================= plot.mulgroups.r

# open pdf and png:
pdf("LD.Decay.pdf")
a<-dev.cur()     # 记录pdf设备
png("LD.Decay.png")
dev.control("enable")

# Group_List=(DJK CH XKH QDH MH LZH);

# 绘图:
read.table("DJK.bin.gz")->Echr1;
plot(Echr1[,1]/1000,Echr1[,2],type="l",col="red",main="LD Decay",xlab="Distance(Kb)",xlim=c(0,100),ylim=c(0,0.5),ylab=expression(r^{2}),bty="n",lwd=2)

read.table("CH.bin.gz")->Echr2;
lines(Echr2[,1]/1000,Echr2[,2],col="black",lwd=2)

read.table("XKH.bin.gz")->Echr3;
lines(Echr3[,1]/1000,Echr3[,2],col="blue",lwd=2)

read.table("QDH.bin.gz")->Echr4;
lines(Echr4[,1]/1000,Echr4[,2],col="gray",lwd=2)

read.table("MH.bin.gz")->Echr5;
lines(Echr5[,1]/1000,Echr5[,2],col="brown",lwd=2)

read.table("LZH.bin.gz")->Echr6;
lines(Echr6[,1]/1000,Echr6[,2],col="orange",lwd=2)

legend("topright", c("DJK","CH","XKH","QDH","MH","LZH"),col=c("red","black","blue", "gray", "brown", "orange"),cex=1,lty=c(1,1,1), bty="n",lwd=2);


# close pdf and png:
dev.copy(which=a)    # 复制来自png设备的图片到pdf
dev.off()
dev.off()


# ============================================= plot.mulgroups.r

