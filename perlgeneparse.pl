
$filecount = 0;
$file_iteration = 0;

#creates a new directory for the output
mkdir 'NewProcessedGenes';

#opens the directory of the Yeast genes, or gives an error message
$dir = "YeastGenesA"; opendir(DIR,$dir) or die "can't open directory $dir:$!"; print"\n";

while ($filename = readdir DIR){ # loop through alignment files
  
  #creates a variable for the name of each open reading frame
  $ORFname = substr($filename, 0, 7);
  print "\nmy ORF name is "."$ORFname\n";
  $filelocation = "./YeastGenesA/"."$filename";#variable for each file within the directory
  if (length $ORFname == 7){
    open(INFILE, $filelocation) or die "Cannot open file";#opens each file
  }else {next;} #skips to the next iteration of the while loop
    open (OUTFILE, ">"."./NewProcessedGenes/"."$filename") || die " could not open output file\n";
 
  while(<INFILE>){
    chomp;#removes last trailing newline
    my $totalCount = 0;
    my $CGCount = 0;
    my $DNA = <INFILE>;
    my $position = 0;
    my $DNAsize = length($DNA);#creates variable for length of DNA sequence
    my $counter = 0;
    while($counter !=  $DNAsize){#goes through each nucleotide of the sequence
      my $base = substr($DNA, $position, 1); 
    
      if($base eq "A" || $base eq "T"  || $base eq "C"  ||  $base eq "G" ){
        
        $totalCount++;
        
      }
      if($base eq "G" || $base eq "C"){#adds to GC count if the base is a C or G
        
        $CGCount++;
        
      }
      $position++;
      $counter++;
    }
    #proline counter
    my $proCount = 0;
    my $pro1;
    for (my $i = 0; $i<$DNAsize; $i += 3){#iterates through the sequence by 3 for each amino acid
        my $base = substr($DNA, $i, 1);
        if($base eq "C"){ 
            $i += 1;
            if($base eq "C"){
                $proCount += 1;#adds to the proline count if the first 2 bases of the amino acid were C's
            }
            $i -= 1;# sets the position back to the first base of the amino acid
        }
        if($proCount eq 1){
            $pro1 = ($i/3);
        }
    }
print "countGC "."$ORFname\t"."$CGCount\n";
print "countTTL "."$ORFname\t"."$totalCount\n";
$freqGC = $CGCount/$totalCount;
print "freqGC "."$ORFname\t"."$freqGC\n";
$AAtotal = $totalCount/3;
print "total AA's "."$AAtotal\n";
print "# of prolines "."$ORFname\t"."$proCount\n";
$freqPro = $proCount/($totalCount/3);
print "freq of prolines "."$ORFname\t"."$freqPro\n";
print "1st proline at residue #"."$pro1\n";

print OUTFILE "countGC "."$ORFname\t"."$CGCount\n";
print OUTFILE "countTTL "."$ORFname\t"."$totalCount\n";
print OUTFILE "freqGC "."$ORFname\t"."$freqGC\n";
print OUTFILE "total AA's "."$AAtotal\n";
print OUTFILE "# of prolines "."$ORFname\t"."$proCount\n";
print OUTFILE "freq of prolines "."$ORFname\t"."$freqPro\n";
print OUTFILE "1st proline at residue #"."$pro1\n";

print "\n\n";
close OUTFILE;
close INFILE;           
  }
} # end while loop
print "end program\n";
exit;
