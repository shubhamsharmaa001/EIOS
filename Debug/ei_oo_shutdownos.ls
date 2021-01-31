   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  56                     ; 46 void EI_oo_ShutdownOS (StatusType Error) 
  56                     ; 47 {
  58                     	switch	.text
  59  0000               _EI_oo_ShutdownOS:
  63                     ; 48   EI_oo_DisableAllInterrupts();
  66  0000 9b            sim
  68                     ; 51   EI_stsd_ShutdownHook(Error);
  71  0001 cd0000        	call	_EI_stsd_ShutdownHook
  73                     ; 52   EI_oo_StopTickTimer();
  75  0004 72115300      	bres	21248,#0
  76                     ; 54   EI_oo_EnableAllInterrupts();
  79  0008 9a            rim
  81                     ; 55 }
  85  0009 81            	ret
  98                     	xref	_EI_stsd_ShutdownHook
  99                     	xdef	_EI_oo_ShutdownOS
 118                     	end
