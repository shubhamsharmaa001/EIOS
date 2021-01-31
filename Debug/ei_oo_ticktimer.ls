   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  42                     ; 48 void EI_oo_Tick_Run (void)
  42                     ; 49 {
  44                     	switch	.text
  45  0000               _EI_oo_Tick_Run:
  49                     ; 50   EI_oo_StartTickTimer();
  51  0000 72105300      	bset	21248,#0
  52                     ; 51   EI_oo_EnableTickInterrupt();
  54  0004 72105303      	bset	21251,#0
  55                     ; 52 }
  58  0008 81            	ret
  81                     ; 63 void EI_oo_Tick_Stop (void)
  81                     ; 64 {
  82                     	switch	.text
  83  0009               _EI_oo_Tick_Stop:
  87                     ; 65   EI_oo_DisableTickInterrupt();
  89  0009 72115303      	bres	21251,#0
  90                     ; 66   EI_oo_StopTickTimer();
  92  000d 72115300      	bres	21248,#0
  93                     ; 67 }
  96  0011 81            	ret
 136                     ; 80 ISR(EI_oo_Tick_it)
 136                     ; 81 {
 138                     	switch	.text
 139  0012               f_EI_oo_Tick_it:
 141  0012 8a            	push	cc
 142  0013 84            	pop	a
 143  0014 a4bf          	and	a,#191
 144  0016 88            	push	a
 145  0017 86            	pop	cc
 146       00000001      OFST:	set	1
 147  0018 3b0002        	push	c_x+2
 148  001b be00          	ldw	x,c_x
 149  001d 89            	pushw	x
 150  001e 3b0002        	push	c_y+2
 151  0021 be00          	ldw	x,c_y
 152  0023 89            	pushw	x
 153  0024 88            	push	a
 156                     ; 84   EI_oo_AckTickInterrupt();
 158  0025 72115304      	bres	21252,#0
 159                     ; 85   EI_oo_IncTickCnt();
 161  0029 cd0000        	call	_EI_oo_IncTickCnt
 163                     ; 86   EI_hsic_WatchdogRefresh();
 165  002c cd0000        	call	_EI_hsic_WatchdogRefresh
 167                     ; 89   ei_oo_Task_Id = EI_oo_TaskPeriodMng (ei_oo_Task_Id);
 169  002f 7b01          	ld	a,(OFST+0,sp)
 170  0031 cd0000        	call	_EI_oo_TaskPeriodMng
 172  0034 6b01          	ld	(OFST+0,sp),a
 174                     ; 102     ei_oo_Task_Id = EI_oo_Queue2TaskExecuter (ei_oo_Task_Id);
 177  0036 7b01          	ld	a,(OFST+0,sp)
 178  0038 cd0000        	call	_EI_oo_Queue2TaskExecuter
 180  003b 6b01          	ld	(OFST+0,sp),a
 182                     ; 104     EI_oo_Queue1TaskExecuter(ei_oo_Task_Id);
 184  003d 7b01          	ld	a,(OFST+0,sp)
 185  003f cd0000        	call	_EI_oo_Queue1TaskExecuter
 187                     ; 110     EI_oo_DisableAllInterrupts();
 190  0042 9b            sim
 192                     ; 118     EI_oo_EnableTickInterrupt();
 196  0043 72105303      	bset	21251,#0
 197                     ; 124   } /* End if u8_ei_os_TickCounter == EI_OO_TICK_DIVIDER*/
 200  0047 84            	pop	a
 201  0048 85            	popw	x
 202  0049 bf00          	ldw	c_y,x
 203  004b 320002        	pop	c_y+2
 204  004e 85            	popw	x
 205  004f bf00          	ldw	c_x,x
 206  0051 320002        	pop	c_x+2
 207  0054 80            	iret
 219                     	xref	_EI_oo_IncTickCnt
 220                     	xref	_EI_oo_Queue1TaskExecuter
 221                     	xref	_EI_oo_Queue2TaskExecuter
 222                     	xref	_EI_oo_TaskPeriodMng
 223                     	xdef	f_EI_oo_Tick_it
 224                     	xdef	_EI_oo_Tick_Stop
 225                     	xdef	_EI_oo_Tick_Run
 226                     	xref	_EI_hsic_WatchdogRefresh
 227                     	xref.b	c_x
 228                     	xref.b	c_y
 247                     	end
