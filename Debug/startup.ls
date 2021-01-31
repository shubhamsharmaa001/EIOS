   1                     ;	C STARTUP FOR STM8
   2                     ;	WITH AUTOMATIC DATA INITIALISATION
   3                     ;	Copyright (c) 2006 by COSMIC Software
   4                     ;
   5                     	xref	_main, __memory, __idesc__, __stack, _EI_stsd_BootMicro, _EI_stsd_Start			
   6                     	xref.b	c_x, c_y, __endzp
   7                     	xdef	_exit, __stext
   8                     ;
   9                     ;	start address of zpage
  10                     ;
  11                     	switch	.ubsct
  12  0000               __suzp:
  13                     ;
  14                     ;	start address of bss
  15                     ;
  16                     	switch	.bss
  17  0000               __sbss:
  18                     ;
  19                     ;	startup routine from reset vector
  20                     ;
  21                     	switch	.text
  22  0000               __stext:
  23                     ;
  24                     ;	initialize stack pointer
  25                     ;
  26  0000 ae0000        	ldw	x,#__stack		; stack pointer
  27  0003 94            	ldw	sp,x			; in place
  28                     ;
  29                     ;	setup initialized data
  30                     ;
  31  0004 90ce0000      	ldw	y,__idesc__		; data start address
  32  0008 ae0002        	ldw	x,#__idesc__+2		; descriptor address
  33  000b               ibcl:
  34  000b f6            	ld	a,(x)			; test flag byte
  35  000c 2725          	jreq	zero			; no more segment
  36  000e a560          	bcp	a,#$60			; test for moveable code segment
  37  0010 2717          	jreq	qbcl			; yes, skip it
  38  0012 bf00          	ldw	c_x,x			; save pointer
  39  0014 ee03          	ldw	x,(3,x)			; move end address
  40  0016 bf00          	ldw	c_y,x			; in memory
  41  0018 be00          	ldw	x,c_x			; reload pointer
  42  001a ee01          	ldw	x,(1,x)			; start address
  43  001c               dbcl:
  44  001c 90f6          	ld	a,(y)			; transfer
  45  001e f7            	ld	(x),a			; byte
  46  001f 5c            	incw	x			; increment
  47  0020 905c          	incw	y			; pointers
  48  0022 90b300        	cpw	y,c_y			; last byte ?
  49  0025 26f5          	jrne	dbcl			; no, loop again
  50  0027 be00          	ldw	x,c_x			; reload pointer
  51  0029               qbcl:
  52  0029 9093          	ldw	y,x			; copy pointer
  53  002b 90ee03        	ldw	y,(3,y)			; update load address
  54  002e 1c0005        	addw	x,#5			; next descriptor
  55  0031 20d8          	jra	ibcl			; and loop
  56                     ;
  57                     ;	reset uninitialized data in zero page
  58                     ;
  59  0033               zero:
  60  0033 ae0000        	ldw	x,#__suzp		; start of uninitialized zpage
  61  0036 2002          	jra	loop			; test segment end first
  62  0038               zbcl:
  63  0038 f7            	ld	(x),a			; clear byte
  64  0039 5c            	incw	x			; next byte
  65  003a               loop:
  66  003a a30000        	cpw	x,#__endzp		; end of zpage
  67  003d 26f9          	jrne	zbcl			; no, continue
  68                     ;
  69                     ;	reset uninitialized data in bss
  70                     ;
  71  003f ae0000        	ldw	x,#__sbss		; start address
  72  0042 2002          	jra	ok			; test segment end first
  73  0044               bbcl:
  74  0044 f7            	ld	(x),a			; clear byte
  75  0045 5c            	incw	x			; next byte
  76  0046               ok:
  77  0046 a30000        	cpw	x,#__memory		; compare end
  78  0049 26f9          	jrne	bbcl			; not equal, continue
  79                     ;
  80                     ;	execute main() function
  81                     ;	may be called by a 'jp' instruction if no return expected
  82                     ;
  83  004b cd0000          call	_EI_stsd_BootMicro
  84  004e cd0000        	call	_EI_stsd_Start			; execute main
  85  0051               _exit:
  86  0051 20fe          	jra	_exit			; and stay here
  87                     ;
  88                     	end
