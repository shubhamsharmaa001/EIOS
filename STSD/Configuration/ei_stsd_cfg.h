/**
  ******************************************************************************
  * @file    ei_stsd_config.h
  * @author  EmbeddedIndustry
  * @version V1.0
  * @date    30-September-2017
  * @brief   This file contains the OS tasks initialization configuration
  *********************(C) Copyright 2017 EmbeddedIndustry**********************
*/

#ifndef EI_STSD_CONFIG_H
#define EI_STSD_CONFIG_H



/*************Include Files **************************************************/
#include "ei_common.h"

/*************Global Defines **************************************************/

#define STRS_STACK_SIZE      0x100

#define Strs_StackStartAddress (U32)0x0007FF

/* RTOS check if stack goes beyond a determined size. If stack reaches this   */
/* size (STRS_STACK_OVF_RESET_SIZE), system is reseted.                       */

//#define STRS_STACK_OVF_RESET_SIZE   (STRS_STACK_SIZE-32)

/* Define STRS_STACK_PTR_DECREASE if stack pointer decrease when pushing in   */
/* stack. Else define STRS_STACK_PTR_INCREASE.                                */

//#define STRS_STACK_PTR_DECREASE
//#define STRS_STACK_PTR_INCREASE

/*************Global Types ****************************************************/


/************ Global Data *****************************************************/


/*********** Global Macros ****************************************************/


/*********** Global Function Prototypes  **************************************/
extern void EI_stsd_PowerON_Reset(void);
extern void EI_stsd_StartUpHook(void);

#endif /* EI_STSD_CONFIG_H */

/*********** End ****** (ei_stsd_config.h)*************************************/
