   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  73                     ; 116 StatusType EI_oo_SetRelAlarm (u8 TaskNumber, u8 FirstDelay, u8 Period)
  73                     ; 117 {
  75                     	switch	.text
  76  0000               _EI_oo_SetRelAlarm:
  78  0000 89            	pushw	x
  79       00000000      OFST:	set	0
  82                     ; 118   EI_oo_DisableTickInterrupt();
  84  0001 72115303      	bres	21251,#0
  85                     ; 120   u8_ei_oo_TaskPeriod[TaskNumber]        = Period;
  87  0005 9e            	ld	a,xh
  88  0006 5f            	clrw	x
  89  0007 97            	ld	xl,a
  90  0008 7b05          	ld	a,(OFST+5,sp)
  91  000a e720          	ld	(L52_u8_ei_oo_TaskPeriod,x),a
  92                     ; 121   u8_ei_oo_TaskPeriodCounter[TaskNumber] = FirstDelay;
  94  000c 7b01          	ld	a,(OFST+1,sp)
  95  000e 5f            	clrw	x
  96  000f 97            	ld	xl,a
  97  0010 7b02          	ld	a,(OFST+2,sp)
  98  0012 e71e          	ld	(L72_u8_ei_oo_TaskPeriodCounter,x),a
  99                     ; 123   EI_oo_EnableTickInterrupt();
 101  0014 72105303      	bset	21251,#0
 102                     ; 125   return (E_OK);
 104  0018 4f            	clr	a
 107  0019 85            	popw	x
 108  001a 81            	ret
 132                     ; 134 void EI_oo_IncTickCnt(void)
 132                     ; 135 {
 133                     	switch	.text
 134  001b               _EI_oo_IncTickCnt:
 138                     ; 136 	u8_ei_oo_TickCounter++;
 140  001b 3c24          	inc	L71_u8_ei_oo_TickCounter
 141                     ; 137 }
 144  001d 81            	ret
 185                     ; 150  u8 EI_oo_InitOS (void)
 185                     ; 151 {
 186                     	switch	.text
 187  001e               _EI_oo_InitOS:
 189  001e 88            	push	a
 190       00000001      OFST:	set	1
 193                     ; 156 	  EI_oo_InitTickTimer();
 195  001f 725f530e      	clr	21262
 198  0023 353e530f      	mov	21263,#62
 201  0027 35805310      	mov	21264,#128
 204  002b 72115304      	bres	21252,#0
 205                     ; 158 	  u8_ei_oo_TickCounter = 0;
 207  002f 3f24          	clr	L71_u8_ei_oo_TickCounter
 208                     ; 163 	  u8_ei_oo_QueueNumber = EI_OO_FIFO_QUEUE3;
 210  0031 3f23          	clr	L12_u8_ei_oo_QueueNumber
 211                     ; 169 	  for (ei_oo_Task_Id = 0; ei_oo_Task_Id < EI_OO_NUMBER_OF_TASK; ei_oo_Task_Id++)
 213  0033 0f01          	clr	(OFST+0,sp)
 215  0035               L121:
 216                     ; 171 	    u8_ei_oo_TaskPeriodCounter[ei_oo_Task_Id] = 0;
 218  0035 7b01          	ld	a,(OFST+0,sp)
 219  0037 5f            	clrw	x
 220  0038 97            	ld	xl,a
 221  0039 6f1e          	clr	(L72_u8_ei_oo_TaskPeriodCounter,x)
 222                     ; 169 	  for (ei_oo_Task_Id = 0; ei_oo_Task_Id < EI_OO_NUMBER_OF_TASK; ei_oo_Task_Id++)
 224  003b 0c01          	inc	(OFST+0,sp)
 228  003d 7b01          	ld	a,(OFST+0,sp)
 229  003f a102          	cp	a,#2
 230  0041 25f2          	jrult	L121
 231                     ; 175 	  u8_ei_oo_FifoQ3In  = EI_OO_BUFFER3_LEN - 1;
 233  0043 3509002a      	mov	L3_u8_ei_oo_FifoQ3In,#9
 234                     ; 176 	  u8_ei_oo_FifoQ3Out = EI_OO_BUFFER3_LEN - 1;
 236  0047 35090029      	mov	L5_u8_ei_oo_FifoQ3Out,#9
 237                     ; 180 	  u8_ei_oo_FifoQ1In  = EI_OO_BUFFER1_LEN - 1;
 239  004b 35090028      	mov	L7_u8_ei_oo_FifoQ1In,#9
 240                     ; 181 	  u8_ei_oo_FifoQ1Out = EI_OO_BUFFER1_LEN - 1;
 242  004f 35090027      	mov	L11_u8_ei_oo_FifoQ1Out,#9
 243                     ; 184       return ei_oo_Task_Id;
 245  0053 7b01          	ld	a,(OFST+0,sp)
 248  0055 5b01          	addw	sp,#1
 249  0057 81            	ret
 298                     ; 197  u8 EI_oo_TaskPeriodMng (u8 ei_oo_Task_Id)
 298                     ; 198 {
 299                     	switch	.text
 300  0058               _EI_oo_TaskPeriodMng:
 302  0058 88            	push	a
 303       00000000      OFST:	set	0
 306                     ; 199 	  if (u8_ei_oo_TickCounter == EI_OO_TICK_DIVIDER)
 308  0059 b624          	ld	a,L71_u8_ei_oo_TickCounter
 309  005b a101          	cp	a,#1
 310  005d 2673          	jrne	L541
 311                     ; 201 	    u8_ei_oo_TickCounter = 0;
 313  005f 3f24          	clr	L71_u8_ei_oo_TickCounter
 314                     ; 203 	    EI_oo_DisableTickEnableAllIsr();
 316  0061 72115303      	bres	21251,#0
 320  0065 9a            rim
 322                     ; 208 	    for (ei_oo_Task_Id = 0; ei_oo_Task_Id <= (EI_OO_NUMBER_OF_TASK - 1); ei_oo_Task_Id++)
 325  0066 0f01          	clr	(OFST+1,sp)
 326  0068               L741:
 327                     ; 210 	      if (u8_ei_oo_TaskPeriodCounter[ei_oo_Task_Id] != 0)
 329  0068 7b01          	ld	a,(OFST+1,sp)
 330  006a 5f            	clrw	x
 331  006b 97            	ld	xl,a
 332  006c 6d1e          	tnz	(L72_u8_ei_oo_TaskPeriodCounter,x)
 333  006e 275a          	jreq	L551
 334                     ; 212 	        u8_ei_oo_TaskPeriodCounter[ei_oo_Task_Id]--;
 336  0070 7b01          	ld	a,(OFST+1,sp)
 337  0072 5f            	clrw	x
 338  0073 97            	ld	xl,a
 339  0074 6a1e          	dec	(L72_u8_ei_oo_TaskPeriodCounter,x)
 340                     ; 214 	        if (u8_ei_oo_TaskPeriodCounter[ei_oo_Task_Id] == 0)
 342  0076 7b01          	ld	a,(OFST+1,sp)
 343  0078 5f            	clrw	x
 344  0079 97            	ld	xl,a
 345  007a 6d1e          	tnz	(L72_u8_ei_oo_TaskPeriodCounter,x)
 346  007c 264c          	jrne	L551
 347                     ; 219 	            if (u8_ei_oo_QueueNumberTable[ei_oo_Task_Id] == EI_OO_FIFO_QUEUE3)
 349  007e 7b01          	ld	a,(OFST+1,sp)
 350  0080 5f            	clrw	x
 351  0081 97            	ld	xl,a
 352  0082 724d0000      	tnz	(_u8_ei_oo_QueueNumberTable,x)
 353  0086 261e          	jrne	L161
 354                     ; 222 	              u8_ei_oo_FifoQ3In++;
 356  0088 3c2a          	inc	L3_u8_ei_oo_FifoQ3In
 357                     ; 223 	              if (u8_ei_oo_FifoQ3In == EI_OO_BUFFER3_LEN)
 359  008a b62a          	ld	a,L3_u8_ei_oo_FifoQ3In
 360  008c a10a          	cp	a,#10
 361  008e 2602          	jrne	L361
 362                     ; 225 	                u8_ei_oo_FifoQ3In = 0;
 364  0090 3f2a          	clr	L3_u8_ei_oo_FifoQ3In
 365  0092               L361:
 366                     ; 227 	              if (u8_ei_oo_FifoQ3In == u8_ei_oo_FifoQ3Out)
 368  0092 b62a          	ld	a,L3_u8_ei_oo_FifoQ3In
 369  0094 b129          	cp	a,L5_u8_ei_oo_FifoQ3Out
 370  0096 2604          	jrne	L561
 371                     ; 230 	                EI_oo_DisableAllInterrupts();
 374  0098 9b            sim
 376                     ; 231 	                EI_stsd_Reset();
 379  0099 cd0000        	call	_EI_stsd_Reset
 381  009c               L561:
 382                     ; 233 	              u8_ei_oo_Q3Buffer[u8_ei_oo_FifoQ3In] = ei_oo_Task_Id;
 384  009c b62a          	ld	a,L3_u8_ei_oo_FifoQ3In
 385  009e 5f            	clrw	x
 386  009f 97            	ld	xl,a
 387  00a0 7b01          	ld	a,(OFST+1,sp)
 388  00a2 e714          	ld	(L13_u8_ei_oo_Q3Buffer,x),a
 390  00a4 201c          	jra	L761
 391  00a6               L161:
 392                     ; 243 	              u8_ei_oo_FifoQ1In++;
 394  00a6 3c28          	inc	L7_u8_ei_oo_FifoQ1In
 395                     ; 244 	              if (u8_ei_oo_FifoQ1In == EI_OO_BUFFER1_LEN)
 397  00a8 b628          	ld	a,L7_u8_ei_oo_FifoQ1In
 398  00aa a10a          	cp	a,#10
 399  00ac 2602          	jrne	L171
 400                     ; 246 	                u8_ei_oo_FifoQ1In = 0;
 402  00ae 3f28          	clr	L7_u8_ei_oo_FifoQ1In
 403  00b0               L171:
 404                     ; 248 	              if (u8_ei_oo_FifoQ1In == u8_ei_oo_FifoQ1Out)
 406  00b0 b628          	ld	a,L7_u8_ei_oo_FifoQ1In
 407  00b2 b127          	cp	a,L11_u8_ei_oo_FifoQ1Out
 408  00b4 2604          	jrne	L371
 409                     ; 251 	                EI_oo_DisableAllInterrupts();
 412  00b6 9b            sim
 414                     ; 252 	                EI_stsd_Reset();
 417  00b7 cd0000        	call	_EI_stsd_Reset
 419  00ba               L371:
 420                     ; 254 	              u8_ei_oo_Q1Buffer[u8_ei_oo_FifoQ1In] = ei_oo_Task_Id;
 422  00ba b628          	ld	a,L7_u8_ei_oo_FifoQ1In
 423  00bc 5f            	clrw	x
 424  00bd 97            	ld	xl,a
 425  00be 7b01          	ld	a,(OFST+1,sp)
 426  00c0 e70a          	ld	(L33_u8_ei_oo_Q1Buffer,x),a
 427  00c2               L761:
 428                     ; 260 	          u8_ei_oo_TaskPeriodCounter[ei_oo_Task_Id] = u8_ei_oo_TaskPeriod[ei_oo_Task_Id];
 430  00c2 7b01          	ld	a,(OFST+1,sp)
 431  00c4 5f            	clrw	x
 432  00c5 97            	ld	xl,a
 433  00c6 e620          	ld	a,(L52_u8_ei_oo_TaskPeriod,x)
 434  00c8 e71e          	ld	(L72_u8_ei_oo_TaskPeriodCounter,x),a
 435  00ca               L551:
 436                     ; 208 	    for (ei_oo_Task_Id = 0; ei_oo_Task_Id <= (EI_OO_NUMBER_OF_TASK - 1); ei_oo_Task_Id++)
 438  00ca 0c01          	inc	(OFST+1,sp)
 441  00cc 7b01          	ld	a,(OFST+1,sp)
 442  00ce a102          	cp	a,#2
 443  00d0 2596          	jrult	L741
 444  00d2               L541:
 445                     ; 265 	  return ei_oo_Task_Id;
 447  00d2 7b01          	ld	a,(OFST+1,sp)
 450  00d4 5b01          	addw	sp,#1
 451  00d6 81            	ret
 491                     ; 277  u8 EI_oo_Queue1TaskExecuter (u8 ei_oo_Task_Id)
 491                     ; 278 {
 492                     	switch	.text
 493  00d7               _EI_oo_Queue1TaskExecuter:
 495  00d7 88            	push	a
 496       00000000      OFST:	set	0
 499                     ; 281     if (u8_ei_oo_QueueNumber < EI_OO_FIFO_QUEUE1)
 501  00d8 3d23          	tnz	L12_u8_ei_oo_QueueNumber
 502  00da 2637          	jrne	L312
 503                     ; 283       u8_ei_oo_QueueNumber = EI_OO_FIFO_QUEUE1;
 505  00dc 35010023      	mov	L12_u8_ei_oo_QueueNumber,#1
 507  00e0 2029          	jra	L122
 508  00e2               L512:
 509                     ; 287         u8_ei_oo_FifoQ1Out++;
 511  00e2 3c27          	inc	L11_u8_ei_oo_FifoQ1Out
 512                     ; 288         if (u8_ei_oo_FifoQ1Out == EI_OO_BUFFER1_LEN)
 514  00e4 b627          	ld	a,L11_u8_ei_oo_FifoQ1Out
 515  00e6 a10a          	cp	a,#10
 516  00e8 2602          	jrne	L522
 517                     ; 290           u8_ei_oo_FifoQ1Out = 0;
 519  00ea 3f27          	clr	L11_u8_ei_oo_FifoQ1Out
 520  00ec               L522:
 521                     ; 293         ei_oo_Task_Id = u8_ei_oo_Q1Buffer[u8_ei_oo_FifoQ1Out];
 523  00ec b627          	ld	a,L11_u8_ei_oo_FifoQ1Out
 524  00ee 5f            	clrw	x
 525  00ef 97            	ld	xl,a
 526  00f0 e60a          	ld	a,(L33_u8_ei_oo_Q1Buffer,x)
 527  00f2 6b01          	ld	(OFST+1,sp),a
 528                     ; 295         EI_oo_EnableTickInterrupt();
 530  00f4 72105303      	bset	21251,#0
 531                     ; 300         if (ei_oo_Task_Id != EI_OO_EMPTY_TASK)
 533  00f8 7b01          	ld	a,(OFST+1,sp)
 534  00fa a102          	cp	a,#2
 535  00fc 2709          	jreq	L722
 536                     ; 302           (*(u8_ei_oo_TasksAddressTable[ei_oo_Task_Id]))();
 538  00fe 7b01          	ld	a,(OFST+1,sp)
 539  0100 5f            	clrw	x
 540  0101 97            	ld	xl,a
 541  0102 58            	sllw	x
 542  0103 de0000        	ldw	x,(_u8_ei_oo_TasksAddressTable,x)
 543  0106 fd            	call	(x)
 545  0107               L722:
 546                     ; 305         EI_oo_DisableTickInterrupt();
 548  0107 72115303      	bres	21251,#0
 549  010b               L122:
 550                     ; 285       while (u8_ei_oo_FifoQ1In != u8_ei_oo_FifoQ1Out)
 552  010b b628          	ld	a,L7_u8_ei_oo_FifoQ1In
 553  010d b127          	cp	a,L11_u8_ei_oo_FifoQ1Out
 554  010f 26d1          	jrne	L512
 555                     ; 310       u8_ei_oo_QueueNumber = EI_OO_FIFO_QUEUE3;
 557  0111 3f23          	clr	L12_u8_ei_oo_QueueNumber
 558  0113               L312:
 559                     ; 312     return ei_oo_Task_Id;
 561  0113 7b01          	ld	a,(OFST+1,sp)
 564  0115 5b01          	addw	sp,#1
 565  0117 81            	ret
 606                     ; 327  u8 EI_oo_Queue2TaskExecuter (u8 ei_oo_Task_Id)
 606                     ; 328 {
 607                     	switch	.text
 608  0118               _EI_oo_Queue2TaskExecuter:
 610  0118 88            	push	a
 611       00000000      OFST:	set	0
 614                     ; 331    if (u8_ei_oo_OldQueueNumber < u8_ei_oo_QueueNumber)
 616  0119 b622          	ld	a,L32_u8_ei_oo_OldQueueNumber
 617  011b b123          	cp	a,L12_u8_ei_oo_QueueNumber
 618  011d 2437          	jruge	L742
 619                     ; 333 	   u8_ei_oo_OldQueueNumber = u8_ei_oo_QueueNumber;
 621  011f 452322        	mov	L32_u8_ei_oo_OldQueueNumber,L12_u8_ei_oo_QueueNumber
 622                     ; 334 	   u8_ei_oo_QueueNumber    = EI_OO_FIFO_QUEUE2;
 624  0122 35020023      	mov	L12_u8_ei_oo_QueueNumber,#2
 626  0126 2025          	jra	L552
 627  0128               L152:
 628                     ; 338     	 u8_ei_oo_FifoQ2Out++;
 630  0128 3c25          	inc	L51_u8_ei_oo_FifoQ2Out
 631                     ; 339        if (u8_ei_oo_FifoQ2Out == EI_OO_BUFFER2_LEN)
 633  012a b625          	ld	a,L51_u8_ei_oo_FifoQ2Out
 634  012c a10a          	cp	a,#10
 635  012e 2602          	jrne	L162
 636                     ; 341     	   u8_ei_oo_FifoQ2Out = 0;
 638  0130 3f25          	clr	L51_u8_ei_oo_FifoQ2Out
 639  0132               L162:
 640                     ; 344        ei_oo_Task_Id = u8_ei_oo_Q2Buffer[u8_ei_oo_FifoQ2Out];
 642  0132 b625          	ld	a,L51_u8_ei_oo_FifoQ2Out
 643  0134 5f            	clrw	x
 644  0135 97            	ld	xl,a
 645  0136 e600          	ld	a,(L53_u8_ei_oo_Q2Buffer,x)
 646  0138 6b01          	ld	(OFST+1,sp),a
 647                     ; 349        if (ei_oo_Task_Id != EI_OO_EMPTY_TASK)
 649  013a 7b01          	ld	a,(OFST+1,sp)
 650  013c a102          	cp	a,#2
 651  013e 2709          	jreq	L362
 652                     ; 351          (*(u8_ei_oo_TasksAddressTable[ei_oo_Task_Id]))();
 654  0140 7b01          	ld	a,(OFST+1,sp)
 655  0142 5f            	clrw	x
 656  0143 97            	ld	xl,a
 657  0144 58            	sllw	x
 658  0145 de0000        	ldw	x,(_u8_ei_oo_TasksAddressTable,x)
 659  0148 fd            	call	(x)
 661  0149               L362:
 662                     ; 354        EI_oo_DisableTickInterrupt();
 664  0149 72115303      	bres	21251,#0
 665  014d               L552:
 666                     ; 336      while (u8_ei_oo_FifoQ2In != u8_ei_oo_FifoQ2Out)
 668  014d b626          	ld	a,L31_u8_ei_oo_FifoQ2In
 669  014f b125          	cp	a,L51_u8_ei_oo_FifoQ2Out
 670  0151 26d5          	jrne	L152
 671                     ; 359      u8_ei_oo_QueueNumber = u8_ei_oo_OldQueueNumber;
 673  0153 452223        	mov	L12_u8_ei_oo_QueueNumber,L32_u8_ei_oo_OldQueueNumber
 674  0156               L742:
 675                     ; 361    return ei_oo_Task_Id;
 677  0156 7b01          	ld	a,(OFST+1,sp)
 680  0158 5b01          	addw	sp,#1
 681  015a 81            	ret
 720                     ; 375  u8 EI_oo_Queue3TaskExecuter (u8 ei_oo_Task_Id)
 720                     ; 376 {
 721                     	switch	.text
 722  015b               _EI_oo_Queue3TaskExecuter:
 724  015b 88            	push	a
 725       00000000      OFST:	set	0
 728                     ; 378     if (u8_ei_oo_FifoQ3In != u8_ei_oo_FifoQ3Out)
 730  015c b62a          	ld	a,L3_u8_ei_oo_FifoQ3In
 731  015e b129          	cp	a,L5_u8_ei_oo_FifoQ3Out
 732  0160 272b          	jreq	L303
 733                     ; 380       u8_ei_oo_FifoQ3Out++;
 735  0162 3c29          	inc	L5_u8_ei_oo_FifoQ3Out
 736                     ; 381       if (u8_ei_oo_FifoQ3Out == EI_OO_BUFFER3_LEN)
 738  0164 b629          	ld	a,L5_u8_ei_oo_FifoQ3Out
 739  0166 a10a          	cp	a,#10
 740  0168 2602          	jrne	L503
 741                     ; 383         u8_ei_oo_FifoQ3Out = 0;
 743  016a 3f29          	clr	L5_u8_ei_oo_FifoQ3Out
 744  016c               L503:
 745                     ; 386       ei_oo_Task_Id = u8_ei_oo_Q3Buffer[u8_ei_oo_FifoQ3Out];
 747  016c b629          	ld	a,L5_u8_ei_oo_FifoQ3Out
 748  016e 5f            	clrw	x
 749  016f 97            	ld	xl,a
 750  0170 e614          	ld	a,(L13_u8_ei_oo_Q3Buffer,x)
 751  0172 6b01          	ld	(OFST+1,sp),a
 752                     ; 389       EI_oo_EnableTickInterrupt();
 754  0174 72105303      	bset	21251,#0
 755                     ; 394       if (ei_oo_Task_Id != EI_OO_EMPTY_TASK)
 757  0178 7b01          	ld	a,(OFST+1,sp)
 758  017a a102          	cp	a,#2
 759  017c 2709          	jreq	L703
 760                     ; 396         (*(u8_ei_oo_TasksAddressTable[ei_oo_Task_Id]))();
 762  017e 7b01          	ld	a,(OFST+1,sp)
 763  0180 5f            	clrw	x
 764  0181 97            	ld	xl,a
 765  0182 58            	sllw	x
 766  0183 de0000        	ldw	x,(_u8_ei_oo_TasksAddressTable,x)
 767  0186 fd            	call	(x)
 769  0187               L703:
 770                     ; 399       EI_oo_DisableTickInterrupt();
 772  0187 72115303      	bres	21251,#0
 774  018b 2004          	jra	L113
 775  018d               L303:
 776                     ; 408       EI_oo_EnableTickInterrupt();
 778  018d 72105303      	bset	21251,#0
 779  0191               L113:
 780                     ; 413     return ei_oo_Task_Id;
 782  0191 7b01          	ld	a,(OFST+1,sp)
 785  0193 5b01          	addw	sp,#1
 786  0195 81            	ret
 937                     	xdef	_EI_oo_Queue3TaskExecuter
 938                     	xdef	_EI_oo_Queue2TaskExecuter
 939                     	xdef	_EI_oo_Queue1TaskExecuter
 940                     	xdef	_EI_oo_TaskPeriodMng
 941                     	xdef	_EI_oo_InitOS
 942                     	xdef	_EI_oo_IncTickCnt
 943                     	switch	.ubsct
 944  0000               L53_u8_ei_oo_Q2Buffer:
 945  0000 000000000000  	ds.b	10
 946  000a               L33_u8_ei_oo_Q1Buffer:
 947  000a 000000000000  	ds.b	10
 948  0014               L13_u8_ei_oo_Q3Buffer:
 949  0014 000000000000  	ds.b	10
 950  001e               L72_u8_ei_oo_TaskPeriodCounter:
 951  001e 0000          	ds.b	2
 952  0020               L52_u8_ei_oo_TaskPeriod:
 953  0020 0000          	ds.b	2
 954  0022               L32_u8_ei_oo_OldQueueNumber:
 955  0022 00            	ds.b	1
 956  0023               L12_u8_ei_oo_QueueNumber:
 957  0023 00            	ds.b	1
 958  0024               L71_u8_ei_oo_TickCounter:
 959  0024 00            	ds.b	1
 960  0025               L51_u8_ei_oo_FifoQ2Out:
 961  0025 00            	ds.b	1
 962  0026               L31_u8_ei_oo_FifoQ2In:
 963  0026 00            	ds.b	1
 964  0027               L11_u8_ei_oo_FifoQ1Out:
 965  0027 00            	ds.b	1
 966  0028               L7_u8_ei_oo_FifoQ1In:
 967  0028 00            	ds.b	1
 968  0029               L5_u8_ei_oo_FifoQ3Out:
 969  0029 00            	ds.b	1
 970  002a               L3_u8_ei_oo_FifoQ3In:
 971  002a 00            	ds.b	1
 972                     	xref	_u8_ei_oo_QueueNumberTable
 973                     	xref	_u8_ei_oo_TasksAddressTable
 974                     	xref	_EI_stsd_Reset
 975                     	xdef	_EI_oo_SetRelAlarm
 995                     	end
