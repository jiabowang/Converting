#!/usr/bin/perl
use 5.008.8; 
use strict;
use warnings;
# 
# Reads vcf file and output for variscan
# Required parameters :
#         Vcf input file
#         Hapmap output file  name
#         logical value 1 if Ancestral Allele present or  0 if Ancestral Allele not present
#		  this option will add a column with ancestral allele - this is usefull for genetic analysis with ancestral allele  
#			
	my $fichier_in;
	my $dt ; 
	my $isAA;
  if ($#ARGV == -1) {
   print " <Name  of input VCF>    <Name  of output VCF>  conditional value Ancestral Allele field in VCF <0: n oAA field, 1 AA field>  ? "; 
   exit;
  }
else {
   $fichier_in = $ARGV[0];
   $dt = $ARGV[1];
   $isAA = $ARGV[2];
   }

	my $dt_out;
    my (@AoA1, @tmp, $i, $j);
    my $k;
    my @tmp3;
    my $nombreloci;
	my @allele= () ; 
	my $Test = "\.";
	my $ref; #reference allele
	my $alt; #alternative allele
  my @alt0; 
  my $alta; 
  my $altb; 
  my $altc; 
	my $o;
	my $p; 
	my $Chrant; 
	my $coord =0;
	my $AA;
 
    my $nsouche;
#       $fichier_in =  $ARGV[0];
 # charge les donnees
    open (IN,"<$fichier_in")  or die "Impossible to open  file $fichier_in because : $!\n";  
    while (<IN>) { 
        next if m/##/;
        chomp $_;
       @tmp = split(/\t/,$_);
       push @AoA1,[@tmp]; 
    }   
    close IN;

