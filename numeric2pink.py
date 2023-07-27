import os,sys
import numpy as np

inf_data=open("newdata.dat","r")
#inf_map=open("myData.map","r")
out=open("plink.ped","w")
i=1

# **1
for line in inf_data:
        a=line.strip().split()
        orignal=[1,i,1,1,1,1]
        for index, item in enumerate(a):
            a[index] = int(item)
        array_a=np.array(a)
        print(orignal)
        c=list(array_a)
        duplicate=orignal+c
        dd=[]
        for j in range(0,len(duplicate)):
            dd.append(str(duplicate[j]))
        print i
        i=i+1
        out.write("%s\n"%(" ".join(dd)))

inf_data.close()
out.close()



