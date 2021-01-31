/**
  ******************************************************************************
  * @file    ei_hsic.h
  * @author  EmbeddedIndustry
  * @version V1.0
  * @date    30-September-2017
  * @brief   This file contains all prototypes for the hardware
  *          specific functionality of OS
  *********************(C) Copyright 2017 EmbeddedIndustry**********************
*/

#ifndef EI_HSIC_H
#define EI_HSIC_H


#include "ei_hsic_cfg.h"



void EI_hsic_ClockSelection(uint8_t ClockSource);

void EI_hsic_ClockInit(void);

void EI_hsic_WatchdogRefresh (void);

void EI_hsic_InternalWdogInit(void);




#endif /* EI_HSIC_H */
