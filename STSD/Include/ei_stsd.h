/**
  ******************************************************************************
  * @file    stsd.h
  * @author  EmbeddedIndustry
  * @version V1.0
  * @date    30-September-2017
  * @brief   This file contains the OS start ,shutdown API PROTOTYPE
  *********************(C) Copyright 2017 EmbeddedIndustry**********************
*/

#ifndef STSD_H
#define STSD_H

/****************Include Files ***********************************************/

#include "../Configuration/ei_stsd_cfg.h"
#include "ei_common.h"
#include "ei_krnl.h"
/***************Global Defines ***********************************************/




/*********Global Types ********************************************************/


/******** Global Data *********************************************************/


/******** Global Macros *******************************************************/



#define EI_stsd_InitCheckStackOvf()
#define EI_stsd_CheckStackOvf()




/************* Global Function Prototypes *************************************/
/**
  ******************************************************************************
  * @Name : EI_stsd_Reset                                                          
  * @Description : Reset micro controller                                                                                                       
  * @Constraints : This is the function called by application modules           
  * requesting a system reset                                                  
  * @Behavior :                                                                 
  *  DO                                                                        
  *         [reset micro ]                                                    
  *  OD                                                                        
  ******************************************************************************
*/
 extern void EI_stsd_Reset(void);
/**
  ******************************************************************************
  * @Name : EI_stsd_BootMicro                                                  
  * @Description : application entry point                                            
  * @Constraints : This is the function called by Boot Code to start application 
  *               use boot stack                                               
  * @Behavior :                                                                
  *  DO                                                                        
  *     [if Boot application, Call application main because                    
  *      start-up initialization already done in boot]                         
  *  OD                                                                        
  ******************************************************************************
*/
void EI_stsd_BootMicro(void);
/**
  *****************************************************************************
  * @Name : EI_stsd_main                                                           
  * @Description : Start operating system to start application                         
  * @Behavior :                                                                
  *  DO                                                                        
  *     [StartOS]                                                              
  *     [loop infinite]                                                        
  *  OD                                                                        
  ******************************************************************************
*/
extern void EI_stsd_main(void);
/**
  ******************************************************************************
  * @Name : EI_stsd_StartupHook                                                         
  * @Description : Start Up application                                                                                                      
  * @Constraints : hook service called by Init OSEK OS                          
  * @Behavior :                                                                
  *  DO                                                                        
  *     [Get Ram Boot Key]                                                     
  *     [Call StartUpHook_Client]                                              
  *  OD                                                                        
  ******************************************************************************
*/
extern void EI_stsd_StartupHook(void);
/**
  ******************************************************************************
  * @Name : EI_stsd_ShutdownHook                                                        
  * @Description : shut down OS                                                       
  * @Constraints : hook service called by OSEK OS                               
  * @Behaviour :                                                                
  *  DO                                                                        
  *     [ ]                                                                    
  *  OD                                                                        
  ******************************************************************************
*/
extern void EI_stsd_ShutdownHook(StatusType error);


#endif /* STSD_H */

/******** End **********(stsd.h) ***********************************************/
