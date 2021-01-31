/**
  ******************************************************************************
  * @file    ei_clk.h
  * @author  EmbeddedIndustry.com
  * @version V1.0
  * @date    30-September-2017
  * @brief   This file contains all functions prototype and macros for the clock
						 peripheral
  *********************(C) Copyright 2017 EmbeddedIndustry.com******************
*/
#ifndef EI_CLK_H
#define EI_CLK_H
/**
  ******************************************************************************
  * @Name : EI_clk_InitializeClock
  * @Description : Initialize clock
  *******************************************************************************
*/
void EI_clk_InitializeClock(void);


/**
  ******************************************************************************
  * @Name : EI_clk_SelectClock
  * @Description : Change to external clock source
  ******************************************************************************
*/
void EI_clk_SelectClock(uint8_t ClockSource);



#endif
