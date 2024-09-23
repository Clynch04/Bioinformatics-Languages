#!/usr/bin/env python
#Python program that runs through the files in 'YeastGenes' folder and finds the GC content of each sequence and total GC content
# transcribes and finds the %AUGC of the third amino acid in the codon

import fileinput
import os
import os.path
from os import path
import glob
import csv

#Reads in seqeunces as elements in list
# header holds the filename in position corresponding to position in sequence
header = list()
sequence = list()

# main program
def main():

    inputS = input("What DNA sequence are you looking for?\n")
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
    #average = 0
    f = open('geneparse_output.csv', 'w', encoding='UTF8', newline='')
    writer = csv.writer(f)
    csvheader = ["Chromosome", "GC", "total", "Di_repeats", "User_input", "ORF"]
    writer.writerow(csvheader)
    for i in range(len(sequence)):
        #seqInput(sequence[i], inputS)
        #diRepeat(sequence[i])
        #average += gcContent(sequence[i], i)

        data = [header[i][1], gcContent(sequence[i], i), len(sequence[i]), diRepeat(sequence[i]), seqInput(sequence[i],inputS), header[i]]
        writer.writerow(data)
    f.close()
    #average /= tot_file
    #print("\nAverage GC Content is: ", round(average, 1))

#Searches for inputted sequence
def seqInput(seq, inp):
    inp = inp.upper()
    correct = 0
    match = 0
    for i in seq:
        if(correct == len(inp)):
            match += 1
            correct = 0
        if(i == inp[correct]):
            correct += 1
        else:
            correct = 0
    print(inp, "is found", match, "times")
    return match

#Searches for dinucleotide repeats
def diRepeat(seq):
    tempcount = 0
    long = 0
    for i in (range(len(seq))):
        if(seq[i:i+2] == seq[i+2:i+4]):
            tempcount += 1
        if(tempcount > long):
            long = tempcount
        else:
            tempcount = 0
    if(long == 0):
        print("There are no dinucleotide repeats")
    else:
        print("Longest dinucleotide repeat is", long, "iterations")
    return long

#Finds GC content 
def gcContent(seq, pos):
    count = 0
    tot = 0
    final = 0
    for i in seq:
        if((i == "C") or (i == "G")):
            count = count + 1
        if((i == "A") or (i == "T")):
            tot = tot + 1
    tot = tot + count
    if(tot !=0):
        final = (count/tot) * 100
    print("GC content for ", header[pos], "is ", round(final, 1), "\n")
    return final

# transcribed sequence to thirdAd()
def transcribe(seq):
    print("\nTranscribing.. \n")
    seq = seq[::-1]
    for i in range(len(seq)):
        if seq[i] == "A":
            seq = seq[:i] + "U" + seq[i+1:]
        elif seq[i] == "T":
            seq = seq[:i] + "A" + seq[i+1:]
        elif seq[i] == "G":
            seq = seq[:i] + "C" + seq[i+1:]
        elif seq[i] == "C":
            seq = seq[:i] + "G" + seq[i+1:]
    thirdAd(seq)

#Finds ratio of AUGC as third amino acid in codon 
def thirdAd(seq):
    Ccount = 0
    Gcount = 0
    Acount = 0
    Ucount = 0
    tot = 0
    for i in range(0, len(seq), 2):
        if seq[i] == "A":
            Acount += 1
            tot += 1
        elif seq[i] == "U":
            Ucount += 1
            tot += 1
        elif seq[i] == "G":
            Gcount += 1
            tot += 1
        elif seq[i] == "C":
            Ccount += 1
            tot += 1
        i += i
    if(tot != 0):
        print("%A at 3rd base ", round(((Acount/tot)*100), 1))
        print("%U at 3rd base ", round(((Ucount/tot)*100), 1))
        print("%G at 3rd base ", round(((Gcount/tot)*100), 1))
        print("%C at 3rd base ", round(((Ccount/tot)*100), 1))
    else:
        print("ERROR: thirdAd is not working correctly")

if __name__ == "__main__":
    main()
    #end script
    print ("\nend myGeneParser.py")
    exit
