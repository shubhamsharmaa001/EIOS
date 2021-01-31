   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  43                     ; 40 void EI_iwdg_WatchdogRefresh(void)
  43                     ; 41 {
  45                     	switch	.text
  46  0000               _EI_iwdg_WatchdogRefresh:
  50                     ; 47 }
  53  0000 81            	ret
  77                     ; 59 void EI_iwdg_InternalWdogInit(void)
  77                     ; 60 {
  78                     	switch	.text
  79  0001               _EI_iwdg_InternalWdogInit:
  83                     ; 62 }
  86  0001 81            	ret
  99                     	xdef	_EI_iwdg_InternalWdogInit
 100                     	xdef	_EI_iwdg_WatchdogRefresh
 119                     	end
