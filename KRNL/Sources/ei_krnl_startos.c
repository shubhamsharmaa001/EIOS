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
IMPORT u8 EI_krnl_InitOS (void);
IMPORT u8 EI_krnl_Queue3TaskExecuter (u8 ei_krnl_Task_Id);

/********************Global - Functions****************************************/
/**
  ******************************************************************************
  * @Name : EI_krnl_StartOS
  * @Description : Process Start OS
  * @Interface : OSEK compliant:                                                
  *             AppModeType   Mode    IN    Not used                           
  * @Pre-condition : Call with interrupt disabled
  * @Constraints : none                                                         
  ******************************************************************************
*/

void EI_krnl_StartOS (AppModeType Mode)
{
  u8 ei_krnl_Task_Id;
  
  //--------------------------------------
  // Initialize OS
  //--------------------------------------
  ei_krnl_Task_Id = EI_krnl_InitOS();
  //--------------------------------------
  // Call Startup Hkrnlk
  //--------------------------------------
  EI_stsd_StartupHook();
  //--------------------------------------
  // Start tick timer (With interrupt disabled)
  //--------------------------------------
  EI_krnl_StartTickTimer();
  //--------------------------------------
  // Enable interrupts
  //--------------------------------------
  EI_krnl_EnableAllInterrupts();



  INFINITE_LOOP
  {
	  ei_krnl_Task_Id = EI_krnl_Queue3TaskExecuter (ei_krnl_Task_Id);
  }
}


/********End*******(ei_krnl.c)****************************************************/
