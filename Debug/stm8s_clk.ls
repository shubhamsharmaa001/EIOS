   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  43                     ; 42 void EI_clk_InitializeClock(void)
  43                     ; 43 {
  45                     	switch	.text
  46  0000               _EI_clk_InitializeClock:
  50                     ; 49 	CLK->ICKR  |= CLK_ICKR_HSIEN;
  52  0000 721050c0      	bset	20672,#0
  53                     ; 53 	CLK->ICKR |= CLK_ICKR_LSIEN;
  55  0004 721650c0      	bset	20672,#3
  56                     ; 59 	CLK->ECKR |= CLK_ECKR_HSEEN;
  58  0008 721050c1      	bset	20673,#0
  59                     ; 69    CLK->PCKENR1 |= CLK_PCKENR1_TIM2;
  61  000c 721a50c7      	bset	20679,#5
  62                     ; 80    CLK->CCOR = CLK_CCOR_CCOSEL;
  64  0010 351e50c9      	mov	20681,#30
  65                     ; 85   CLK->HSITRIMR = CLK_HSITRIMR_HSITRIM_VALUE;
  67  0014 725f50cc      	clr	20684
  68                     ; 89 	CLK->CKDIVR =	(CLK_CKDIVR_F_CPUDIV1 | CLK_CKDIVR_F_HSIDIV1);
  70  0018 725f50c6      	clr	20678
  71                     ; 90 }
  74  001c 81            	ret
 108                     ; 97 void EI_clk_SelectClock(uint8_t ClockSource)
 108                     ; 98 {
 109                     	switch	.text
 110  001d               _EI_clk_SelectClock:
 112  001d 88            	push	a
 113       00000000      OFST:	set	0
 116                     ; 100   CLK->SWCR |= CLK_SWCR_SWEN;
 118  001e 721250c5      	bset	20677,#1
 119                     ; 103   CLK->SWR = ClockSource;
 121  0022 c750c4        	ld	20676,a
 123  0025               L34:
 124                     ; 106   while(CLK->CMSR != ClockSource);
 126  0025 c650c3        	ld	a,20675
 127  0028 1101          	cp	a,(OFST+1,sp)
 128  002a 26f9          	jrne	L34
 129                     ; 114   CLK->CKDIVR = HSIC_CPU_CLOCK;
 131  002c 725f50c6      	clr	20678
 132                     ; 117 }
 135  0030 84            	pop	a
 136  0031 81            	ret
 149                     	xdef	_EI_clk_SelectClock
 150                     	xdef	_EI_clk_InitializeClock
 169                     	end
