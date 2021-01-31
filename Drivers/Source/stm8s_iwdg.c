/**
  ******************************************************************************
  * @file    ei_iwdg.c
  * @author  EmbeddedIndustry.com
  * @version V1.0
  * @date    30-September-2017
  * @brief   This file contains all functions prototype and macros for the internal
             watchdog peripheral
  *********************(C) Copyright 2017 EmbeddedIndustry.com**********************
*/

/***********Include Files ****************************************************/

#include "ei_common.h"




/*********** Local Defines ***************************************************/





#define IWDG_KR_KEY_ENABLE              0xCC
#define IWDG_KR_KEY_ACCESS              0x55
#define IWDG_KR_KEY_REFRESH             0xAA


/**
  ***************************************************************************
  * @Name : EI_iwdg_WatchdogRefresh
  * @Description : Refresh internal  watchdog
  * @Behavior :
  *  DO
  *    []
  *  OD
  ***************************************************************************
*/
void EI_iwdg_WatchdogRefresh(void)
{
 // static u8 toggle = 0;
  /* Internal watchdog refresh */
 // EI_WRTBYT(IWDG->KR, IWDG_KR_KEY_REFRESH);


}
/**
  *******************************************************************************
  * @Name : EI_hsic_InternalWdogInit
  * @Description : Initialize internal watchdog
  * @Constraints : -  Do not use RAM, it's not yet initialized
  * @Behavior :
  *  DO
  *    []
  *  OD
  *******************************************************************************
*/
void EI_iwdg_InternalWdogInit(void)
{

}




/********End ****** (ei_iwdg.c) ********************************************/
