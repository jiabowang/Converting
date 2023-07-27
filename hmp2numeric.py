import os,sys
inf =open("maize1275_3M.hmp","r")
ouf = open("maize1275_3M.dat","w")
map = open("maize1275_3M.map","w")
#inf =open("test.hapmap.txt","r")
#ouf = open("test.num.txt","w")
#map = open("test.num.map","w")
name=[]
i=0
for line in inf:
        i = i+ 1
        if line.startswith("rs"):
            b=line.strip().split()
            bb=b[11:]
            mm=[]
            for m in (0,2,3):
                    mm.append(b[m])
                #ouf.write("%s\n"%("\t".join(bb)))
            map.write("%s\n"%("\t".join(mm)))
            l = len(bb)
            print l
        else:
            b=line.strip().split()
            bb=b[11:]
            mm=[]
            for m in (0,2,3):
                    mm.append(b[m])
                #ouf.write("%s\n"%("\t".join(bb)))
            map.write("%s\n"%("\t".join(mm)))
            j = 0
            cc=[]
            ref = b[1]
            TT = ref.split("/")
          
            for j in range(0,l):
                        H0 = TT[0]+TT[0]
                        H1 = TT[0]+TT[1]
                        H11 = TT[1]+TT[0]
                        H2 = TT[1]+TT[1]
                        #print bb[j]
                        if bb[j]== H0:
                            a = 0
                            a= str(a)
                        elif bb[j] ==H1:
                            a = 1
                            a= str(a)
                        elif bb[j] == H11:
                            a = 1
                            a= str(a)
                        elif bb[j] == H2:
                            a= 2
                            a= str(a)
                        else:
                            a = "NA"
                            a= str(a)
                        cc.append(a)
            ouf.write("%s\n"%("\t".join(cc)))
            print i

inf.close()
ouf.close()
map.close()
          
