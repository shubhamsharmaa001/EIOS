/**
  ******************************************************************************
  * @file    ei_krnl_config.c
  * @author  EmbeddedIndustry.com
  * @version V1.0
  * @date    30-September-2017
  * @brief   This file contains the OSEK(BCC1) OS configuration
  *********************(C) Copyright 2017 EmbeddedIndustry.com**********************
*/

/**************** Include Files ***********************************************/

#include "ei_common.h"
#include "ei_krnl_queue.h"


/**************** Private Data ************************************************/
/**
  ******************************************************************************
  * @Task address definition                                                    
  * @Set in this table the address of each task entry point.                    
  * @ATTENTION: Respect the order with regard alarm enumeration in              
  *            os_config.h file                                                
  ******************************************************************************
*/
IMPORT TASK(EI_TASK1_Task_ts);
IMPORT TASK(EI_TASK2_Task_ts);


ei_krnl_Task_t *const u8_ei_krnl_TasksAddressTable[EI_KRNL_NUMBER_OF_TASK] =
{
		EI_TASK1_Task_ts,
		EI_TASK2_Task_ts
  
};
/**
  ******************************************************************************
  * @Task priority definition                                                   
  * @In this table you set the priority level of each tasks.                    
  * @The priority is defined by the queue where is located the task.            
  * @Priority order : QUEUE2  > QUEUE1 > QUEUE3   
  * @Task with same priority level are not preemptive among them.               
  * @ATTENTION: Respect the order with regard alarm enumeration and task name   
  *            definition.                                                     
  *****************************************************************************
*/
const u8 u8_ei_krnl_QueueNumberTable[EI_KRNL_NUMBER_OF_TASK] =
{
  EI_KRNL_FIFO_QUEUE1,
  EI_KRNL_FIFO_QUEUE3
};


/*********End******(ei_krnl_config.c)*********************************************/
