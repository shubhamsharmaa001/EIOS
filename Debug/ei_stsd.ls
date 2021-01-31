   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  44                     ; 30 void EI_stsd_BootMicro(void)
  44                     ; 31 {
  46                     	switch	.text
  47  0000               _EI_stsd_BootMicro:
  51                     ; 33   EI_clk_InitializeClock();
  53  0000 cd0000        	call	_EI_clk_InitializeClock
  55                     ; 35   EI_iwdg_InternalWdogInit();
  57  0003 cd0000        	call	_EI_iwdg_InternalWdogInit
  59                     ; 37 }
  62  0006 81            	ret
  91                     ; 46 void EI_stsd_StartupHook(void)
  91                     ; 47 {
  92                     	switch	.text
  93  0007               _EI_stsd_StartupHook:
  97                     ; 51   EI_iwdg_WatchdogRefresh(); /* launched at PowerON_Reset */
  99  0007 cd0000        	call	_EI_iwdg_WatchdogRefresh
 101                     ; 61   EI_iwdg_WatchdogRefresh(); 
 103  000a cd0000        	call	_EI_iwdg_WatchdogRefresh
 105                     ; 65   EI_TASK1_Init();
 107  000d cd0000        	call	_EI_TASK1_Init
 109                     ; 67   EI_TASK2_Init();
 111  0010 cd0000        	call	_EI_TASK2_Init
 113                     ; 72   EI_iwdg_WatchdogRefresh();
 115  0013 cd0000        	call	_EI_iwdg_WatchdogRefresh
 117                     ; 76   EI_TASK1_WakeUp();
 119  0016 cd0000        	call	_EI_TASK1_WakeUp
 121                     ; 79   EI_TASK2_WakeUp();
 123  0019 cd0000        	call	_EI_TASK2_WakeUp
 125                     ; 85   EI_iwdg_WatchdogRefresh();
 127  001c cd0000        	call	_EI_iwdg_WatchdogRefresh
 129                     ; 86 }
 132  001f 81            	ret
 167                     ; 96 void EI_stsd_ShutdownHook(StatusType error)
 167                     ; 97 {
 168                     	switch	.text
 169  0020               _EI_stsd_ShutdownHook:
 173                     ; 99 }
 176  0020 81            	ret
 202                     ; 108 void EI_stsd_Start(void)
 202                     ; 109 {
 203                     	switch	.text
 204  0021               _EI_stsd_Start:
 208                     ; 111 	EI_clk_SelectClock(/*stsd_CLK_SOURCE*/0xB4);
 210  0021 a6b4          	ld	a,#180
 211  0023 cd0000        	call	_EI_clk_SelectClock
 213                     ; 112   EI_iwdg_WatchdogRefresh();
 215  0026 cd0000        	call	_EI_iwdg_WatchdogRefresh
 217                     ; 114   EI_krnl_StartOS(0);
 219  0029 4f            	clr	a
 220  002a cd0000        	call	_EI_krnl_StartOS
 222                     ; 116 }
 225  002d 81            	ret
 248                     ; 124 void EI_stsd_Reset(void)
 248                     ; 125 {
 249                     	switch	.text
 250  002e               _EI_stsd_Reset:
 254                     ; 126 }
 257  002e 81            	ret
 270                     	xdef	_EI_stsd_Start
 271                     	xref	_EI_TASK2_Init
 272                     	xref	_EI_TASK2_WakeUp
 273                     	xref	_EI_TASK1_Init
 274                     	xref	_EI_TASK1_WakeUp
 275                     	xdef	_EI_stsd_ShutdownHook
 276                     	xdef	_EI_stsd_StartupHook
 277                     	xdef	_EI_stsd_BootMicro
 278                     	xdef	_EI_stsd_Reset
 279                     	xref	_EI_krnl_StartOS
 280                     	xref	_EI_iwdg_InternalWdogInit
 281                     	xref	_EI_iwdg_WatchdogRefresh
 282                     	xref	_EI_clk_SelectClock
 283                     	xref	_EI_clk_InitializeClock
 302                     	end
