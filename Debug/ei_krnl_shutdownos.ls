   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  57                     ; 47 void EI_krnl_ShutdownOS (StatusType Error)
  57                     ; 48 {
  59                     	switch	.text
  60  0000               _EI_krnl_ShutdownOS:
  64                     ; 49   EI_krnl_DisableAllInterrupts();
  67  0000 9b            sim
  69                     ; 52   EI_stsd_ShutdownHook(Error);
  72  0001 cd0000        	call	_EI_stsd_ShutdownHook
  74                     ; 53   EI_krnl_StopTickTimer();
  76  0004 72115300      	bres	21248,#0
  77                     ; 55   EI_krnl_EnableAllInterrupts();
  80  0008 9a            rim
  82                     ; 56 }
  86  0009 81            	ret
  99                     	xref	_EI_stsd_ShutdownHook
 100                     	xdef	_EI_krnl_ShutdownOS
 119                     	end
