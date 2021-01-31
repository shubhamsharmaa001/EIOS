   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  74                     ; 117 StatusType EI_krnl_SetRelAlarm (u8 TaskNumber, u8 FirstDelay, u8 Period)
  74                     ; 118 {
  76                     	switch	.text
  77  0000               _EI_krnl_SetRelAlarm:
  79  0000 89            	pushw	x
  80       00000000      OFST:	set	0
  83                     ; 119   EI_krnl_DisableTickInterrupt();
  85  0001 72115303      	bres	21251,#0
  86                     ; 121   u8_ei_krnl_TaskPeriod[TaskNumber]        = Period;
  88  0005 9e            	ld	a,xh
  89  0006 5f            	clrw	x
  90  0007 97            	ld	xl,a
  91  0008 7b05          	ld	a,(OFST+5,sp)
  92  000a e720          	ld	(L52_u8_ei_krnl_TaskPeriod,x),a
  93                     ; 122   u8_ei_krnl_TaskPeriodCounter[TaskNumber] = FirstDelay;
  95  000c 7b01          	ld	a,(OFST+1,sp)
  96  000e 5f            	clrw	x
  97  000f 97            	ld	xl,a
  98  0010 7b02          	ld	a,(OFST+2,sp)
  99  0012 e71e          	ld	(L72_u8_ei_krnl_TaskPeriodCounter,x),a
 100                     ; 124   EI_krnl_EnableTickInterrupt();
 102  0014 72105303      	bset	21251,#0
 103                     ; 126   return (E_OK);
 105  0018 4f            	clr	a
 108  0019 85            	popw	x
 109  001a 81            	ret
 133                     ; 135 void EI_krnl_IncTickCnt(void)
 133                     ; 136 {
 134                     	switch	.text
 135  001b               _EI_krnl_IncTickCnt:
 139                     ; 137 	u8_ei_krnl_TickCounter++;
 141  001b 3c24          	inc	L71_u8_ei_krnl_TickCounter
 142                     ; 138 }
 145  001d 81            	ret
 186                     ; 151  u8 EI_krnl_InitOS (void)
 186                     ; 152 {
 187                     	switch	.text
 188  001e               _EI_krnl_InitOS:
 190  001e 88            	push	a
 191       00000001      OFST:	set	1
 194                     ; 157 	  EI_krnl_InitTickTimer();
 196  001f 725f530e      	clr	21262
 199  0023 353e530f      	mov	21263,#62
 202  0027 35805310      	mov	21264,#128
 205  002b 72115304      	bres	21252,#0
 206                     ; 159 	  u8_ei_krnl_TickCounter = 0;
 208  002f 3f24          	clr	L71_u8_ei_krnl_TickCounter
 209                     ; 164 	  u8_ei_krnl_QueueNumber = EI_KRNL_FIFO_QUEUE3;
 211  0031 3f23          	clr	L12_u8_ei_krnl_QueueNumber
 212                     ; 170 	  for (ei_krnl_Task_Id = 0; ei_krnl_Task_Id < EI_KRNL_NUMBER_OF_TASK; ei_krnl_Task_Id++)
 214  0033 0f01          	clr	(OFST+0,sp)
 216  0035               L121:
 217                     ; 172 	    u8_ei_krnl_TaskPeriodCounter[ei_krnl_Task_Id] = 0;
 219  0035 7b01          	ld	a,(OFST+0,sp)
 220  0037 5f            	clrw	x
 221  0038 97            	ld	xl,a
 222  0039 6f1e          	clr	(L72_u8_ei_krnl_TaskPeriodCounter,x)
 223                     ; 170 	  for (ei_krnl_Task_Id = 0; ei_krnl_Task_Id < EI_KRNL_NUMBER_OF_TASK; ei_krnl_Task_Id++)
 225  003b 0c01          	inc	(OFST+0,sp)
 229  003d 7b01          	ld	a,(OFST+0,sp)
 230  003f a102          	cp	a,#2
 231  0041 25f2          	jrult	L121
 232                     ; 176 	  u8_ei_krnl_FifoQ3In  = EI_KRNL_BUFFER3_LEN - 1;
 234  0043 3509002a      	mov	L3_u8_ei_krnl_FifoQ3In,#9
 235                     ; 177 	  u8_ei_krnl_FifoQ3Out = EI_KRNL_BUFFER3_LEN - 1;
 237  0047 35090029      	mov	L5_u8_ei_krnl_FifoQ3Out,#9
 238                     ; 181 	  u8_ei_krnl_FifoQ1In  = EI_KRNL_BUFFER1_LEN - 1;
 240  004b 35090028      	mov	L7_u8_ei_krnl_FifoQ1In,#9
 241                     ; 182 	  u8_ei_krnl_FifoQ1Out = EI_KRNL_BUFFER1_LEN - 1;
 243  004f 35090027      	mov	L11_u8_ei_krnl_FifoQ1Out,#9
 244                     ; 185       return ei_krnl_Task_Id;
 246  0053 7b01          	ld	a,(OFST+0,sp)
 249  0055 5b01          	addw	sp,#1
 250  0057 81            	ret
 299                     ; 198  u8 EI_krnl_TaskPeriodMng (u8 ei_krnl_Task_Id)
 299                     ; 199 {
 300                     	switch	.text
 301  0058               _EI_krnl_TaskPeriodMng:
 303  0058 88            	push	a
 304       00000000      OFST:	set	0
 307                     ; 200 	  if (u8_ei_krnl_TickCounter == EI_KRNL_TICK_DIVIDER)
 309  0059 b624          	ld	a,L71_u8_ei_krnl_TickCounter
 310  005b a101          	cp	a,#1
 311  005d 2673          	jrne	L541
 312                     ; 202 	    u8_ei_krnl_TickCounter = 0;
 314  005f 3f24          	clr	L71_u8_ei_krnl_TickCounter
 315                     ; 204 	    EI_krnl_DisableTickEnableAllIsr();
 317  0061 72115303      	bres	21251,#0
 321  0065 9a            rim
 323                     ; 209 	    for (ei_krnl_Task_Id = 0; ei_krnl_Task_Id <= (EI_KRNL_NUMBER_OF_TASK - 1); ei_krnl_Task_Id++)
 326  0066 0f01          	clr	(OFST+1,sp)
 327  0068               L741:
 328                     ; 211 	      if (u8_ei_krnl_TaskPeriodCounter[ei_krnl_Task_Id] != 0)
 330  0068 7b01          	ld	a,(OFST+1,sp)
 331  006a 5f            	clrw	x
 332  006b 97            	ld	xl,a
 333  006c 6d1e          	tnz	(L72_u8_ei_krnl_TaskPeriodCounter,x)
 334  006e 275a          	jreq	L551
 335                     ; 213 	        u8_ei_krnl_TaskPeriodCounter[ei_krnl_Task_Id]--;
 337  0070 7b01          	ld	a,(OFST+1,sp)
 338  0072 5f            	clrw	x
 339  0073 97            	ld	xl,a
 340  0074 6a1e          	dec	(L72_u8_ei_krnl_TaskPeriodCounter,x)
 341                     ; 215 	        if (u8_ei_krnl_TaskPeriodCounter[ei_krnl_Task_Id] == 0)
 343  0076 7b01          	ld	a,(OFST+1,sp)
 344  0078 5f            	clrw	x
 345  0079 97            	ld	xl,a
 346  007a 6d1e          	tnz	(L72_u8_ei_krnl_TaskPeriodCounter,x)
 347  007c 264c          	jrne	L551
 348                     ; 220 	            if (u8_ei_krnl_QueueNumberTable[ei_krnl_Task_Id] == EI_KRNL_FIFO_QUEUE3)
 350  007e 7b01          	ld	a,(OFST+1,sp)
 351  0080 5f            	clrw	x
 352  0081 97            	ld	xl,a
 353  0082 724d0000      	tnz	(_u8_ei_krnl_QueueNumberTable,x)
 354  0086 261e          	jrne	L161
 355                     ; 223 	              u8_ei_krnl_FifoQ3In++;
 357  0088 3c2a          	inc	L3_u8_ei_krnl_FifoQ3In
 358                     ; 224 	              if (u8_ei_krnl_FifoQ3In == EI_KRNL_BUFFER3_LEN)
 360  008a b62a          	ld	a,L3_u8_ei_krnl_FifoQ3In
 361  008c a10a          	cp	a,#10
 362  008e 2602          	jrne	L361
 363                     ; 226 	                u8_ei_krnl_FifoQ3In = 0;
 365  0090 3f2a          	clr	L3_u8_ei_krnl_FifoQ3In
 366  0092               L361:
 367                     ; 228 	              if (u8_ei_krnl_FifoQ3In == u8_ei_krnl_FifoQ3Out)
 369  0092 b62a          	ld	a,L3_u8_ei_krnl_FifoQ3In
 370  0094 b129          	cp	a,L5_u8_ei_krnl_FifoQ3Out
 371  0096 2604          	jrne	L561
 372                     ; 231 	                EI_krnl_DisableAllInterrupts();
 375  0098 9b            sim
 377                     ; 232 	                EI_stsd_Reset();
 380  0099 cd0000        	call	_EI_stsd_Reset
 382  009c               L561:
 383                     ; 234 	              u8_ei_krnl_Q3Buffer[u8_ei_krnl_FifoQ3In] = ei_krnl_Task_Id;
 385  009c b62a          	ld	a,L3_u8_ei_krnl_FifoQ3In
 386  009e 5f            	clrw	x
 387  009f 97            	ld	xl,a
 388  00a0 7b01          	ld	a,(OFST+1,sp)
 389  00a2 e714          	ld	(L13_u8_ei_krnl_Q3Buffer,x),a
 391  00a4 201c          	jra	L761
 392  00a6               L161:
 393                     ; 244 	              u8_ei_krnl_FifoQ1In++;
 395  00a6 3c28          	inc	L7_u8_ei_krnl_FifoQ1In
 396                     ; 245 	              if (u8_ei_krnl_FifoQ1In == EI_KRNL_BUFFER1_LEN)
 398  00a8 b628          	ld	a,L7_u8_ei_krnl_FifoQ1In
 399  00aa a10a          	cp	a,#10
 400  00ac 2602          	jrne	L171
 401                     ; 247 	                u8_ei_krnl_FifoQ1In = 0;
 403  00ae 3f28          	clr	L7_u8_ei_krnl_FifoQ1In
 404  00b0               L171:
 405                     ; 249 	              if (u8_ei_krnl_FifoQ1In == u8_ei_krnl_FifoQ1Out)
 407  00b0 b628          	ld	a,L7_u8_ei_krnl_FifoQ1In
 408  00b2 b127          	cp	a,L11_u8_ei_krnl_FifoQ1Out
 409  00b4 2604          	jrne	L371
 410                     ; 252 	                EI_krnl_DisableAllInterrupts();
 413  00b6 9b            sim
 415                     ; 253 	                EI_stsd_Reset();
 418  00b7 cd0000        	call	_EI_stsd_Reset
 420  00ba               L371:
 421                     ; 255 	              u8_ei_krnl_Q1Buffer[u8_ei_krnl_FifoQ1In] = ei_krnl_Task_Id;
 423  00ba b628          	ld	a,L7_u8_ei_krnl_FifoQ1In
 424  00bc 5f            	clrw	x
 425  00bd 97            	ld	xl,a
 426  00be 7b01          	ld	a,(OFST+1,sp)
 427  00c0 e70a          	ld	(L33_u8_ei_krnl_Q1Buffer,x),a
 428  00c2               L761:
 429                     ; 261 	          u8_ei_krnl_TaskPeriodCounter[ei_krnl_Task_Id] = u8_ei_krnl_TaskPeriod[ei_krnl_Task_Id];
 431  00c2 7b01          	ld	a,(OFST+1,sp)
 432  00c4 5f            	clrw	x
 433  00c5 97            	ld	xl,a
 434  00c6 e620          	ld	a,(L52_u8_ei_krnl_TaskPeriod,x)
 435  00c8 e71e          	ld	(L72_u8_ei_krnl_TaskPeriodCounter,x),a
 436  00ca               L551:
 437                     ; 209 	    for (ei_krnl_Task_Id = 0; ei_krnl_Task_Id <= (EI_KRNL_NUMBER_OF_TASK - 1); ei_krnl_Task_Id++)
 439  00ca 0c01          	inc	(OFST+1,sp)
 442  00cc 7b01          	ld	a,(OFST+1,sp)
 443  00ce a102          	cp	a,#2
 444  00d0 2596          	jrult	L741
 445  00d2               L541:
 446                     ; 266 	  return ei_krnl_Task_Id;
 448  00d2 7b01          	ld	a,(OFST+1,sp)
 451  00d4 5b01          	addw	sp,#1
 452  00d6 81            	ret
 492                     ; 278  u8 EI_krnl_Queue1TaskExecuter (u8 ei_krnl_Task_Id)
 492                     ; 279 {
 493                     	switch	.text
 494  00d7               _EI_krnl_Queue1TaskExecuter:
 496  00d7 88            	push	a
 497       00000000      OFST:	set	0
 500                     ; 282     if (u8_ei_krnl_QueueNumber < EI_KRNL_FIFO_QUEUE1)
 502  00d8 3d23          	tnz	L12_u8_ei_krnl_QueueNumber
 503  00da 2637          	jrne	L312
 504                     ; 284       u8_ei_krnl_QueueNumber = EI_KRNL_FIFO_QUEUE1;
 506  00dc 35010023      	mov	L12_u8_ei_krnl_QueueNumber,#1
 508  00e0 2029          	jra	L122
 509  00e2               L512:
 510                     ; 288         u8_ei_krnl_FifoQ1Out++;
 512  00e2 3c27          	inc	L11_u8_ei_krnl_FifoQ1Out
 513                     ; 289         if (u8_ei_krnl_FifoQ1Out == EI_KRNL_BUFFER1_LEN)
 515  00e4 b627          	ld	a,L11_u8_ei_krnl_FifoQ1Out
 516  00e6 a10a          	cp	a,#10
 517  00e8 2602          	jrne	L522
 518                     ; 291           u8_ei_krnl_FifoQ1Out = 0;
 520  00ea 3f27          	clr	L11_u8_ei_krnl_FifoQ1Out
 521  00ec               L522:
 522                     ; 294         ei_krnl_Task_Id = u8_ei_krnl_Q1Buffer[u8_ei_krnl_FifoQ1Out];
 524  00ec b627          	ld	a,L11_u8_ei_krnl_FifoQ1Out
 525  00ee 5f            	clrw	x
 526  00ef 97            	ld	xl,a
 527  00f0 e60a          	ld	a,(L33_u8_ei_krnl_Q1Buffer,x)
 528  00f2 6b01          	ld	(OFST+1,sp),a
 529                     ; 296         EI_krnl_EnableTickInterrupt();
 531  00f4 72105303      	bset	21251,#0
 532                     ; 301         if (ei_krnl_Task_Id != EI_KRNL_EMPTY_TASK)
 534  00f8 7b01          	ld	a,(OFST+1,sp)
 535  00fa a102          	cp	a,#2
 536  00fc 2709          	jreq	L722
 537                     ; 303           (*(u8_ei_krnl_TasksAddressTable[ei_krnl_Task_Id]))();
 539  00fe 7b01          	ld	a,(OFST+1,sp)
 540  0100 5f            	clrw	x
 541  0101 97            	ld	xl,a
 542  0102 58            	sllw	x
 543  0103 de0000        	ldw	x,(_u8_ei_krnl_TasksAddressTable,x)
 544  0106 fd            	call	(x)
 546  0107               L722:
 547                     ; 306         EI_krnl_DisableTickInterrupt();
 549  0107 72115303      	bres	21251,#0
 550  010b               L122:
 551                     ; 286       while (u8_ei_krnl_FifoQ1In != u8_ei_krnl_FifoQ1Out)
 553  010b b628          	ld	a,L7_u8_ei_krnl_FifoQ1In
 554  010d b127          	cp	a,L11_u8_ei_krnl_FifoQ1Out
 555  010f 26d1          	jrne	L512
 556                     ; 311       u8_ei_krnl_QueueNumber = EI_KRNL_FIFO_QUEUE3;
 558  0111 3f23          	clr	L12_u8_ei_krnl_QueueNumber
 559  0113               L312:
 560                     ; 313     return ei_krnl_Task_Id;
 562  0113 7b01          	ld	a,(OFST+1,sp)
 565  0115 5b01          	addw	sp,#1
 566  0117 81            	ret
 607                     ; 328  u8 EI_krnl_Queue2TaskExecuter (u8 ei_krnl_Task_Id)
 607                     ; 329 {
 608                     	switch	.text
 609  0118               _EI_krnl_Queue2TaskExecuter:
 611  0118 88            	push	a
 612       00000000      OFST:	set	0
 615                     ; 332    if (u8_ei_krnl_OldQueueNumber < u8_ei_krnl_QueueNumber)
 617  0119 b622          	ld	a,L32_u8_ei_krnl_OldQueueNumber
 618  011b b123          	cp	a,L12_u8_ei_krnl_QueueNumber
 619  011d 2437          	jruge	L742
 620                     ; 334 	   u8_ei_krnl_OldQueueNumber = u8_ei_krnl_QueueNumber;
 622  011f 452322        	mov	L32_u8_ei_krnl_OldQueueNumber,L12_u8_ei_krnl_QueueNumber
 623                     ; 335 	   u8_ei_krnl_QueueNumber    = EI_KRNL_FIFO_QUEUE2;
 625  0122 35020023      	mov	L12_u8_ei_krnl_QueueNumber,#2
 627  0126 2025          	jra	L552
 628  0128               L152:
 629                     ; 339     	 u8_ei_krnl_FifoQ2Out++;
 631  0128 3c25          	inc	L51_u8_ei_krnl_FifoQ2Out
 632                     ; 340        if (u8_ei_krnl_FifoQ2Out == EI_KRNL_BUFFER2_LEN)
 634  012a b625          	ld	a,L51_u8_ei_krnl_FifoQ2Out
 635  012c a10a          	cp	a,#10
 636  012e 2602          	jrne	L162
 637                     ; 342     	   u8_ei_krnl_FifoQ2Out = 0;
 639  0130 3f25          	clr	L51_u8_ei_krnl_FifoQ2Out
 640  0132               L162:
 641                     ; 345        ei_krnl_Task_Id = u8_ei_krnl_Q2Buffer[u8_ei_krnl_FifoQ2Out];
 643  0132 b625          	ld	a,L51_u8_ei_krnl_FifoQ2Out
 644  0134 5f            	clrw	x
 645  0135 97            	ld	xl,a
 646  0136 e600          	ld	a,(L53_u8_ei_krnl_Q2Buffer,x)
 647  0138 6b01          	ld	(OFST+1,sp),a
 648                     ; 350        if (ei_krnl_Task_Id != EI_KRNL_EMPTY_TASK)
 650  013a 7b01          	ld	a,(OFST+1,sp)
 651  013c a102          	cp	a,#2
 652  013e 2709          	jreq	L362
 653                     ; 352          (*(u8_ei_krnl_TasksAddressTable[ei_krnl_Task_Id]))();
 655  0140 7b01          	ld	a,(OFST+1,sp)
 656  0142 5f            	clrw	x
 657  0143 97            	ld	xl,a
 658  0144 58            	sllw	x
 659  0145 de0000        	ldw	x,(_u8_ei_krnl_TasksAddressTable,x)
 660  0148 fd            	call	(x)
 662  0149               L362:
 663                     ; 355        EI_krnl_DisableTickInterrupt();
 665  0149 72115303      	bres	21251,#0
 666  014d               L552:
 667                     ; 337      while (u8_ei_krnl_FifoQ2In != u8_ei_krnl_FifoQ2Out)
 669  014d b626          	ld	a,L31_u8_ei_krnl_FifoQ2In
 670  014f b125          	cp	a,L51_u8_ei_krnl_FifoQ2Out
 671  0151 26d5          	jrne	L152
 672                     ; 360      u8_ei_krnl_QueueNumber = u8_ei_krnl_OldQueueNumber;
 674  0153 452223        	mov	L12_u8_ei_krnl_QueueNumber,L32_u8_ei_krnl_OldQueueNumber
 675  0156               L742:
 676                     ; 362    return ei_krnl_Task_Id;
 678  0156 7b01          	ld	a,(OFST+1,sp)
 681  0158 5b01          	addw	sp,#1
 682  015a 81            	ret
 721                     ; 376  u8 EI_krnl_Queue3TaskExecuter (u8 ei_krnl_Task_Id)
 721                     ; 377 {
 722                     	switch	.text
 723  015b               _EI_krnl_Queue3TaskExecuter:
 725  015b 88            	push	a
 726       00000000      OFST:	set	0
 729                     ; 379     if (u8_ei_krnl_FifoQ3In != u8_ei_krnl_FifoQ3Out)
 731  015c b62a          	ld	a,L3_u8_ei_krnl_FifoQ3In
 732  015e b129          	cp	a,L5_u8_ei_krnl_FifoQ3Out
 733  0160 272b          	jreq	L303
 734                     ; 381       u8_ei_krnl_FifoQ3Out++;
 736  0162 3c29          	inc	L5_u8_ei_krnl_FifoQ3Out
 737                     ; 382       if (u8_ei_krnl_FifoQ3Out == EI_KRNL_BUFFER3_LEN)
 739  0164 b629          	ld	a,L5_u8_ei_krnl_FifoQ3Out
 740  0166 a10a          	cp	a,#10
 741  0168 2602          	jrne	L503
 742                     ; 384         u8_ei_krnl_FifoQ3Out = 0;
 744  016a 3f29          	clr	L5_u8_ei_krnl_FifoQ3Out
 745  016c               L503:
 746                     ; 387       ei_krnl_Task_Id = u8_ei_krnl_Q3Buffer[u8_ei_krnl_FifoQ3Out];
 748  016c b629          	ld	a,L5_u8_ei_krnl_FifoQ3Out
 749  016e 5f            	clrw	x
 750  016f 97            	ld	xl,a
 751  0170 e614          	ld	a,(L13_u8_ei_krnl_Q3Buffer,x)
 752  0172 6b01          	ld	(OFST+1,sp),a
 753                     ; 390       EI_krnl_EnableTickInterrupt();
 755  0174 72105303      	bset	21251,#0
 756                     ; 395       if (ei_krnl_Task_Id != EI_KRNL_EMPTY_TASK)
 758  0178 7b01          	ld	a,(OFST+1,sp)
 759  017a a102          	cp	a,#2
 760  017c 2709          	jreq	L703
 761                     ; 397         (*(u8_ei_krnl_TasksAddressTable[ei_krnl_Task_Id]))();
 763  017e 7b01          	ld	a,(OFST+1,sp)
 764  0180 5f            	clrw	x
 765  0181 97            	ld	xl,a
 766  0182 58            	sllw	x
 767  0183 de0000        	ldw	x,(_u8_ei_krnl_TasksAddressTable,x)
 768  0186 fd            	call	(x)
 770  0187               L703:
 771                     ; 400       EI_krnl_DisableTickInterrupt();
 773  0187 72115303      	bres	21251,#0
 775  018b 2004          	jra	L113
 776  018d               L303:
 777                     ; 407       EI_krnl_EnableTickInterrupt();
 779  018d 72105303      	bset	21251,#0
 780  0191               L113:
 781                     ; 411     return ei_krnl_Task_Id;
 783  0191 7b01          	ld	a,(OFST+1,sp)
 786  0193 5b01          	addw	sp,#1
 787  0195 81            	ret
 947                     	xdef	_EI_krnl_Queue3TaskExecuter
 948                     	xdef	_EI_krnl_Queue2TaskExecuter
 949                     	xdef	_EI_krnl_Queue1TaskExecuter
 950                     	xdef	_EI_krnl_TaskPeriodMng
 951                     	xdef	_EI_krnl_InitOS
 952                     	xdef	_EI_krnl_IncTickCnt
 953                     	switch	.ubsct
 954  0000               L53_u8_ei_krnl_Q2Buffer:
 955  0000 000000000000  	ds.b	10
 956  000a               L33_u8_ei_krnl_Q1Buffer:
 957  000a 000000000000  	ds.b	10
 958  0014               L13_u8_ei_krnl_Q3Buffer:
 959  0014 000000000000  	ds.b	10
 960  001e               L72_u8_ei_krnl_TaskPeriodCounter:
 961  001e 0000          	ds.b	2
 962  0020               L52_u8_ei_krnl_TaskPeriod:
 963  0020 0000          	ds.b	2
 964  0022               L32_u8_ei_krnl_OldQueueNumber:
 965  0022 00            	ds.b	1
 966  0023               L12_u8_ei_krnl_QueueNumber:
 967  0023 00            	ds.b	1
 968  0024               L71_u8_ei_krnl_TickCounter:
 969  0024 00            	ds.b	1
 970  0025               L51_u8_ei_krnl_FifoQ2Out:
 971  0025 00            	ds.b	1
 972  0026               L31_u8_ei_krnl_FifoQ2In:
 973  0026 00            	ds.b	1
 974  0027               L11_u8_ei_krnl_FifoQ1Out:
 975  0027 00            	ds.b	1
 976  0028               L7_u8_ei_krnl_FifoQ1In:
 977  0028 00            	ds.b	1
 978  0029               L5_u8_ei_krnl_FifoQ3Out:
 979  0029 00            	ds.b	1
 980  002a               L3_u8_ei_krnl_FifoQ3In:
 981  002a 00            	ds.b	1
 982                     	xref	_u8_ei_krnl_QueueNumberTable
 983                     	xref	_u8_ei_krnl_TasksAddressTable
 984                     	xref	_EI_stsd_Reset
 985                     	xdef	_EI_krnl_SetRelAlarm
1005                     	end
