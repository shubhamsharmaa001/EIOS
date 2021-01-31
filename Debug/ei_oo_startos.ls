   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  66                     ; 45 void EI_oo_StartOS (AppModeType Mode)
  66                     ; 46 {
  68                     	switch	.text
  69  0000               _EI_oo_StartOS:
  71  0000 88            	push	a
  72       00000001      OFST:	set	1
  75                     ; 52   ei_oo_Task_Id = EI_oo_InitOS();
  77  0001 cd0000        	call	_EI_oo_InitOS
  79  0004 6b01          	ld	(OFST+0,sp),a
  81                     ; 56   EI_stsd_StartupHook();
  83  0006 cd0000        	call	_EI_stsd_StartupHook
  85                     ; 60   EI_oo_StartTickTimer();
  87  0009 72105300      	bset	21248,#0
  88                     ; 64   EI_oo_EnableAllInterrupts();
  91  000d 9a            rim
  93  000e               L33:
  94                     ; 70 	  ei_oo_Task_Id = EI_oo_Queue3TaskExecuter (ei_oo_Task_Id);
  96  000e 7b01          	ld	a,(OFST+0,sp)
  97  0010 cd0000        	call	_EI_oo_Queue3TaskExecuter
  99  0013 6b01          	ld	(OFST+0,sp),a
 102  0015 20f7          	jra	L33
 115                     	xref	_EI_oo_Queue3TaskExecuter
 116                     	xref	_EI_oo_InitOS
 117                     	xref	_EI_stsd_StartupHook
 118                     	xdef	_EI_oo_StartOS
 137                     	end
