   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  43                     ; 50 void EI_hsic_WatchdogRefresh (void)
  43                     ; 51 {
  45                     	switch	.text
  46  0000               _EI_hsic_WatchdogRefresh:
  50                     ; 57 }
  53  0000 81            	ret
  77                     ; 69 void EI_hsic_InternalWdogInit(void)
  77                     ; 70 {
  78                     	switch	.text
  79  0001               _EI_hsic_InternalWdogInit:
  83                     ; 72 }
  86  0001 81            	ret
 122                     ; 84 void EI_hsic_ClockSelection(uint8_t ClockSource)
 122                     ; 85 {
 123                     	switch	.text
 124  0002               _EI_hsic_ClockSelection:
 126  0002 88            	push	a
 127       00000000      OFST:	set	0
 130                     ; 87   EI_SETBIT(CLK->SWCR, CLK_SWCR_SWEN);
 132  0003 721250c5      	bset	20677,#1
 133                     ; 90   EI_WRTBYT(CLK->SWR, ClockSource);
 135  0007 c750c4        	ld	20676,a
 137  000a               L35:
 138                     ; 93   while(CLK->CMSR != ClockSource)
 140  000a c650c3        	ld	a,20675
 141  000d 1101          	cp	a,(OFST+1,sp)
 142  000f 26f9          	jrne	L35
 143                     ; 99   EI_CLRBIT(CLK->ICKR, CLK_ICKR_HSIEN);
 145  0011 721150c0      	bres	20672,#0
 146                     ; 102   EI_WRTBYT(CLK->CKDIVR,HSIC_CPU_CLOCK);
 148  0015 725f50c6      	clr	20678
 149                     ; 105   EI_hsic_WatchdogRefresh();
 151  0019 ade5          	call	_EI_hsic_WatchdogRefresh
 153                     ; 106 }
 156  001b 84            	pop	a
 157  001c 81            	ret
 180                     ; 118 void EI_hsic_ClockInit(void)
 180                     ; 119 {
 181                     	switch	.text
 182  001d               _EI_hsic_ClockInit:
 186                     ; 124   EI_SETBIT(CLK->ICKR, CLK_ICKR_HSIEN);
 188  001d 721050c0      	bset	20672,#0
 189                     ; 127   EI_SETBIT(CLK->ICKR, CLK_ICKR_LSIEN);
 191  0021 721650c0      	bset	20672,#3
 192                     ; 132   EI_SETBIT(CLK->ECKR, CLK_ECKR_HSEEN);
 194  0025 721050c1      	bset	20673,#0
 195                     ; 141   EI_SETBIT(CLK->PCKENR1, ( CLK_PCKENR1_TIM2 ));
 197  0029 721a50c7      	bset	20679,#5
 198                     ; 144   EI_SETBIT(CLK->PCKENR2,(CLK_PCKENR2_AWU | CLK_PCKENR2_ADC));
 200  002d c650ca        	ld	a,20682
 201  0030 aa0c          	or	a,#12
 202  0032 c750ca        	ld	20682,a
 203                     ; 152   EI_WRTBYT(CLK->CCOR, CLK_CCOR_CCOSEL);
 205  0035 351e50c9      	mov	20681,#30
 206                     ; 156   EI_WRTBYT(CLK->HSITRIMR, CLK_HSITRIMR_HSITRIM_VALUE);
 208  0039 725f50cc      	clr	20684
 209                     ; 160   EI_WRTBYT(CLK->CKDIVR,	(CLK_CKDIVR_F_CPUDIV1 | CLK_CKDIVR_F_HSIDIV1));
 211  003d 725f50c6      	clr	20678
 212                     ; 161 }
 215  0041 81            	ret
 228                     	xdef	_EI_hsic_InternalWdogInit
 229                     	xdef	_EI_hsic_WatchdogRefresh
 230                     	xdef	_EI_hsic_ClockInit
 231                     	xdef	_EI_hsic_ClockSelection
 250                     	end
