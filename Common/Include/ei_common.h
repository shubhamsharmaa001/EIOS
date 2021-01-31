/**
  ******************************************************************************
  * @file    common.h
  * @author  EmbeddedIndustry
  * @version V1.0
  * @date    30-September-2017
  * @brief   This file contains common macros used in the project
  *********************(C) Copyright 2017 EmbeddedIndustry**********************
*/

#ifndef COMMON_H
#define COMMON_H

/********Include Files*****************************************************/

#include "stm8s.h"
//#include "stm8s_tim2.h"


/************Global Macros**************************************************/

#define IMPORT                  extern
#define INFINITE_LOOP           for(;;)
/**
  ***************************************************************************
  * @Name     : EI_WRTBYT
  * @Role      : Assign an U8 value to an 8-bits register                             
  * @Interface :                                                                 
  * - Reg   IN, register name [use names define in rgxx_xxx.h]                
  * - Value IN, register value                                                
  * @Behavior  :                                                                  
  *           DO                                                                        
  *              [assign the value to the requested register]                            
  *           OD                                                                        
  ****************************************************************************
*/
#define EI_WRTBYT(Reg,Value) \
Reg = Value
/**
  ****************************************************************************
  * @Name      : EI_WRTSHRT
  * @Role      : Assign a ushort value to an 16-bits register                         
  * @Interface :                                                                 
  * - Reg   IN, register name [use names define in rgxx_xxx.h]                
  * - Value IN, register value                                                                                                           
  * @Behavior  :                                                                  
  *  DO                                                                        
  *    [assign the value to the requested register]                            
  *  OD                                                                        
  ****************************************************************************
*/
#define EI_WRTSHRT(Reg,Value) \
Reg = Value
/**
  ****************************************************************************
  * @Name        : EI_WRTWRD
  * @Description : Assign a ushort value to an 32-bits register                         
  * @Interface   :                                                                 
  *  - Reg   IN, register name [use names define in rgxx_xxx.h]                
  *  - Value IN, register value                                                                                                            
  * @Behavior    :                                                                  
  *  DO                                                                        
  *    [assign the value to the requested register]                            
  *  OD                                                                        
  ****************************************************************************
*/
#define EI_WRTWRD(Reg,Value) \
Reg = Value
/**
  ****************************************************************************
  * @Name        : EI_READBIT
  * @Description : Read a bit state                                                     
  * @Interface   :                                                                 
  *  - Reg    IN, register name [use names define in rgxx_xxx.h]               
  *  - Bit    IN, bit name [BIT0,BIT1,BIT2,BIT3,BIT4,BIT5,BIT6,BIT7]           
  *                        if registers are 8bit   OR                          
  *  - Bit    IN, bit name [BIT0,BIT1,BIT2,...,BIT28,BIT29,BIT30,BIT31]        
  *                        if registers are 32bit                              
  *  - Value OUT, bit value                                                    
  * @Behavior    :                                                                  
  *  DO                                                                        
  *    [return the state of the requested bit]                                 
  *  OD                                                                        
  *****************************************************************************
*/
#define EI_READBIT(Reg,Bit) \
(Reg & Bit)
/**
  *****************************************************************************
  * @Name        : EI_READBYT
  * @Description : Read the state of an 8-bits register                                        
  * @Interface   : 
  *  - Reg    IN, register name [use names define in rgh8_xxx.h]               
  *  - Value  IN, register                                                     
  *  - Value OUT, register U8 value                                            
  * @Behavior    :                                                                  
  *  DO                                                                        
  *    [read the state of the requested register]                              
  *  OD                                                                        
  *****************************************************************************
*/
#define EI_READBYT(Reg) \
Reg
/**
  ****************************************************************************
  * @Name      : EI_READSHRT
  * @Description     : Read the state of an 16-bits register                                
  * @Interface :                                                                 
  *  - Reg    IN, register name [use names define in rgh8_xxx.h]               
  *  - Value  IN, register                                                     
  *  - Value OUT, register ushort value                                                                                                     
  * @Behavior  :                                                                  
  *  DO                                                                        
  *    [read the state of the requested register]                              
  *  OD                                                                        
  *****************************************************************************
*/

#define EI_READSHRT(Reg) \
Reg
/**
 *******************************************************************************
 * @Name      : EI_READWRD
 * @Interface :                                                                 
 *  - Reg    IN, register name [use names define in rgh8_xxx.h]               
 *  - Value  IN, register                                                     
 *  - Value OUT, register ushort value                                                                                                    
 * @Behavior  :                                                                  
 *  DO                                                                        
 *    [read the state of the requested register]                              
 *  OD                                                                        
 ******************************************************************************
*/
#define EI_READWRD(Reg) \
Reg
/**
  ***************************************************************************
  * @Name : EI_SETBIT
  * @Description: Set some bits into a register                                        
  * @Interface  :                                                                 
  *  - Reg   IN, register name [use names define in rgxx_xxx.h]                
  *  - Mask  IN, bit name [MSK_xxx with xxx = bit name, or a logical operation]
  *                        with several MSK_xxx bits]                          
  *                        bit name are define in rgh8_xxx.h files                                                                        
  * @Constraints : - Mask must be accordling with register use                   
  *                 8bit                                                       
  * @Behavior   :                                                                  
  *  DO                                                                        
  *    [Set the requested bits]                                                
  *  OD                                                                        
  ***************************************************************************
*/
#define EI_SETBIT(Reg,Mask) \
  EI_WRTBYT(Reg, (u8)(EI_READBYT(Reg) | (Mask)))
/**
  ***************************************************************************
  * @Name : CLRBIT
  * @Description: Clear some bits into a register                                      
  * @Interface :                                                                 
  *  - Reg   IN, register name [use names define in rgh8_xxx.h]                
  *  - Mask  IN, bit name [MSK_xxx with xxx = bit name, or a logical operation]
  *                        with several MSK_xxx bits]                          
  *                        bit name are define in rgh8_xxx.h files                                                                        
  * @Behavior :                                                                  
  *  DO                                                                        
  *    [Clear the requested bits]                                              
  *  OD                                                                        
  ***************************************************************************
*/
#define EI_CLRBIT(Reg,Mask) \
   EI_WRTBYT(Reg, (u8)(EI_READBYT(Reg) & ~(Mask)))


#endif /* common_H */

/*******End*******(common.h)*************************************************/
