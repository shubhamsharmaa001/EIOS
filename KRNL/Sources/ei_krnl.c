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
#include "stm8s_tim2.h"
#include "stm8s_iwdg.h"
#include "ei_stsd.h"
#include "ei_krnl_queue.h"
#include "ei_krnl_ticktimer.h"


/*******************Global - Data **********************************************/


/*******************Imported-Function-Prototype*********************************/

/* OSEK compliant Hook */
//IMPORT void EI_stsd_StartupHook (void);
//`IMPORT void EI_stsd_ShutdownHook (StatusType);


/*******************Local -Defines**********************************************/

#define EI_KRNL_EMPTY_TASK   EI_KRNL_NUMBER_OF_TASK




/*******************Local - Data ***********************************************/

#ifdef EI_KRNL_ENABLE_FIFO_QUEUE3
static  u8 u8_ei_krnl_FifoQ3In;
static  u8 u8_ei_krnl_FifoQ3Out;
#endif /* EI_KRNL_ENABLE_FIFO_QUEUE3 */

#ifdef EI_KRNL_ENABLE_FIFO_QUEUE1
static  u8 u8_ei_krnl_FifoQ1In;
static  u8 u8_ei_krnl_FifoQ1Out;
#endif /* EI_KRNL_ENABLE_FIFO_QUEUE1 */

#ifdef EI_KRNL_ENABLE_FIFO_QUEUE2
static  u8 u8_ei_krnl_FifoQ2In;
static  u8 u8_ei_krnl_FifoQ2Out;
#endif /* EI_KRNL_ENABLE_FIFO_QUEUE2 */


static  u8 u8_ei_krnl_TickCounter;

#ifndef EI_KRNL_TASK_DISPATCHER_IT_USED
#if defined(EI_KRNL_ENABLE_FIFO_QUEUE1) || defined(EI_KRNL_ENABLE_FIFO_QUEUE2)
static  u8 u8_ei_krnl_QueueNumber;
#endif /* EI_KRNL_ENABLE_FIFO_QUEUE1 || EI_KRNL_ENABLE_FIFO_QUEUE2 */

#ifdef EI_KRNL_ENABLE_FIFO_QUEUE2
static  u8 u8_ei_krnl_OldQueueNumber;
#endif /* EI_KRNL_ENABLE_FIFO_QUEUE2 */

#endif /* EI_KRNL_TASK_DISPATCHER_IT_USED */



static u8 u8_ei_krnl_TaskPeriod[EI_KRNL_NUMBER_OF_TASK];
static u8 u8_ei_krnl_TaskPeriodCounter[EI_KRNL_NUMBER_OF_TASK];

#ifdef EI_KRNL_ENABLE_FIFO_QUEUE3
static u8 u8_ei_krnl_Q3Buffer[EI_KRNL_BUFFER3_LEN];
#endif /* EI_KRNL_ENABLE_FIFO_QUEUE3 */
#ifdef EI_KRNL_ENABLE_FIFO_QUEUE1
static u8 u8_ei_krnl_Q1Buffer[EI_KRNL_BUFFER1_LEN];
#endif /* EI_KRNL_ENABLE_FIFO_QUEUE1 */
#ifdef EI_KRNL_ENABLE_FIFO_QUEUE2
static u8 u8_ei_krnl_Q2Buffer[EI_KRNL_BUFFER2_LEN];
#endif /* EI_KRNL_ENABLE_FIFO_QUEUE2 */


/********************Local - Macros********************************************/

#if !defined(EI_KRNL_TASK_DISPATCHER_IT_USED) && !defined(EI_KRNL_IT_DURATION_MEASUREMENT)
#define EI_krnl_DisableTickEnableAllIsr()  \
        EI_krnl_DisableTickInterrupt();    \
        EI_krnl_EnableAllInterrupts()
        
#endif


/********************Private Functions Prototype*******************************/
//static u8 EI_krnl_InitOS (void);
 //u8 EI_krnl_TaskPeriodMng (u8 ei_krnl_Task_Id);
 //u8 EI_krnl_Queue1TaskExecuter (u8 ei_krnl_Task_Id);
 //u8 EI_krnl_Queue2TaskExecuter (u8 ei_krnl_Task_Id);