$Chrant = $AoA1[1][0];
$dt_out = $dt.$AoA1[1][0].".txt";
open(OUT,">$dt_out") or die "Erreur de creation de DT format hapmap";
#print of first line 
$Chrant = $AoA1[1][0];
$nsouche = $#{$AoA1[1]}-8;
print "Number of individuals  $nsouche\n";
   			print OUT "rs# SNPalleles $AoA1[0][0] $AoA1[0][1] Strand Genome_build Center ProtLSID assayLSID panelLSID QC_code S288C ";
    	    if($isAA==1){ print OUT "Ancestral "};
    for $j ( 9..$#{$AoA1[0]}) {  print OUT "$AoA1[0][$j] ";}
         print OUT "\n";

    for ($i =1;  $i<=$#AoA1; $i++) 
    { 
 #       Check for  chromosome change , if yes makes a new file 
                if($isAA==1){  $AA = substr($AoA1[$i][7],3,1)} ;   
    if  ($Chrant ne $AoA1[$i][0]) {
        close OUT;
		$dt_out=   $dt.$AoA1[$i][0].".txt"; 

   		open(OUT,">$dt_out") or die "Error creation output DT  $dt_out";
   			print OUT "rs# SNPalleles $AoA1[0][0] $AoA1[0][1] Strand Genome_build Center ProtLSID assayLSID panelLSID QC_code S288C ";
    	    if($isAA==1){ print OUT "Ancestral "};
    		for $j (9..$#{$AoA1[0]}) {  print OUT "$AoA1[0][$j] ";}
         		print OUT "\n";
        		 $Chrant = $AoA1[$i][0];
    }

         $ref =$AoA1[$i][3];
         $alt = $AoA1[$i][4];
         @alt0 = split /,/, $alt;
         $alta = $alt0[0];
         $altb = $alt0[1];
         $altc = $alt0[2];
 
			if($isAA==1){ 
 					if(($ref ne $AA)&&($alt ne $AA)) {print "Error at position : chromosome  $AoA1[$i][0]  position $AoA1[$i][1]  : ref $ref  Ancestral $AA  ancestral allele does not correspond to reference or alternative allele\n"};
 			};

			print OUT "rs$i $ref\/$alt $AoA1[$i][0] $AoA1[$i][1] $AoA1[$i][5] $AoA1[$i][6] unknown urn\:unknown urn\:unknown urn\:unknown QC+ $ref$ref ";
			 if($isAA==1){print OUT "$AA$AA "};          
					for $k (9..$#{$AoA1[$i]})   {  
						if  (substr($AoA1[$i][$k],0,3) =~ /\.\/\./) { print OUT "NN ";  
						} elsif ((substr($AoA1[$i][$k],0,3) =~ /0\|0/)||(substr($AoA1[$i][$k],0,3) =~ /0\/0/))  { print OUT "$ref$ref ";
						} elsif ((substr($AoA1[$i][$k],0,3) =~ /0\|\./)||(substr($AoA1[$i][$k],0,3) =~ /0\/\./)) { print OUT $ref."N ";
						} elsif ((substr($AoA1[$i][$k],0,3) =~ /\.\|0/)||(substr($AoA1[$i][$k],0,3) =~ /\.\/0/)) { print OUT "N"."$ref ";
						} elsif ((substr($AoA1[$i][$k],0,3) =~ /0\|1/)||(substr($AoA1[$i][$k],0,3) =~ /0\/1/)) { print OUT "$ref$alta ";
						} elsif ((substr($AoA1[$i][$k],0,3) =~ /1\|0/)||(substr($AoA1[$i][$k],0,3) =~ /1\/0/)) { print OUT "$alta$ref ";
						} elsif ((substr($AoA1[$i][$k],0,3) =~ /1\|1/)||(substr($AoA1[$i][$k],0,3) =~ /1\/1/)){ print OUT "$alta$alta "; 
						} elsif ((substr($AoA1[$i][$k],0,3) =~ /\.\|1/)||(substr($AoA1[$i][$k],0,3) =~ /\.\/1/)) { print OUT "N"."$alta "; 
						} elsif ((substr($AoA1[$i][$k],0,3) =~ /1\|\./)||(substr($AoA1[$i][$k],0,3) =~ /1\/\./)) { print OUT $alta."N "; 
            } elsif ((substr($AoA1[$i][$k],0,3) =~ /2\|0/)||(substr($AoA1[$i][$k],0,3) =~ /2\/0/)) { print OUT "$altb$ref "; 
            } elsif ((substr($AoA1[$i][$k],0,3) =~ /0\|2/)||(substr($AoA1[$i][$k],0,3) =~ /0\/2/)) { print OUT "$ref$altb "; 
            } elsif ((substr($AoA1[$i][$k],0,3) =~ /2\|\./)||(substr($AoA1[$i][$k],0,3) =~ /2\/\./)) { print OUT $altb."N "; 
            } elsif ((substr($AoA1[$i][$k],0,3) =~ /\.\|2/)||(substr($AoA1[$i][$k],0,3) =~ /\.\/2/)) { print OUT "N"."$altb "; 
            } elsif ((substr($AoA1[$i][$k],0,3) =~ /2\|2/)||(substr($AoA1[$i][$k],0,3) =~ /2\/2/)) { print OUT "$altb$altb "; 
            } elsif ((substr($AoA1[$i][$k],0,3) =~ /2\|1/)||(substr($AoA1[$i][$k],0,3) =~ /2\/1/)) { print OUT "$altb$alta "; 
            } elsif ((substr($AoA1[$i][$k],0,3) =~ /1\|2/)||(substr($AoA1[$i][$k],0,3) =~ /1\/2/)) { print OUT "$alta$altb "; 
            } elsif ((substr($AoA1[$i][$k],0,3) =~ /3\|3/)||(substr($AoA1[$i][$k],0,3) =~ /3\/3/)) { print OUT "$altc$altc "; 
            } elsif ((substr($AoA1[$i][$k],0,3) =~ /3\|\./)||(substr($AoA1[$i][$k],0,3) =~ /3\/\./)) { print OUT $altc."N "; 
            } elsif ((substr($AoA1[$i][$k],0,3) =~ /\.\|3/)||(substr($AoA1[$i][$k],0,3) =~ /\.\/3/)) { print OUT "N"."$altc "; 
            } elsif ((substr($AoA1[$i][$k],0,3) =~ /3\|0/)||(substr($AoA1[$i][$k],0,3) =~ /3\/0/)) { print OUT "$altc$ref "; 
            } elsif ((substr($AoA1[$i][$k],0,3) =~ /0\|3/)||(substr($AoA1[$i][$k],0,3) =~ /0\/3/)) { print OUT "$ref$altc "; 
            } elsif ((substr($AoA1[$i][$k],0,3) =~ /3\|1/)||(substr($AoA1[$i][$k],0,3) =~ /3\/1/)) { print OUT "$altc$alta "; 
            } elsif ((substr($AoA1[$i][$k],0,3) =~ /1\|3/)||(substr($AoA1[$i][$k],0,3) =~ /1\/3/)) { print OUT "$alta$altc "; 
            } elsif ((substr($AoA1[$i][$k],0,3) =~ /3\|2/)||(substr($AoA1[$i][$k],0,3) =~ /3\/2/)) { print OUT "$altc$altb"; 
            } elsif ((substr($AoA1[$i][$k],0,3) =~ /2\|3/)||(substr($AoA1[$i][$k],0,3) =~ /2\/3/)) { print OUT "$altb$altc "; } 
					}
					print OUT "\n";
} 
	 
#} 
        
     close OUT; 
     print  "That's all!\n";	         
exit;
