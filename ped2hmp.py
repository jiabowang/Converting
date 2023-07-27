import os,sys
import numpy as np
import itertools

inf=open("newdata.ped","r")
ouf=open("comdata.txt","w")

for line in inf:   #
     #   print len(line)
    #    if line.startswith("taxa")|line.startswith("Taxa"):
        a=line.strip().split()
        orignal=list(a)
        del orignal[0:6]
        #print orignal[0:12]
        n=len(orignal)/2
        dd=[]
        for k in range(len(orignal)/2):
        #for k in range(100):
            bb=orignal[(2*k)]+orignal[(2*k+1)]
            #print bb
            dd.append(bb)
        ouf.write("%s\n"%("\t".join(dd)))

inf.close()
ouf.close()

ouf=open("finaldata.hmp","w")

for marker in range(n):
    print marker
    dd=[]
    inf=open("comdata.ped","r")
    for line in inf:
        a=line.strip().split()
        orignal=list(a)[marker]
        #print orignal
        dd.append(orignal)
    ouf.write("%s\n"%("\t".join(dd)))

inf.close()
ouf.close()








