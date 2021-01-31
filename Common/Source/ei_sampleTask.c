/**
  ******************************************************************************
  * @file    sample_task.c
  * @author  EmbeddedIndustry.com
  * @version V1.0
  * @date    30-September-2017
  * @brief   This file contains the sample tasks for testing
  *********************(C) Copyright 2017 EmbeddedIndustry.com**********************
*/
#include "../../KRNL/Configuration/ei_krnl_cfg.h"
#include "ei_krnl.h"
#include "stm8s_gpio.h"

/************Global Define********************************************/

#define EI_TASK1_DELAY                 EI_NO_DELAY
#define EI_TASK1_PERIOD                EI_DELAY(500)

#define EI_TASK2_DELAY                 EI_NO_DELAY
#define EI_TASK2_PERIOD                EI_DELAY(500)

static int i = 0;
static int j = 0;
static int p = 0;

 TASK(EI_TASK1_Task_ts)
 { j++;
	 i++;
	 if(i>2)
	 {
     GPIO_WriteReverse(GPIOB ,GPIO_PIN_5);
		
		
	 i=0;
 }
		
 }
 TASK(EI_TASK2_Task_ts)
 {
	
	 p++;
  
 }

void EI_TASK1_WakeUp(void) 
{
  /* wake up task with a period of 5 mili seconds */
  EI_krnl_SetRelAlarm(EI_TASK1_Task_al, EI_TASK1_DELAY, EI_TASK1_PERIOD);
}

void EI_TASK1_Init(void) 
{
		GPIO_DeInit(GPIOD);
	  GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_OUT_PP_LOW_FAST);
		
}

void EI_TASK2_WakeUp(void) 
{
  /* wake up task with a period of 5 mili seconds */
  EI_krnl_SetRelAlarm(EI_TASK2_Task_al,EI_TASK2_DELAY,EI_TASK2_PERIOD);
}

void EI_TASK2_Init(void) 
{
	
}
 








/* _____ E N D _____ (sample_task.c) _________________________________________*/
