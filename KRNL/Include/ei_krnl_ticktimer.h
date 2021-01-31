/**
  ******************************************************************************
  * @file    ei_krnl_TickTimer.h
  * @author  EmbeddedIndustry
  * @version V1.0
  * @date    30-September-2017
  * @brief   This file contains the OSEK(BCC1) TickTimer functionality
  *********************(C) Copyright 2017 EmbeddedIndustry**********************
*/
#ifndef EI_KRNL_TICK_TIMER_H
#define EI_KRNL_TICK_TIMER_H


/******************* Include Files*********************************************/

#include "ei_common.h"


/******************* Private Defines ******************************************/

/******************************************************************************/
/* OS Tick timer clock defines                                                */
/******************************************************************************/
/*
 * 0x3E80   ->  16Mhz oscillator  used
 * 0x1F40   ->  8Mhz  oscillator  Not used
 */


#define EI_KRNL_COUNTER_THRESHOLD_H    0x3E
#define EI_KRNL_COUNTER_THRESHOLD_L    0X80




/* do not use interrupt level */
#undef EI_KRNL_INTERRUPT_LEVEL_USED
#undef EI_KRNL_NO_INTERRUPT_ENABLE_FLAG
#undef EI_KRNL_COMPENSATION_COUNTER_VALUE
#undef EI_KRNL_TASK_DISPATCHER_IT_USED


/* The OS uses the timer TIM2 */
#define EI_krnl_InitTickTimer()                           \
  /* Set pre-scaler value */                            \
	EI_WRTBYT(TIM2->PSCR, TIM2_PRESCALER_1);            \
	/* Set timer threshold */                           \
	EI_WRTBYT(TIM2->ARRH, EI_KRNL_COUNTER_THRESHOLD_H);   \
	EI_WRTBYT(TIM2->ARRL, EI_KRNL_COUNTER_THRESHOLD_L);   \
  /* clear pending timer interrupt */                   \
	EI_CLRBIT(TIM2->SR1, TIM2_SR1_UIF)
 
  
#define EI_krnl_StopTickTimer()                           \
/* Disable timer */                                     \
 EI_CLRBIT(TIM2->CR1, TIM2_CR1_CEN)

#define EI_krnl_StartTickTimer()                          \
 /* Enable timer */                                     \
 EI_SETBIT(TIM2->CR1, TIM2_CR1_CEN)
  
#define EI_krnl_EnableTickInterrupt()                     \
 /* Enable timer interrupt */                           \
 EI_SETBIT(TIM2->IER, TIM2_IER_UIE)
  
#define EI_krnl_DisableTickInterrupt()                    \
 /* Disable timer interrupt */                          \
 EI_CLRBIT(TIM2->IER, TIM2_IER_UIE)
 
#define EI_krnl_AckTickInterrupt()                        \
 /* acknowledge timer interrupt */                      \
 EI_CLRBIT(TIM2->SR1, TIM2_SR1_UIF)
  
#define EI_krnl_EnableNmi()

#define EI_krnl_AllowNestedTickInterrupt()
#define EI_krnl_RestoreNestedTickInterrupt()



#endif /* EI_KRNL_TICK_TIMER_H */

/********* End ****** (ei_krnl_TickTimer.h) ************************************/
