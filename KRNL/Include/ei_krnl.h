/**
  ******************************************************************************
  * @file    ei_krnl.h
  * @author  EmbeddedIndustry
  * @version V1.0
  * @date    30-September-2017
  * @brief   This file contains the OSEK(BCC1) OS function prototypes
  *********************(C) Copyright 2017 EmbeddedIndustry**********************
*/

#ifndef EI_KRNL_H
#define EI_KRNL_H


/*************** Include Files ***********************************************/

#include "ei_krnl_cfg.h"
#include "ei_common.h"



/*************** Global Defines *********************************************/

/* Osek Services StatusType compliant return code */
#define E_OK     0    /* Function OK */


/*************** Global Types ***********************************************/

/* Osek Services compliant return type */
typedef u8 StatusType;

/* Osek Services compliant Application mode type */
typedef u8 AppModeType;


/********Global Data**********************************************************/

/********Global Macros********************************************************/

/******************************************************************************/
/*                         OSEK standard macro                                */
/******************************************************************************/
/**
  ******************************************************************************
  * @Name : EI_krnl_DisableAllInterrupts
  * @Description : Disable all maskable interrupts of the system                       
  * @Interface : OSEK compliant                                                 
  * @Pre-condition : none                                                       
  * @Constraints : - Do not call this service in an interrupt function          
  *               - DisableAllInterrupts() and EnableAllInterrupts() must be   
  *                 in the same block {}.                                      
  *                 If not in the same block use Poly_DisableAllInterrupts()   
  *                 and Poly_EnableAllInterrupts() instead.                    
  *****************************************************************************
*/

#define EI_krnl_DisableAllInterrupts() disableInterrupts()

/**
  ******************************************************************************
  * @Name : EI_krnl_EnableAllInterrupts
  * @Description : Enable all maskable interrupts of the system                        
  * @Interface : OSEK compliant                                                 
  * @Pre-condition : none                                                       
  * @Constraints : - Do not call this service in an interrupt function          
  *               - DisableAllInterrupts() and EnableAllInterrupts() must be   
  *                 in the same block {}.                                      
  *                 If not in the same block use Poly_DisableAllInterrupts()   
  *                 and Poly_EnableAllInterrupts() instead.                    
  ******************************************************************************
*/

#define EI_krnl_EnableAllInterrupts() enableInterrupts()

/**
  *****************************************************************************
  * @Name : TASK                                                                
  * @Description : Task declaration macro                                              
  * @Interface : OSEK compliant                                                 
  * @Pre-condition : none                                                       
  * @Constraints : Must be used to declare a task to be managed by os         
  ******************************************************************************
*/
#define TASK(x) void (x)(void)
/**
  ******************************************************************************
  * @Name : TerminateTask                                                       
  * @Description : Leave a task and return at OS level                                 
  * @Interface : OSEK compliant                                                 
  * @Pre-condition : none                                                       
  * @Constraints : Must be the last action of a task                            
  ******************************************************************************
*/
#define TerminateTask() {}
/**
  ******************************************************************************
  * @Name : ISR                                                                 
  * @Description : Interrupt service routine declaration macro                         
  * @Interface : OSEK compliant                                                 
  * @Pre-condition : none                                                       
  * @Constraints : Must be used to declare all user ISR                         
  ******************************************************************************
*/
#define ISR(x) @far @interrupt  void x(void)

/***********Global Function Prototypes*****************************************/

/******************************************************************************/
/*                         OSEK standard services                             */
/******************************************************************************/
/**
  ******************************************************************************
  * @Name : EI_krnl_StartOS
  * @Description : start OS Activity                                                   
  * @Interface : OSEK compliant:                                                
  *             AppModeType   Mode    IN    Not used                           
  * @Pre-condition : Must be called with all interrupt disabled                 
  * @Constraints : none                                                         
  ******************************************************************************
*/
extern void EI_krnl_StartOS(AppModeType Mode);
/**
  ******************************************************************************
  * @Name : EI_krnl_ShutdownOS
  * @Description : Shutdown OS Activity                                                
  * @Interface : OSEK compliant:                                                
  *             StatusType   Error    IN    Shutddown reason
  * @Pre-condition : none                                                       
  * @Constraints : none                                                         
  *****************************************************************************
*/
#ifdef EI_KRNL_ENABLE_SHUTDOWN
extern void EI_krnl_ShutdownOS(StatusType Error);
#else
#define EI_krnl_ShutdownOS(StatusType) ShutdownOS(StatusType){}
#endif /* EI_KRNL_ENABLE_SHUTDOWN */
/**
  ******************************************************************************
  * @Name : EI_krnl_SetRelAlarm
  * @Description : Set alarm timing for Task activation                                
  * @Interface : OSEK compliant:                                               
  *             u8  TaskNumber    IN    Alarm number (= Task number)          
  *             u8  FirstDelay    IN    First delay before first activation    
  *             u8  Period        IN    Activation cycle time                  
  * @Pre-condition : none                                                       
  * @Constraints : Do not call this function in an interrupt function           
  *               FirstDelay must be != 0                                      
  *****************************************************************************
*/
extern StatusType EI_krnl_SetRelAlarm(u8 TaskNumber,u8 FirstDelay,u8 Period);
/**
  ******************************************************************************
  * @Name : EI_krnl_CancelAlarm
  * @Description : Stop alarm (and Task activation)                                   
  * @Interface : OSEK compliant:                                                
  *             u8  TaskNumber    IN    Alarm number (= Task number)       
  * @Pre-condition : none                                                       
  * @Constraints : Do not call this function in an interrupt function           
  ******************************************************************************
*/
#ifdef EI_KRNL_CANCEL_ALARM_USED
extern StatusType EI_krnl_CancelAlarm(u8 TaskNumber);
#else
#define EI_krnl_CancelAlarm(TaskNumber)  (StatusType)(0) /* os_OK */
#endif /* EI_KRNL_CANCEL_ALARM_USED */


/******************************************************************************/
/*                         Specific os services                               */
/******************************************************************************/
/**
  ******************************************************************************
  * @Name : EI_krnl_Tick_Run
  * @Description : Restart OS tick management                                          
  * @Interface : void                                                           
  * @Pre-condition : none                                                       
  * @Constraints : none                                                         
  ******************************************************************************
*/
extern void EI_krnl_Tick_Run (void);
/**
  *****************************************************************************
  * @Name : EI_os_Tick_Run
  * @Description : Stop OS tick management                                             
  * @Interface : void                                                           
  * @Pre-condition : none                                                       
  * @Constraints : none                                                         
  *****************************************************************************
*/
extern void EI_krnl_Tick_Stop (void);
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
extern ISR(EI_krnl_Tick_it);

#endif   /* EI_KRNL_H */
