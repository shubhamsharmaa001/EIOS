/**
  ******************************************************************************
  * @file    ei_krnl_config.h
  * @author  EmbeddedIndustry
  * @version V1.0
  * @date    30-September-2017
  * @brief   This file contains the OSEK(BCC1) OS configuration
  *********************(C) Copyright 2017 EmbeddedIndustry**********************
*/

#ifndef EI_KRNL_CONFIG_H
#define EI_KRNL_CONFIG_H

/*********** Include Files ***************************************************/

#include "ei_common.h"


/*********** Private Defines *************************************************/
/**
  ******************************************************************************
  * @Define queue usage :                                                       
  * KRNL provide 3 priority level for task.
  * @Priority order : SECOND_QUEUE > FIRST_QUEUE > BACK_QUEUE                   
  * If SECOND_QUEUE is used, FIRST_QUEUE must be used also.                    
  * @ATTENTION :                                                                
  * Enabling the 3 queues increases the CPU load and memory of KRNL module.
  * For 8 bit micro it is better to use only FIRST_QUEUE and BACK_QUEUE        
  ******************************************************************************
*/
#define EI_KRNL_ENABLE_FIFO_QUEUE3
#define EI_KRNL_ENABLE_FIFO_QUEUE1
#define EI_KRNL_ENABLE_FIFO_QUEUE2

/**
  *****************************************************************************
  * @Supported services :                                                       
  * To reduce ROM size (for i.e. for BLF application), not useful service can  
  * be disabled.                                                               
  * In this case, OS will provide an empty macro as service
  ******************************************************************************
*/
#define EI_KRNL_ENABLE_CANCEL_ALARM
#define EI_KRNL_ENABLE_SHUTDOWN

/******************************************************************************/
/* Set task queues size :                                                     */
/* Set the capacity of each queues, maximum size is 255 bytes.                */
/******************************************************************************/
#define  EI_KRNL_BUFFER3_LEN   10
#define  EI_KRNL_BUFFER1_LEN   10
#define  EI_KRNL_BUFFER2_LEN   10


/******************************************************************************/
/* OS tick setting                                                            */
/******************************************************************************/

/* Set tick divider :                                                         */
/* This define is used to apply a software prescaler to OS tick to compute    */
/* the OS timing values (EI_PERIOD and EI_DELAY).                                   */
#define EI_KRNL_TICK_DIVIDER    1

/* Set timer tick EI_PERIOD in micro-second :                                    */
/* This define defines the effective EI_PERIOD of the interrupt use to generate  */
/* the OS tick.                                                               */
#define EI_KRNL_TICK_EI_PERIOD     1000

/* These information are used to compute task alarm EI_PERIOD and EI_DELAY:         */
/* OS tick EI_PERIOD = EI_KRNL_TICK_EI_PERIOD x EI_KRNL_TICK_DIVIDER                      */
/*                                                                            */
/* Task EI_PERIOD value :                                                        */
/* i.e. : EI_PERIOD_10MS = 10000 / (EI_KRNL_TICK_EI_PERIOD x EI_KRNL_TICK_DIVIDER)        */
/*                                                                            */
/* EI_DELAY value :                                                              */
/* i.e. : EI_DELAY_20MS = 20000 / (EI_KRNL_TICK_EI_PERIOD x EI_KRNL_TICK_DIVIDER)         */


/* ----- OS tick setting specific for the STM8A micro -------------------- */


/*********** Global Types *************************************************/
/**
  ******************************************************************************
  * @Alarm name definition:                                                     
  * Complete this enumeration with the name of each Alarm associated to each   
  * task.                                                                      
  ******************************************************************************
*/
typedef enum
{
  EI_TASK1_Task_al,
  EI_TASK2_Task_al,
  NUMBER_OF_TASK
}ei_krnl_Alarm_t;

#define EI_KRNL_NUMBER_OF_TASK  NUMBER_OF_TASK
/**
  ******************************************************************************
  * @EI_DELAYs and EI_PERIODs definitions :
  * Complete the list with the name of pKRNLsible EI_DELAYs and EI_PERIODs and their
  * values
  * @Warning: The resulting defined value must be <= 255                        
  ******************************************************************************
*/
#define EI_NO_DELAY             1   /* Do not remove nor modify */
#define EI_NO_PERIOD            0   /* Do not remove nor modify */
#define EI_DELAY(delay)        (u8)(delay * 1000/(EI_KRNL_TICK_EI_PERIOD*EI_KRNL_TICK_DIVIDER))
#define EI_PERIOD(delay)       (u8)(delay * 1000/(EI_KRNL_TICK_EI_PERIOD*EI_KRNL_TICK_DIVIDER))

#endif

/*****End ******* (krnl_config.h) ***********************************************/
