#!/usr/bin/env python
import os

def main():
   print("running my R script 'R_Geneparse.R'\n") 
   #sleep(1)
   cmd = '.\R_Geneparse.R'
   os.system(cmd)
   print('end script\n')

if __name__ == '__main__':
    main()
