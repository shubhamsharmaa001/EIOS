   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  14                     .const:	section	.text
  15  0000               _u8_ei_oo_TasksAddressTable:
  17  0000 0000          	dc.w	_EI_TASK1_Task_ts
  19  0002 0000          	dc.w	_EI_TASK2_Task_ts
  20  0004               _u8_ei_oo_QueueNumberTable:
  21  0004 01            	dc.b	1
  22  0005 00            	dc.b	0
  67                     	xref	_EI_TASK2_Task_ts
  68                     	xref	_EI_TASK1_Task_ts
  69                     	xdef	_u8_ei_oo_QueueNumberTable
  70                     	xdef	_u8_ei_oo_TasksAddressTable
  89                     	end
