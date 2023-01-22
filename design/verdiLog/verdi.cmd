simSetSimulator "-vcssv" -exec "simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "simv.daidir"
srcTBInvokeSim
srcDeselectAll -win $_nTrace1
srcSelect -signal "hashing_is_done" -line 24 -pos 1 -win $_nTrace1
wvCreateWindow
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
srcDeselectAll -win $_nTrace1
srcSelect -signal "calculate_matched_window" -line 25 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
srcDeselectAll -win $_nTrace1
srcSelect -signal "reset_stats" -line 26 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
srcDeselectAll -win $_nTrace1
srcSelect -signal "clk" -line 27 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
srcDeselectAll -win $_nTrace1
srcSelect -signal "reset_hash_table" -line 28 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
srcDeselectAll -win $_nTrace1
srcSelect -signal "window" -line 29 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
srcDeselectAll -win $_nTrace1
srcSelect -signal "window_id" -line 30 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
srcDeselectAll -win $_nTrace1
srcSelect -signal "ready_for_hashing" -line 31 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
srcDeselectAll -win $_nTrace1
srcSelect -signal "reset_window_hasher" -line 32 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
srcDeselectAll -win $_nTrace1
srcSelect -signal "reset_window_hasher" -line 32 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
wvSelectSignal -win $_nWave3 {( "G1" 10 )} 
wvCut -win $_nWave3
wvSetPosition -win $_nWave3 {("G2" 0)}
wvSetPosition -win $_nWave3 {("G1" 9)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "is_insert" -line 33 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
srcDeselectAll -win $_nTrace1
srcSelect -signal "is_query" -line 34 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
srcDeselectAll -win $_nTrace1
srcSelect -signal "matched_window_id" -line 35 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
srcDeselectAll -win $_nTrace1
srcSelect -signal "hashed_sketch" -line 38 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
srcDeselectAll -win $_nTrace1
srcSelect -signal "count_bus" -line 39 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
srcHBSelect "main.hash_table_inst" -win $_nTrace1
srcSetScope "main.hash_table_inst" -delim "." -win $_nTrace1
srcHBSelect "main.hash_table_inst" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "theTable" -line 25 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
srcDeselectAll -win $_nTrace1
srcSelect -signal "tableLength" -line 26 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
verdiDockWidgetMaximize -dock windowDock_nWave_3
srcTBRunSim
wvSetCursor -win $_nWave3 3780.453103
wvSelectSignal -win $_nWave3 {( "G1" 15 )} 
wvSelectSignal -win $_nWave3 {( "G1" 16 )} 
wvExpandBus -win $_nWave3
wvScrollUp -win $_nWave3 240
wvScrollDown -win $_nWave3 172
wvScrollUp -win $_nWave3 16
wvScrollUp -win $_nWave3 156
wvSelectSignal -win $_nWave3 {( "G1" 16 )} 
wvSelectSignal -win $_nWave3 {( "G1" 15 )} 
wvSelectSignal -win $_nWave3 {( "G1" 16 )} 
wvSetPosition -win $_nWave3 {("G1" 16)}
wvCollapseBus -win $_nWave3
wvSetPosition -win $_nWave3 {("G1" 16)}
wvSelectSignal -win $_nWave3 {( "G1" 15 )} 
wvSetPosition -win $_nWave3 {("G1" 15)}
wvExpandBus -win $_nWave3
wvSetPosition -win $_nWave3 {("G1" 272)}
wvScrollUp -win $_nWave3 21
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 31
wvScrollUp -win $_nWave3 175
wvScrollDown -win $_nWave3 173
wvScrollDown -win $_nWave3 64
verdiDockWidgetRestore -dock windowDock_nWave_3
verdiDockWidgetSetCurTab -dock windowDock_InteractiveConsole_2
srcTBSimReset
srcTBRunSim
srcDeselectAll -win $_nTrace1
debExit
