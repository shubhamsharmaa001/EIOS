/**
  ******************************************************************************
  * @file    ei_hsic.c
  * @author  EmbeddedIndustry.com
  * @version V1.0
  * @date    30-September-2017
  * @brief   This file contains all functions prototype and macros for the hardware
  *          specific functionality of OS
  *********************(C) Copyright 2017 EmbeddedIndustry.com**********************
*/

/***********Include Files ****************************************************/

#include "ei_common.h"
#include "ei_hsic.h"



/*********** Local Defines ***************************************************/



 #define HSIC_CPU_CLOCK                  HSIC_FX_DIV_BY_1


 #define HSIC_FX_DIV_BY_1                0x00


 //#define CLK_SOURCE_HSE                  0xB4
 #define CLK_HSITRIMR_HSITRIM_VALUE      0x00
 //#define CLK_SWIMCCR_SWIMCLK             0x01
 #define CLK_CKDIVR_F_CPUDIV1            0x00
 #define CLK_CKDIVR_F_HSIDIV1            0x00

// #define IWDG_KR_KEY_ENABLE              0xCC
 //#define IWDG_KR_KEY_ACCESS              0x55
 #define IWDG_KR_KEY_REFRESH             0xAA


/**
  ***************************************************************************
  * @Name : EI_hsic_WatchdogRefresh
  * @Description : Refresh internal  watchdog
  * @Behavior :                                                                 
  *  DO                                                                        
  *    []                                                                      
  *  OD                                                                        
  ***************************************************************************
*/
void EI_hsic_WatchdogRefresh (void)
{
 // static u8 toggle = 0;
  /* Internal watchdog refresh */
 // EI_WRTBYT(IWDG->KR, IWDG_KR_KEY_REFRESH);
  
  
}
/**
  *******************************************************************************
  * @Name : EI_hsic_InternalWdogInit
  * @Description : Initialize internal watchdog                                                                                                  
  * @Constraints : -  Do not use RAM, it's not yet initialized                  
  * @Behavior :                                                                 
  *  DO                                                                        
  *    []                                                                      
  *  OD                                                                       
  *******************************************************************************
*/
void EI_hsic_InternalWdogInit(void)
{

}
/**
  *******************************************************************************
  * @Name : EI_hsic_ClockSelection
  * @Description : Change CPU clock source                                                                                                       
  * @Behavior :                                                                 
  *  DO                                                                        
  *
  *    [set clock registers]                                                   
  *  OD                                                                        
  *******************************************************************************
*/
void EI_hsic_ClockSelection(uint8_t ClockSource)
{
  /* Automatic clock switch */
  EI_SETBIT(CLK->SWCR, CLK_SWCR_SWEN);

  /* Select clock source */
  EI_WRTBYT(CLK->SWR, ClockSource);

  /* Wait for clock stabilization */
  while(CLK->CMSR != ClockSource)
  {
    ;
  }

  /* Switch of internal oscillator */
  EI_CLRBIT(CLK->ICKR, CLK_ICKR_HSIEN);

  /* Divide main clock */
  EI_WRTBYT(CLK->CKDIVR,HSIC_CPU_CLOCK);

  /* watchdog refresh */
  EI_hsic_WatchdogRefresh();
}
/**
  ******************************************************************************
  * @Name : EI_hsic_ClockInit
  * @Description : Initialize CPU clock                                                
  * @Behavior :                                                                 
  *  DO                                                                        
  *    [set map registers]                                                     
  *    [set clock registers]                                                   
  *  OD                                                                        
  *******************************************************************************
*/
void EI_hsic_ClockInit(void)
{
  /* HSI On, HSI not ready, Fast wakeup disabled, LSI on, LSI not ready */
  /* , MVR Regulator off */


  EI_SETBIT(CLK->ICKR, CLK_ICKR_HSIEN);
 // EI_CLRBIT(CLK->ICKR, CLK_ICKR_HSIRDY);
  //EI_CLRBIT(CLK->ICKR, CLK_ICKR_FHWU);
  EI_SETBIT(CLK->ICKR, CLK_ICKR_LSIEN);
 // EI_CLRBIT(CLK->ICKR, CLK_ICKR_LSIRDY);
 // CLRBIT(sfrCLK_ICKR, CLK_ICKR_REGAH);
							
  /* HSE on, HSE not ready */
  EI_SETBIT(CLK->ECKR, CLK_ECKR_HSEEN);
  //EI_CLRBIT(CLK->ECKR, CLK_ECKR_HSERDY);

  /*Clock switching not in progress, Clock switching disabled, Clock switching*/
  /* interrupt disable, Switch interrupt status is disabled */		
 // EI_CLRBIT(CLK->SWCR, (CLK_SWCR_SWBSY | CLK_SWCR_SWEN | CLK_SWCR_SWIEN \
  //  | CLK_SWCR_SWIF));

   /*Enable timer2 clock*/
  EI_SETBIT(CLK->PCKENR1, ( CLK_PCKENR1_TIM2 ));

  /*AWU clock enable, ADC clock enable */  										
  EI_SETBIT(CLK->PCKENR2,(CLK_PCKENR2_AWU | CLK_PCKENR2_ADC));

  /*Clock security off, Auxiliary OSC off, Clock security interrupt disabled */
  /* HSE crystal clock disturbance not detected */
 // EI_CLRBIT(CLK->CSSR, (CLK_CSSR_CSSEN | CLK_CSSR_AUX | CLK_CSSR_CSSDIE \
  //  | CLK_CSSR_CSSD));

  /*Configurable output disable, Configrable clock  = fcpu */							
  EI_WRTBYT(CLK->CCOR, CLK_CCOR_CCOSEL);
//  EI_CLRBIT(CLK->CCOR, CLK_CCOR_CCOEN);

  /*Set HSI Trimming value */
  EI_WRTBYT(CLK->HSITRIMR, CLK_HSITRIMR_HSITRIM_VALUE);


  /* CPU clock master not divided, HSI clock not divided */
  EI_WRTBYT(CLK->CKDIVR,	(CLK_CKDIVR_F_CPUDIV1 | CLK_CKDIVR_F_HSIDIV1));
}




/********End ****** (ei_hsic.c) ********************************************/
