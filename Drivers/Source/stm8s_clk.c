/**
  ******************************************************************************
  * @file    ei_stm8s_clk.c
  * @author  EmbeddedIndustry.com
  * @version V1.0
  * @date    30-September-2017
  * @brief   This file contains all functions for clock peripheral
  *********************(C) Copyright 2017 EmbeddedIndustry.com**********************
*/

/***********Include Files ****************************************************/

#include "ei_common.h"




/*********** Local Defines ***************************************************/



 #define HSIC_CPU_CLOCK                  HSIC_FX_DIV_BY_1


 #define HSIC_FX_DIV_BY_1                0x00


 //#define CLK_SOURCE_HSE                  0xB4
 #define CLK_HSITRIMR_HSITRIM_VALUE      0x00
 #define CLK_CKDIVR_F_CPUDIV1            0x00
 #define CLK_CKDIVR_F_HSIDIV1            0x00




/**
  ******************************************************************************
  * @Name : EI_clk_InitializeClock
  * @Description : Initialize  clock
  *******************************************************************************
*/
void EI_clk_InitializeClock(void)
{
  /* HSI On, HSI not ready, Fast wakeup disabled, LSI on, LSI not ready */
  /* , MVR Regulator off */


 // EI_SETBIT(CLK->ICKR, CLK_ICKR_HSIEN);
	CLK->ICKR  |= CLK_ICKR_HSIEN;
 // EI_CLRBIT(CLK->ICKR, CLK_ICKR_HSIRDY);
  //EI_CLRBIT(CLK->ICKR, CLK_ICKR_FHWU);
 // EI_SETBIT(CLK->ICKR, CLK_ICKR_LSIEN);
	CLK->ICKR |= CLK_ICKR_LSIEN;
 // EI_CLRBIT(CLK->ICKR, CLK_ICKR_LSIRDY);
 // CLRBIT(sfrCLK_ICKR, CLK_ICKR_REGAH);

  /* HSE on, HSE not ready */
  //EI_SETBIT(CLK->ECKR, CLK_ECKR_HSEEN);
	CLK->ECKR |= CLK_ECKR_HSEEN;
  //EI_CLRBIT(CLK->ECKR, CLK_ECKR_HSERDY);

  /*Clock switching not in progress, Clock switching disabled, Clock switching*/
  /* interrupt disable, Switch interrupt status is disabled */
 // EI_CLRBIT(CLK->SWCR, (CLK_SWCR_SWBSY | CLK_SWCR_SWEN | CLK_SWCR_SWIEN \
  //  | CLK_SWCR_SWIF));

   /*Enable timer2 clock*/
 // EI_SETBIT(CLK->PCKENR1, ( CLK_PCKENR1_TIM2 ));
   CLK->PCKENR1 |= CLK_PCKENR1_TIM2;
  /*AWU clock enable, ADC clock enable */
//  EI_SETBIT(CLK->PCKENR2,(CLK_PCKENR2_AWU | CLK_PCKENR2_ADC));

  /*Clock security off, Auxiliary OSC off, Clock security interrupt disabled */
  /* HSE crystal clock disturbance not detected */
 // EI_CLRBIT(CLK->CSSR, (CLK_CSSR_CSSEN | CLK_CSSR_AUX | CLK_CSSR_CSSDIE \
  //  | CLK_CSSR_CSSD));

  /*Configurable output disable, Configrable clock  = fcpu */
 // EI_WRTBYT(CLK->CCOR, CLK_CCOR_CCOSEL);
   CLK->CCOR = CLK_CCOR_CCOSEL;
//  EI_CLRBIT(CLK->CCOR, CLK_CCOR_CCOEN);

  /*Set HSI Trimming value */
 // EI_WRTBYT(CLK->HSITRIMR, CLK_HSITRIMR_HSITRIM_VALUE);
  CLK->HSITRIMR = CLK_HSITRIMR_HSITRIM_VALUE;

  /* CPU clock master not divided, HSI clock not divided */
  //EI_WRTBYT(CLK->CKDIVR,	(CLK_CKDIVR_F_CPUDIV1 | CLK_CKDIVR_F_HSIDIV1));
	CLK->CKDIVR =	(CLK_CKDIVR_F_CPUDIV1 | CLK_CKDIVR_F_HSIDIV1);
}
/**
  *******************************************************************************
  * @Name : EI_clk_SelectClock
  * @Description : Change to external clock
  *******************************************************************************
*/
void EI_clk_SelectClock(uint8_t ClockSource)
{
  /* Automatic clock switch */
  CLK->SWCR |= CLK_SWCR_SWEN;

  /* Select clock source */
  CLK->SWR = ClockSource;

  /* Wait for clock stabilization */
  while(CLK->CMSR != ClockSource);


  /* Switch of internal oscillator */
 // EI_CLRBIT(CLK->ICKR, CLK_ICKR_HSIEN);

  /* Divide main clock */
 // EI_WRTBYT(CLK->CKDIVR,HSIC_CPU_CLOCK);
  CLK->CKDIVR = HSIC_CPU_CLOCK;


}





/********End ****** (ei_stm8s_clk.c) ******************************************/
