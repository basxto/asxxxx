	asxv1p75.zip	ASxxxx and ASlink V1.75 Zipped

		MS-DOS:	        pkunzip -d asxv1p75.zip
				unzips and restores directory structure

		Linux:		unzip -L -a asxv1p75.zip
				unzips to lower-case names and converts ascii
				files to \n from \r\n form.


	Build command files are in directories:
		Decus:		\asxxxx\asxmak\Decus\build\


	Documentation in plain text form is
	 	\asxxxx\asxdoc\asmlnk.doc

        Documentation in HTML form may be found starting with
 		\asxxxx\asxhtml\asxdoc.htm




        ASxxxx Cross Assemblers, Version 1.75, October 1996 

        Submitted by Alan R.  Baldwin, 
        Kent State University, Kent, Ohio 

        Operating System:  TSX+, RT-11, MS/DOS, PDOS 
        or other supporting K&R C.  

        Source Langauge:  C 

        Abstract:  

           The  ASxxxx  assemblers are a series of microprocessor assem-
        blers written in the C programming  language.   This  collection
        contains cross assemblers for the 6800(6802/6808), 6801(hd6303),
        6804, 6805, 68HC08, 6809,  68HC11,  68HC12  68HC16,  8085(8080),
        z80(hd64180), H8/3xx, and 6500 series microprocessors.  Each as-
        sembler has a  device  specific  section  which  includes:   (1)
        device  description, byte order, and file extension information,
        (2) a table of assembler general directives, special directives,
        assembler  mnemonics and associated operation codes, (3) machine
        specific code for processing the  device  mnemonics,  addressing
        modes, and special directives.  

           The assemblers have a common device independent section which
        handles the details of file input/output, symbol  table  genera-
        tion,  program/data  areas,  expression  analysis, and assembler
        directive processing.  

           The  assemblers  provide  the following features:  (1) alpha-
        betized, formatted symbol table listings, (2) relocatable object
        modules, (3) global symbols for linking object modules, (4) con-
        ditional assembly directives, (5) reusable  local  symbols,  and
        (6) include-file processing.  

           The  companion program ASLINK is a relocating linker perform-
        ing the following functions:  (1) bind multiple  object  modules
        into  a  single  memory  image,  (2) resolve inter-module symbol
        references,  (3)  resolve  undefined  symbols   from   specified
        librarys of object modules, (4) process absolute, relative, con-
        catenated, and overlay attributes in data and program  sections,
        (5)  perform  byte and word program-counter relative (pc or pcr)
        addressing calculations, (6) define absolute  symbol  values  at
        link  time, (7) define absolute area base address values at link
        time, (8) produce Intel Hex or Motorola  S19  output  file,  (9)
        produce  a  map  of the linked memory image, and (10) update the
        ASxxxx assembler listing files  with  the  absolute  linked  ad-
        dresses and data.  

           The  assemblers  and  linker  have  been tested using DECUS C
        under TSX+ and RT-11, PDOS C V5.4b, and Symantec C/C++ V6.1/V7.2
        under  DOS/Windows  3.x/95.  Complete source code and documenta-
        tion for the assemblers and linker is included with the  distri-
        bution.   Additionally, test code for each assembler and several
        microprocessor monitors ( ASSIST05  for  the  6805,  MONDEB  and
        ASSIST09  for  the  6809,  and BUFFALO 2.5 for the 6811) are in-
        cluded as working examples of use of these assemblers.  