//static u8 EI_krnl_Queue3TaskExecuter (u8 ei_krnl_Task_Id);

/********************Global - Functions****************************************/

/**
  ******************************************************************************
  * @Name : SetRelAlarm                                                         
  * @Description : Set alarm timing for Task activation                                
  * @Interface : OSEK compliant:                                                
  *             u8  TaskNumber    IN    Alarm number (= Task number)        
  *             u8  FirstDelay    IN    First delay before first activation 
  *             u8  Period        IN    Activation cycle time               
  * @Pre-condition : none                                                       
  * @Constraints : Do not call this function in an interrupt function           
  *               FirstDelay must be != 0                                      
  ******************************************************************************
*/

StatusType EI_krnl_SetRelAlarm (u8 TaskNumber, u8 FirstDelay, u8 Period)
{
  EI_krnl_DisableTickInterrupt();

  u8_ei_krnl_TaskPeriod[TaskNumber]        = Period;
  u8_ei_krnl_TaskPeriodCounter[TaskNumber] = FirstDelay;

  EI_krnl_EnableTickInterrupt();

  return (E_OK);
}
/**
  ******************************************************************************
  * @Name : SetRelAlarm                                                         
  * @Description : Increment Tick counter                               
  *                                    
  ******************************************************************************
*/
void EI_krnl_IncTickCnt(void)
{
	u8_ei_krnl_TickCounter++;
}



/**
  ******************************************************************************
  * @Name : EI_krnl_InitOS
  * @Description : Initialize operating system before scheduling
  * @Pre-condition : Must be called with all interrupt disabled
  * @Constraints : none
  ******************************************************************************
*/

 u8 EI_krnl_InitOS (void)
{
	  u8 ei_krnl_Task_Id;
	  //-----------------------
	  // Initialize Tick Timer
	  //-----------------------
	  EI_krnl_InitTickTimer();

	  u8_ei_krnl_TickCounter = 0;

	  #ifndef EI_KRNL_TASK_DISPATCHER_IT_USED

	  #if defined(EI_KRNL_ENABLE_FIFO_QUEUE1) || defined(EI_KRNL_ENABLE_FIFO_QUEUE2)
	  u8_ei_krnl_QueueNumber = EI_KRNL_FIFO_QUEUE3;
	  #endif /* EI_KRNL_ENABLE_FIFO_QUEUE1 || EI_KRNL_ENABLE_FIFO_QUEUE2 */


	  #endif /* EI_KRNL_TASK_DISPATCHER_IT_USED */

	  for (ei_krnl_Task_Id = 0; ei_krnl_Task_Id < EI_KRNL_NUMBER_OF_TASK; ei_krnl_Task_Id++)
	  {
	    u8_ei_krnl_TaskPeriodCounter[ei_krnl_Task_Id] = 0;
	  }

	  #ifdef EI_KRNL_ENABLE_FIFO_QUEUE3
	  u8_ei_krnl_FifoQ3In  = EI_KRNL_BUFFER3_LEN - 1;
	  u8_ei_krnl_FifoQ3Out = EI_KRNL_BUFFER3_LEN - 1;
	  #endif /* EI_KRNL_ENABLE_FIFO_QUEUE3 */

	  #ifdef EI_KRNL_ENABLE_FIFO_QUEUE1
	  u8_ei_krnl_FifoQ1In  = EI_KRNL_BUFFER1_LEN - 1;
	  u8_ei_krnl_FifoQ1Out = EI_KRNL_BUFFER1_LEN - 1;
	  #endif /* EI_KRNL_ENABLE_FIFO_QUEUE1 */

      return ei_krnl_Task_Id;

}

