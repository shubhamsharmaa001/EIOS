/**
  ******************************************************************************
  * @file    ei_krnl.c
  * @author  EmbeddedIndustry.com
  * @version V1.0
  * @date    30-September-2017
  * @brief   This file contains the OSEK(BCC1) compliant services of real time
  *          operating system
  *********************(C) Copyright 2017 EmbeddedIndustry.com**********************
*/

/******************* Include Files*********************************************/
#include "ei_hsic.h"
#include "ei_stsd.h"
#include "ei_krnl_queue.h"
#include "ei_krnl_ticktimer.h"



/*******************Global - Data **********************************************/

/*******************Imported-Function-Prototype*********************************/

/*******************Local -Defines**********************************************/

/*******************Local - Data ***********************************************/

/********************Local - Macros*********************************************/

/********************Private Functions Prototype********************************/
//IMPORT EI_krnl_DisableAllInterrupts();
//IMPORT EI_stsd_ShutdownHook(StatusType error);
//IMPORT EI_krnl_EnableAllInterrupts();

/********************Global - Functions*****************************************/
/**
  ******************************************************************************
  * @Name : EI_krnl_ShutdownOS
  * @Description : Shutdown OS Activity                                                
  * @Interface : OSEK compliant:                                                
  *             StatusType   Error    IN    Shutddown reason                    
  * @Pre-condition : none                                                       
  * @Constraints : none                                                         
  ******************************************************************************
*/
#ifdef EI_KRNL_ENABLE_SHUTDOWN
void EI_krnl_ShutdownOS (StatusType Error)
{
  EI_krnl_DisableAllInterrupts();

  /* Stop Tasks */
  EI_stsd_ShutdownHook(Error);
  EI_krnl_StopTickTimer();

  EI_krnl_EnableAllInterrupts();
}
#endif /* EI_KRNL_ENABLE_SHUTDOWN */

/********End*******(ei_krnl.c)****************************************************/
