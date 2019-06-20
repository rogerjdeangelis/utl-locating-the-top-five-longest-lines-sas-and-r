# utl-locating-the-top-five-longest-lines-sas-and-r
    Locating the top five longest lines sas and r                                                              
                                                                                                               
      1. Two solutions                                                                                         
                                                                                                               
             1. R if you need to do something with the long lines                                              
             2. SAS if you are only interested in the lengths                                                  
             3. See enhanced algorithm on end of this message                                                  
                                                                                                               
    See enhanced algorithm on end of this message.                                                             
                                                                                                               
    by                                                                                                         
    Bartosz Jablonski                                                                                          
    yabwon@gmail.com                                                                                           
                                                                                                               
    Enhancements (more robust)                                                                                 
                                                                                                               
     1. file options                                                                                           
         LINE=N   /* line number */                                                                            
         recfm=v                                                                                               
         dsd      /* for empty lines */                                                                        
         end=eof ;                                                                                             
                                                                                                               
     2. Elimination of second step (proc sql)                                                                  
                                                                                                               
     3. Innovative HASH to sort and output top 5                                                               
                                                                                                               
     4. HASH eliminates the need of an an over specified datastep array?                                       
                                                                                                               
                                                                                                               
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
                                                                                                               
                                                                                                               
                                                                                                               
    *____             _                                                                                        
    | __ )  __ _ _ __| |_                                                                                      
    |  _ \ / _` | '__| __|                                                                                     
    | |_) | (_| | |  | |_                                                                                      
    |____/ \__,_|_|   \__|                                                                                     
                                                                                                               
    ;                                                                                                          
                                                                                                               
    Hi Roger,                                                                                                  
                                                                                                               
    I think you can do it in the data step                                                                     
    that reads-in the records (see the code below,                                                             
    it also handles ties in lengths).                                                                          
                                                                                                               
    But there is one more thing bugging me.                                                                    
    When I took your code which generates data and I                                                           
    played with it to get some additional blank lines (i.e. containing only 0d0a)                              
    I found this strange behaviour that SAS is                                                                 
    always adding one single space at the end of the file.                                                     
                                                                                                               
    Look at the result of this:                                                                                
    /*                                                                                                         
    filename have "%sysfunc(getoption(work))/TEMP.txt" lrecl=1 recfm=n;                                        
    data _null_;                                                                                               
      file have;                                                                                               
                                                                                                               
      cr = '0D'x;                                                                                              
      lf = '0A'x;                                                                                              
                                                                                                               
      put       cr +(-1) lf @@;                                                                                
      put +(-1) cr +(-1) lf @@;                                                                                
                                                                                                               
    stop;                                                                                                      
    run;                                                                                                       
    */                                                                                                         
                                                                                                               
    after running it I expect to have 4 bytes in the "have" file but                                           
    I have 5: 0D0A0D0A32 and I can't                                                                           
    figure out where this additional space(32) come from??                                                     
                                                                                                               
    All the best                                                                                               
    Bart                                                                                                       
                                                                                                               
    /* data */                                                                                                 
    filename have TEMP lrecl=1 recfm=n;                                                                        
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
                                                                                                               
    /* the code */                                                                                             
    data _null_;                                                                                               
     infile have                                                                                               
            LENGTH=L /* record length */                                                                       
            LINE=N   /* line number */                                                                         
            lrecl=1000000                                                                                      
            recfm=v                                                                                            
            dsd      /* for empty lines */                                                                     
            end=eof ;                                                                                          
                                                                                                               
     length length line n l 8;                                                                                 
     call missing(length,line);                                                                                
     /* this one keeps track of data */                                                                        
     declare hash H(ordered:"d", multidata:"y"); /* order descending by length */                              
     H.defineKey("length");                                                                                    
     H.defineData("length","line");                                                                            
     H.defineDone();                                                                                           
     declare hiter IH("H");                                                                                    
                                                                                                               
     /* this one keeps the track of keys(lengths), to have them up to 5 */                                     
     declare hash keyJumper();                                                                                 
     keyJumper.defineKey("length");                                                                            
     keyJumper.defineData("length");                                                                           
     keyJumper.defineDone();                                                                                   
                                                                                                               
     do until(eof);                                                                                            
      length a $ 1; format a quote.;                                                                           
      input a ;                                                                                                
                                                                                                               
      /*put _all_; */                                                                                          
                                                                                                               
      _rc_ = IH.last(); /* get length of the last record */                                                    
      _rc_ = IH.next();                                                                                        
      _NUM_ITEMS_ = keyJumper.NUM_ITEMS;                                                                       
                                                                                                               
        select;                                                                                                
          when (l > length) /* if the new one is longer add but remove only if more than 5 keys(lengths) */    
            do;                                                                                                
              if _NUM_ITEMS_ >= 5 then                                                                         
                do;                                                                                            
                  _rc_ =         H.remove(key:length);                                                         
                  _rc_ = keyJumper.remove(key:length);                                                         
                end;                                                                                           
              _rc_ =         H.add(key:l,data:l,data:N);                                                       
              _rc_ = keyJumper.add(key:l,data:l);                                                              
            end;                                                                                               
          when (l = length) /* if tie just add new line number */                                              
            do;                                                                                                
              _rc_ = H.add(key:l,data:l,data:N);                                                               
            end;                                                                                               
          otherwise ; /* ignore shorter */                                                                     
        end;                                                                                                   
     end;                                                                                                      
                                                                                                               
     /*_rc_ = keyJumper.output(dataset:"keyJumper");*/                                                         
     _rc_ =         H.output(dataset:"want");                                                                  
     stop;                                                                                                     
    run;                                                                                                       
                                                                                                               
    proc print data = want;                                                                                    
    run;                                                                                                       
                                                                                                               
                                                                                                               
                                                                                                               
                                                                              
                                                                                                          