/**
  ******************************************************************************
  * @Name : EI_krnl_TaskPeriodMng
  * @Description : Initialize operating system before scheduling
  * @Pre-condition : Must be called with all interrupt disabled
  * @Constraints : none
  ******************************************************************************
*/

 u8 EI_krnl_TaskPeriodMng (u8 ei_krnl_Task_Id)
{
	  if (u8_ei_krnl_TickCounter == EI_KRNL_TICK_DIVIDER)
	  {
	    u8_ei_krnl_TickCounter = 0;

	    EI_krnl_DisableTickEnableAllIsr();

	    //-------------------------------
	    // All Task Period Management
	    //-------------------------------
	    for (ei_krnl_Task_Id = 0; ei_krnl_Task_Id <= (EI_KRNL_NUMBER_OF_TASK - 1); ei_krnl_Task_Id++)
	    {
	      if (u8_ei_krnl_TaskPeriodCounter[ei_krnl_Task_Id] != 0)
	      {
	        u8_ei_krnl_TaskPeriodCounter[ei_krnl_Task_Id]--;

	        if (u8_ei_krnl_TaskPeriodCounter[ei_krnl_Task_Id] == 0)
	        {
	          {
	           #ifdef EI_KRNL_ENABLE_FIFO_QUEUE3
	            #if defined(EI_KRNL_ENABLE_FIFO_QUEUE1) || defined(EI_KRNL_ENABLE_FIFO_QUEUE2)
	            if (u8_ei_krnl_QueueNumberTable[ei_krnl_Task_Id] == EI_KRNL_FIFO_QUEUE3)
	            #endif /* EI_KRNL_ENABLE_FIFO_QUEUE1 || EI_KRNL_ENABLE_FIFO_QUEUE2*/
	            {
	              u8_ei_krnl_FifoQ3In++;
	              if (u8_ei_krnl_FifoQ3In == EI_KRNL_BUFFER3_LEN)
	              {
	                u8_ei_krnl_FifoQ3In = 0;
	              }
	              if (u8_ei_krnl_FifoQ3In == u8_ei_krnl_FifoQ3Out)
	              {
	                /* Last queue full */
	                EI_krnl_DisableAllInterrupts();
	                EI_stsd_Reset();
	              }
	              u8_ei_krnl_Q3Buffer[u8_ei_krnl_FifoQ3In] = ei_krnl_Task_Id;
	            }
	           #endif /* EI_KRNL_ENABLE_FIFO_QUEUE3 */

	           #ifdef EI_KRNL_ENABLE_FIFO_QUEUE1
	            #ifdef EI_KRNL_ENABLE_FIFO_QUEUE3
	            else
	            #endif /* EI_KRNL_ENABLE_FIFO_QUEUE3 */

	            {
	              u8_ei_krnl_FifoQ1In++;
	              if (u8_ei_krnl_FifoQ1In == EI_KRNL_BUFFER1_LEN)
	              {
	                u8_ei_krnl_FifoQ1In = 0;
	              }
	              if (u8_ei_krnl_FifoQ1In == u8_ei_krnl_FifoQ1Out)
	              {
	                /* First queue full */
	                EI_krnl_DisableAllInterrupts();
	                EI_stsd_Reset();
	              }
	              u8_ei_krnl_Q1Buffer[u8_ei_krnl_FifoQ1In] = ei_krnl_Task_Id;
	            }
	           #endif /* EI_KRNL_ENABLE_FIFO_QUEUE1 */

	          }

	          u8_ei_krnl_TaskPeriodCounter[ei_krnl_Task_Id] = u8_ei_krnl_TaskPeriod[ei_krnl_Task_Id];
	        }
	      }
	    }
}
	  return ei_krnl_Task_Id;
}

/**
  ******************************************************************************
  * @Name : EI_krnl_Queue1TaskExecuter
  * @Description : Initialize operating system before scheduling
  * @Pre-condition : Must be called with all interrupt disabled
  * @Constraints : none
  ******************************************************************************
*/

 u8 EI_krnl_Queue1TaskExecuter (u8 ei_krnl_Task_Id)
{
#ifdef EI_KRNL_ENABLE_FIFO_QUEUE1

    if (u8_ei_krnl_QueueNumber < EI_KRNL_FIFO_QUEUE1)
    {
      u8_ei_krnl_QueueNumber = EI_KRNL_FIFO_QUEUE1;

      while (u8_ei_krnl_FifoQ1In != u8_ei_krnl_FifoQ1Out)
      {
        u8_ei_krnl_FifoQ1Out++;
        if (u8_ei_krnl_FifoQ1Out == EI_KRNL_BUFFER1_LEN)
        {
          u8_ei_krnl_FifoQ1Out = 0;
        }

        ei_krnl_Task_Id = u8_ei_krnl_Q1Buffer[u8_ei_krnl_FifoQ1Out];

        EI_krnl_EnableTickInterrupt();

        //--------------------------------
        // Call tasks in queue1
        //--------------------------------
        if (ei_krnl_Task_Id != EI_KRNL_EMPTY_TASK)
        {
          (*(u8_ei_krnl_TasksAddressTable[ei_krnl_Task_Id]))();
        }

        EI_krnl_DisableTickInterrupt();


      }

      u8_ei_krnl_QueueNumber = EI_KRNL_FIFO_QUEUE3;
    }
    return ei_krnl_Task_Id;
    #endif /* EI_KRNL_ENABLE_FIFO_QUEUE1 */


}

