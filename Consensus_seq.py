#!/usr/bin/env python
#Python program that runs through the files in 'YeastGenes' folder and searches for the consensus sequence of MA0279.1(CAD1).
#MA0279.1(CAD1) is a basic leucine zipper factor

import fileinput
import os
import os.path
from os import path
import re

#Reads in seqeunces as elements in list
# header holds the filename in position corresponding to position in sequence
header = list()
sequence = list()

# main program
def main():

    tot_file = 0
    path_foldername = "C:\\Users\\Connor Lynch\\OneDrive\\Desktop\\Coding\\YeastGenes"
    foldername = 'YeastGenes'
    for filename in os.listdir(foldername):
        #print(filename)
        tot_file += 1
        temp = ""
        my_path = path.join(path_foldername, filename)
        for line in fileinput.input(files = (my_path)):
            temp += line
        filename = filename[:-4]
        header.append(filename)
        sequence.append(temp)
    for i in range(len(sequence)):
        TF_seq(sequence[i],i)

#Searches for the consensus sequence
def TF_seq(seq, pos):
    motif = "[ACG][TA]T[ATC][GAC]T[AC]A[GT][CT]"
    x = re.findall(motif, seq)
    if(x == []):
        print(header[pos], "does not contain the MA0279.1(CAD1) consensus sequence.")
    else:
        print(header[pos], "contains the MA0279.1(CAD1) consensus sequence.")


if __name__ == "__main__":
    main()
    #end script
    print ("\nend Consensus_seq.py")
    exit