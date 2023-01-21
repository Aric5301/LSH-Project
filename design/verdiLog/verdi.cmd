simSetSimulator "-vcssv" -exec "simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "simv.daidir"
srcTBInvokeSim
srcHBSelect "hasher_tb.U1" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "kmer" -line 12 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "h1" -line 15 -pos 1 -win $_nTrace1
wvCreateWindow
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
srcDeselectAll -win $_nTrace1
srcSelect -signal "h2" -line 16 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
srcDeselectAll -win $_nTrace1
srcSelect -signal "kmer" -line 12 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
wvSetPosition -win $_nWave3 {("G1" 2)}
wvSetPosition -win $_nWave3 {("G1" 1)}
wvSetPosition -win $_nWave3 {("G1" 0)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("G1" 0)}
wvSetPosition -win $_nWave3 {("G1" 1)}
wvSelectGroup -win $_nWave3 {G2}
srcTBRunSim
verdiDockWidgetMaximize -dock windowDock_nWave_3
verdiDockWidgetRestore -dock windowDock_nWave_3
verdiDockWidgetMaximize -dock windowDock_nWave_3
verdiDockWidgetRestore -dock windowDock_nWave_3
verdiDockWidgetMaximize -dock windowDock_nWave_3
wvSelectSignal -win $_nWave3 {( "G1" 3 )} 
wvSelectSignal -win $_nWave3 {( "G1" 3 )} 
wvSetPosition -win $_nWave3 {("G1" 3)}
wvExpandBus -win $_nWave3
debExit
