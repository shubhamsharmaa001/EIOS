/**
  ******************************************************************************
  * @file    ei_krnl_queue.c
  * @author  EmbeddedIndustry
  * @version V1.0
  * @date    30-September-2017
  * @brief   This file contains the OSEK(BCC1) queues definition
  *********************(C) Copyright 2017 EmbeddedIndustry**********************
*/

#ifndef EI_KRNL_QUEUE_H
#define EI_KRNL_QUEUE_H

/******************* Include Files*********************************************/

#include "ei_common.h"
#include "ei_krnl.h"


/******************* Private Defines ******************************************/

/* task queue definition */
#define EI_KRNL_FIFO_QUEUE3    0
#define EI_KRNL_FIFO_QUEUE1    1
#define EI_KRNL_FIFO_QUEUE2    2


/******************* Private Types ********************************************/

typedef void ei_krnl_Task_t (void);


/******************* Private Data *********************************************/

/* Task entry point definition table ******************************************/
extern ei_krnl_Task_t *const u8_ei_krnl_TasksAddressTable[EI_KRNL_NUMBER_OF_TASK];

/* Task priority definition table *********************************************/
extern const u8 u8_ei_krnl_QueueNumberTable[EI_KRNL_NUMBER_OF_TASK];


/******************* Private Macro ********************************************/

#endif /*EI_KRNL_QUEUE_H*/
/******** End ****** (ei_krnl_queue.h) ******************************************/