/**
  ******************************************************************************
  * @Name : EI_krnl_Queue2TaskExecuter
  * @Description : Initialize operating system before scheduling
  * @Pre-condition : Must be called with all interrupt disabled
  * @Constraints : none
  ******************************************************************************
*/

 u8 EI_krnl_Queue2TaskExecuter (u8 ei_krnl_Task_Id)
{
#ifdef EI_KRNL_ENABLE_FIFO_QUEUE2

   if (u8_ei_krnl_OldQueueNumber < u8_ei_krnl_QueueNumber)
   {
	   u8_ei_krnl_OldQueueNumber = u8_ei_krnl_QueueNumber;
	   u8_ei_krnl_QueueNumber    = EI_KRNL_FIFO_QUEUE2;

     while (u8_ei_krnl_FifoQ2In != u8_ei_krnl_FifoQ2Out)
     {
    	 u8_ei_krnl_FifoQ2Out++;
       if (u8_ei_krnl_FifoQ2Out == EI_KRNL_BUFFER2_LEN)
       {
    	   u8_ei_krnl_FifoQ2Out = 0;
       }

       ei_krnl_Task_Id = u8_ei_krnl_Q2Buffer[u8_ei_krnl_FifoQ2Out];

       //--------------------------------
       // Call tasks in queue2
       //--------------------------------
       if (ei_krnl_Task_Id != EI_KRNL_EMPTY_TASK)
       {
         (*(u8_ei_krnl_TasksAddressTable[ei_krnl_Task_Id]))();
       }

       EI_krnl_DisableTickInterrupt();

     //  STRS_CheckStackOvf();
     }

     u8_ei_krnl_QueueNumber = u8_ei_krnl_OldQueueNumber;
   }
   return ei_krnl_Task_Id;
   #endif /* EI_KRNL_ENABLE_FIFO_QUEUE2 */

   }

/**
  ******************************************************************************
  * @Name : EI_krnl_Queue3TaskExecuter
  * @Description : Initialize operating system before scheduling
  * @Pre-condition : Must be called with all interrupt disabled
  * @Constraints : none
  ******************************************************************************
*/

 u8 EI_krnl_Queue3TaskExecuter (u8 ei_krnl_Task_Id)
{
#ifdef EI_KRNL_ENABLE_FIFO_QUEUE3
    if (u8_ei_krnl_FifoQ3In != u8_ei_krnl_FifoQ3Out)
    {
      u8_ei_krnl_FifoQ3Out++;
      if (u8_ei_krnl_FifoQ3Out == EI_KRNL_BUFFER3_LEN)
      {
        u8_ei_krnl_FifoQ3Out = 0;
      }

      ei_krnl_Task_Id = u8_ei_krnl_Q3Buffer[u8_ei_krnl_FifoQ3Out];


      EI_krnl_EnableTickInterrupt();

      //----------------------------
      //Task execution of Queue 3
      //----------------------------
      if (ei_krnl_Task_Id != EI_KRNL_EMPTY_TASK)
      {
        (*(u8_ei_krnl_TasksAddressTable[ei_krnl_Task_Id]))();
      }

      EI_krnl_DisableTickInterrupt();


    }
    else
    {

      EI_krnl_EnableTickInterrupt();

    }

    return ei_krnl_Task_Id;
    #endif /* EI_KRNL_ENABLE_FIFO_QUEUE3 */

}
/********End*******(ei_krnl.c)****************************************************/
