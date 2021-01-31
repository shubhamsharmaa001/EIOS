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
#include "stm8s_iwdg.h"
#include "ei_stsd.h"
#include "ei_krnl_queue.h"
#include "ei_krnl_ticktimer.h"


/*******************Global - Data **********************************************/

/*******************Imported-Function-Prototype*********************************/

/*******************Local -Defines**********************************************/

/*******************Local - Data ***********************************************/

/********************Local - Macros*********************************************/

/********************Private Functions Prototype********************************/
IMPORT u8 EI_krnl_TaskPeriodMng (u8 ei_krnl_Task_Id);
IMPORT u8 EI_krnl_Queue2TaskExecuter (u8 ei_krnl_Task_Id);
IMPORT u8 EI_krnl_Queue1TaskExecuter (u8 ei_krnl_Task_Id);
IMPORT void EI_krnl_IncTickCnt(void);

/********************Global - Functions****************************************/

/**
  ****************************************************************************
  * @Name : EI_krnl_Tick_Run
  * @Description : Restart OS tick management
  * @Interface : void
  * @Pre-condition : none
  * @Constraints : none
  *****************************************************************************
*/
void EI_krnl_Tick_Run (void)
{
  EI_krnl_StartTickTimer();
  EI_krnl_EnableTickInterrupt();
}
/**
  *****************************************************************************
  * @Name : EI_krnl_Tick_Run
  * @Description : Stop OS tick management
  * @Interface : void
  * @Pre-condition : none
  * @Constraints : none                                                         
  *****************************************************************************
*/

void EI_krnl_Tick_Stop (void)
{
  EI_krnl_DisableTickInterrupt();
  EI_krnl_StopTickTimer();
}
/**
  *****************************************************************************
  * @Name : EI_krnl_Tick_it
  * @Description : ISR for OS tick management
  * @Interface : none
  * @Pre-condition : none
  * @Constraints : If os_TASK_DISPATCHER_IT_USED is defined, the priority of
  *               this It must be set to just over os_FirstTaskDispatcher_it
  *               and os_SecondTaskDispatcher_it priorities
  *****************************************************************************
*/

ISR(EI_krnl_Tick_it)
{
  u8 ei_krnl_Task_Id;

  EI_krnl_AckTickInterrupt();
  EI_krnl_IncTickCnt();
  EI_iwdg_WatchdogRefresh();


  ei_krnl_Task_Id = EI_krnl_TaskPeriodMng (ei_krnl_Task_Id);
    //----------------------------------
    // END TASK PERIOD MANAGEMENT
    //----------------------------------
    //----------------------------------
    // FIRST AND SECOND TASK DISPATCHING
    //----------------------------------



    EI_krnl_AllowNestedTickInterrupt();
    /* At this point, os Tick still can not happen
       (until os_EnableTickInterrupt()) ! */
    ei_krnl_Task_Id = EI_krnl_Queue2TaskExecuter (ei_krnl_Task_Id);

    EI_krnl_Queue1TaskExecuter(ei_krnl_Task_Id);


    /* disable ISR to be sure to return from ISR without new OS tick instance */
    /* re-entrance is forbidden from this point, automatically re-allowed     */
    /* when ISR is left (done by Return From ISR assembler instruction)       */
    EI_krnl_DisableAllInterrupts();

    EI_krnl_RestoreNestedTickInterrupt();

    /* enable OS but re-allowed only when ISR is left              */
    /* (done by Return From ISR assembler instruction)             */
    /* Only 2 re-entrance levels are allowed in OS tick management */
    /* to avoid multiple stacking                                  */
    EI_krnl_EnableTickInterrupt();


    /**************************************************************************/
    /* END FIRST AND SECOND TASK DISPATCHING                                  */
    /**************************************************************************/
  } /* End if u8_ei_os_TickCounter == EI_KRNL_TICK_DIVIDER*/


/********End*******(ei_krnl.c)****************************************************/
