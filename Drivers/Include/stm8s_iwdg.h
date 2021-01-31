/**
  ******************************************************************************
  * @file    ei_iwdg.h
  * @author  EmbeddedIndustry.com
  * @version V1.0
  * @date    30-September-2017
  * @brief   This file contains all functions prototype and macros for the
	internal watchdog peripheral
  *********************(C) Copyright 2017 EmbeddedIndustry.com******************
*/

/***********Include Files ****************************************************/

#ifndef EI_IWDG_H
#define EI_IWDG_H

/**
  ***************************************************************************
  * @Name : EI_iwdg_WatchdogRefresh
  * @Description : Refresh internal  watchdog
  ***************************************************************************
*/
void EI_iwdg_WatchdogRefresh(void);
/**
  ******************************************************************************
  * @Name : EI_hsic_InternalWdogInit
  * @Description : Initialize internal watchdog
  ******************************************************************************
*/
void EI_iwdg_InternalWdogInit(void);


#endif

/********End ****** (ei_iwdg.h) ********************************************/
