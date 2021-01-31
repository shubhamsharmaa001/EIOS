   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  42                     ; 12  TASK(EI_TASK1_Task_ts)
  42                     ; 13  {
  44                     	switch	.text
  45  0000               _EI_TASK1_Task_ts:
  49                     ; 15  }
  53  0000 81            	ret
  76                     ; 16  TASK(EI_TASK2_Task_ts)
  76                     ; 17  {
  77                     	switch	.text
  78  0001               _EI_TASK2_Task_ts:
  82                     ; 19  }
  86  0001 81            	ret
  99                     	xdef	_EI_TASK2_Task_ts
 100                     	xdef	_EI_TASK1_Task_ts
 119                     	end
