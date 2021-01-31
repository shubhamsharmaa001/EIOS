   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  14                     	bsct
  15  0000               L3_i:
  16  0000 0000          	dc.w	0
  17  0002               L5_j:
  18  0002 0000          	dc.w	0
  19  0004               L7_p:
  20  0004 0000          	dc.w	0
  52                     ; 26  TASK(EI_TASK1_Task_ts)
  52                     ; 27  { j++;
  54                     	switch	.text
  55  0000               _EI_TASK1_Task_ts:
  61  0000 be02          	ldw	x,L5_j
  62  0002 1c0001        	addw	x,#1
  63  0005 bf02          	ldw	L5_j,x
  64                     ; 28 	 i++;
  66  0007 be00          	ldw	x,L3_i
  67  0009 1c0001        	addw	x,#1
  68  000c bf00          	ldw	L3_i,x
  69                     ; 29 	 if(i>2)
  71  000e 9c            	rvf
  72  000f be00          	ldw	x,L3_i
  73  0011 a30003        	cpw	x,#3
  74  0014 2f0c          	jrslt	L72
  75                     ; 31      GPIO_WriteReverse(GPIOB ,GPIO_PIN_5);
  77  0016 4b20          	push	#32
  78  0018 ae5005        	ldw	x,#20485
  79  001b cd0000        	call	_GPIO_WriteReverse
  81  001e 84            	pop	a
  82                     ; 34 	 i=0;
  84  001f 5f            	clrw	x
  85  0020 bf00          	ldw	L3_i,x
  86  0022               L72:
  87                     ; 37  }
  90  0022 81            	ret
 114                     ; 38  TASK(EI_TASK2_Task_ts)
 114                     ; 39  {
 115                     	switch	.text
 116  0023               _EI_TASK2_Task_ts:
 120                     ; 41 	 p++;
 122  0023 be04          	ldw	x,L7_p
 123  0025 1c0001        	addw	x,#1
 124  0028 bf04          	ldw	L7_p,x
 125                     ; 43  }
 128  002a 81            	ret
 152                     ; 45 void EI_TASK1_WakeUp(void) 
 152                     ; 46 {
 153                     	switch	.text
 154  002b               _EI_TASK1_WakeUp:
 158                     ; 48   EI_krnl_SetRelAlarm(EI_TASK1_Task_al, EI_TASK1_DELAY, EI_TASK1_PERIOD);
 160  002b 4be8          	push	#232
 161  002d ae0001        	ldw	x,#1
 162  0030 cd0000        	call	_EI_krnl_SetRelAlarm
 164  0033 84            	pop	a
 165                     ; 49 }
 168  0034 81            	ret
 193                     ; 51 void EI_TASK1_Init(void) 
 193                     ; 52 {
 194                     	switch	.text
 195  0035               _EI_TASK1_Init:
 199                     ; 53 		GPIO_DeInit(GPIOD);
 201  0035 ae500f        	ldw	x,#20495
 202  0038 cd0000        	call	_GPIO_DeInit
 204                     ; 54 	  GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_OUT_PP_LOW_FAST);
 206  003b 4be0          	push	#224
 207  003d 4b20          	push	#32
 208  003f ae5005        	ldw	x,#20485
 209  0042 cd0000        	call	_GPIO_Init
 211  0045 85            	popw	x
 212                     ; 56 }
 215  0046 81            	ret
 239                     ; 58 void EI_TASK2_WakeUp(void) 
 239                     ; 59 {
 240                     	switch	.text
 241  0047               _EI_TASK2_WakeUp:
 245                     ; 61   EI_krnl_SetRelAlarm(EI_TASK2_Task_al,EI_TASK2_DELAY,EI_TASK2_PERIOD);
 247  0047 4be8          	push	#232
 248  0049 ae0101        	ldw	x,#257
 249  004c cd0000        	call	_EI_krnl_SetRelAlarm
 251  004f 84            	pop	a
 252                     ; 62 }
 255  0050 81            	ret
 278                     ; 64 void EI_TASK2_Init(void) 
 278                     ; 65 {
 279                     	switch	.text
 280  0051               _EI_TASK2_Init:
 284                     ; 67 }
 287  0051 81            	ret
 329                     	xdef	_EI_TASK2_Init
 330                     	xdef	_EI_TASK2_WakeUp
 331                     	xdef	_EI_TASK1_Init
 332                     	xdef	_EI_TASK1_WakeUp
 333                     	xdef	_EI_TASK2_Task_ts
 334                     	xdef	_EI_TASK1_Task_ts
 335                     	xref	_EI_krnl_SetRelAlarm
 336                     	xref	_GPIO_WriteReverse
 337                     	xref	_GPIO_Init
 338                     	xref	_GPIO_DeInit
 357                     	end
