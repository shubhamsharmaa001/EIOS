   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  43                     ; 46 void EI_krnl_Tick_Run (void)
  43                     ; 47 {
  45                     	switch	.text
  46  0000               _EI_krnl_Tick_Run:
  50                     ; 48   EI_krnl_StartTickTimer();
  52  0000 72105300      	bset	21248,#0
  53                     ; 49   EI_krnl_EnableTickInterrupt();
  55  0004 72105303      	bset	21251,#0
  56                     ; 50 }
  59  0008 81            	ret
  82                     ; 61 void EI_krnl_Tick_Stop (void)
  82                     ; 62 {
  83                     	switch	.text
  84  0009               _EI_krnl_Tick_Stop:
  88                     ; 63   EI_krnl_DisableTickInterrupt();
  90  0009 72115303      	bres	21251,#0
  91                     ; 64   EI_krnl_StopTickTimer();
  93  000d 72115300      	bres	21248,#0
  94                     ; 65 }
  97  0011 81            	ret
 137                     ; 78 ISR(EI_krnl_Tick_it)
 137                     ; 79 {
 139                     	switch	.text
 140  0012               f_EI_krnl_Tick_it:
 142  0012 8a            	push	cc
 143  0013 84            	pop	a
 144  0014 a4bf          	and	a,#191
 145  0016 88            	push	a
 146  0017 86            	pop	cc
 147       00000001      OFST:	set	1
 148  0018 3b0002        	push	c_x+2
 149  001b be00          	ldw	x,c_x
 150  001d 89            	pushw	x
 151  001e 3b0002        	push	c_y+2
 152  0021 be00          	ldw	x,c_y
 153  0023 89            	pushw	x
 154  0024 88            	push	a
 157                     ; 82   EI_krnl_AckTickInterrupt();
 159  0025 72115304      	bres	21252,#0
 160                     ; 83   EI_krnl_IncTickCnt();
 162  0029 cd0000        	call	_EI_krnl_IncTickCnt
 164                     ; 84   EI_iwdg_WatchdogRefresh();
 166  002c cd0000        	call	_EI_iwdg_WatchdogRefresh
 168                     ; 87   ei_krnl_Task_Id = EI_krnl_TaskPeriodMng (ei_krnl_Task_Id);
 170  002f 7b01          	ld	a,(OFST+0,sp)
 171  0031 cd0000        	call	_EI_krnl_TaskPeriodMng
 173  0034 6b01          	ld	(OFST+0,sp),a
 175                     ; 100     ei_krnl_Task_Id = EI_krnl_Queue2TaskExecuter (ei_krnl_Task_Id);
 178  0036 7b01          	ld	a,(OFST+0,sp)
 179  0038 cd0000        	call	_EI_krnl_Queue2TaskExecuter
 181  003b 6b01          	ld	(OFST+0,sp),a
 183                     ; 102     EI_krnl_Queue1TaskExecuter(ei_krnl_Task_Id);
 185  003d 7b01          	ld	a,(OFST+0,sp)
 186  003f cd0000        	call	_EI_krnl_Queue1TaskExecuter
 188                     ; 108     EI_krnl_DisableAllInterrupts();
 191  0042 9b            sim
 193                     ; 116     EI_krnl_EnableTickInterrupt();
 197  0043 72105303      	bset	21251,#0
 198                     ; 122   } /* End if u8_ei_os_TickCounter == EI_KRNL_TICK_DIVIDER*/
 201  0047 84            	pop	a
 202  0048 85            	popw	x
 203  0049 bf00          	ldw	c_y,x
 204  004b 320002        	pop	c_y+2
 205  004e 85            	popw	x
 206  004f bf00          	ldw	c_x,x
 207  0051 320002        	pop	c_x+2
 208  0054 80            	iret
 220                     	xref	_EI_krnl_IncTickCnt
 221                     	xref	_EI_krnl_Queue1TaskExecuter
 222                     	xref	_EI_krnl_Queue2TaskExecuter
 223                     	xref	_EI_krnl_TaskPeriodMng
 224                     	xdef	f_EI_krnl_Tick_it
 225                     	xdef	_EI_krnl_Tick_Stop
 226                     	xdef	_EI_krnl_Tick_Run
 227                     	xref	_EI_iwdg_WatchdogRefresh
 228                     	xref.b	c_x
 229                     	xref.b	c_y
 248                     	end
