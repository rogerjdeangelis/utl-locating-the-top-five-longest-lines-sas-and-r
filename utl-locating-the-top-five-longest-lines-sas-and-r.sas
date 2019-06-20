Locating the top five longest lines sas and r                                                       
                                                                                                    
  1. Two solutions                                                                                  
                                                                                                    
         1, R if you need to do something with the long lines                                       
         2, SAs if you are only interested in the lengths                                           
                                                                                                    
Probably better to use python or perl.                                                              
                                                                                                    
If you have IML you don't need my interface.                                                        
                                                                                                    
github                                                                                              
https://tinyurl.com/y36zxvfw                                                                        
https://github.com/rogerjdeangelis/utl-locating-the-top-five-longest-lines-sas-and-r                
                                                                                                    
SAS-L:                                                                                              
https://listserv.uga.edu/cgi-bin/wa?A2=SAS-L;8ad9467c.1906c                                         
                                                                                                    
*_                   _                                                                              
(_)_ __  _ __  _   _| |_                                                                            
| | '_ \| '_ \| | | | __|                                                                           
| | | | | |_) | |_| | |_                                                                            
|_|_| |_| .__/ \__,_|\__|                                                                           
        |_|                                                                                         
;                                                                                                   
                                                                                                    
d:/txt/have.txt                                                                                     
                                                                                                    
Problem: Fnd the lengths of lines and select the top 5                                              
                                                                                                    
... means there are a lot of As                 Find lengths                                        
                                                                                                    
A...AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA      30,389                                            
A...AAAAAAAAAAAA                                  73,307                                            
A...AAAAAAAAAAAAAAAAAAAAAA                       135,110                                            
A...AAAAAAAAA                                    130,504                                            
A...AAAAAAAAAAAAAAAAAAAAAAA                        7,983                                            
A...AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA          60,823                                            
A...AAAAAAAAAAAAAAAAAAAAA                         44,355                                            
A...AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA                27,902                                            
A...AAAAA                                         46,998                                            
A...AAAAAAAAAAAA                                 131,422                                            
A...AAAAAAAAAAAAAAAAA                            129,650                                            
A...AAAAAAAAAAA                                   28,300                                            
A...AAAAAAAAAAAAAAAAAA                             7,111                                            
A...AAAAAAAAAAAAAAAAAAAAA                         42,502                                            
                                                   3,658                                            
* MAKE THE FILE;                                                                                    
                                                                                                    
filename have "d:/txt/have.txt" lrecl=1 recfm=n;                                                    
data _null_;                                                                                        
  file have;                                                                                        
                                                                                                    
  cr = '0D'x;                                                                                       
  lf = '0A'x;                                                                                       
                                                                                                    
  do rec=1 to 900000;                                                                               
     put "A" @@;                                                                                    
     if uniform(45637) < 1/90000 then do;  put cr @@ +(-1) lf @@; end;                              
  end;                                                                                              
                                                                                                    
  put  cr @@;                                                                                       
  put  lf @@;                                                                                       
                                                                                                    
  stop;                                                                                             
run;quit;                                                                                           
                                                                                                    
*            _               _                                                                      
  ___  _   _| |_ _ __  _   _| |_                                                                    
 / _ \| | | | __| '_ \| | | | __|                                                                   
| (_) | |_| | |_| |_) | |_| | |_                                                                    
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                   
                |_|                                                                                 
;                                                                                                   
                                                                                                    
Up to 40 obs WORK.WANTFIN total obs=5                                                               
                                                                                                    
Obs    LYN    LENGTH                                                                                
                                                                                                    
 1       3    135,110                                                                               
 2      10    131,422                                                                               
 3       4    130,504                                                                               
 4      11    129,650                                                                               
 5       2     73,307                                                                               
                                                                                                    
*                                                                                                   
 _ __  _ __ ___   ___ ___  ___ ___                                                                  
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                 
| |_) | | | (_) | (_|  __/\__ \__ \                                                                 
| .__/|_|  \___/ \___\___||___/___/                                                                 
|_|                                                                                                 
;                                                                                                   
                                                                                                    
*                                                                                                   
 ___  __ _ ___                                                                                      
/ __|/ _` / __|                                                                                     
\__ \ (_| \__ \                                                                                     
|___/\__,_|___/                                                                                     
                                                                                                    
;                                                                                                   
                                                                                                    
filename have "d:/txt/have.txt" lrecl=1000000 recfm=v;                                              
data _null_;                                                                                        
 infile have length=l;                                                                              
 input a $1.;                                                                                       
 length=l;                                                                                          
 lyn=_n_;                                                                                           
 keep length;                                                                                       
run;quit;                                                                                           
                                                                                                    
proc sql;                                                                                           
  reset outobs=5;                                                                                   
  create                                                                                            
      table wantfin as                                                                              
  select                                                                                            
      lyn                                                                                           
     ,v1 as length format=comma12.                                                                  
  from                                                                                              
      want                                                                                          
  order                                                                                             
     by length descending                                                                           
;quit;                                                                                              
                                                                                                    
*____                                                                                               
|  _ \                                                                                              
| |_) |                                                                                             
|  _ <                                                                                              
|_| \_\                                                                                             
                                                                                                    
;                                                                                                   
                                                                                                    
%utl_submit_r64('                                                                                   
    library(data.table);                                                                            
    library(SASxport);                                                                              
    fil <- "d:/txt/have.txt";                                                                       
    lyn=readLines(fil,n=15);                                                                        
    want<-as.data.table(nchar(lyn));                                                                
    write.xport(want,file="d:/xpt/want.xpt");                                                       
');                                                                                                 
                                                                                                    
libname xpt xport "d:/xpt/want.xpt";                                                                
  data want;                                                                                        
    set xpt.want;                                                                                   
    lyn=_n_;                                                                                        
  run;quit;                                                                                         
libname xpt clear;                                                                                  
                                                                                                    
proc sql;                                                                                           
  reset outobs=5;                                                                                   
  create                                                                                            
      table wantfin as                                                                              
  select                                                                                            
      lyn                                                                                           
     ,v1 as length format=comma12.                                                                  
  from                                                                                              
      want                                                                                          
  order                                                                                             
     by v1 descending                                                                               
;quit;                                                                                              
                                                                                                    
                                                                                                    
                                                                                                    
