simSetSimulator "-vcssv" -exec "simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "simv.daidir"
srcTBInvokeSim
srcHBSelect "window_hasher_tb.U1" -win $_nTrace1
srcHBSelect "window_hasher_tb.U1" -win $_nTrace1
srcHBSelect "window_hasher_tb.U1" -win $_nTrace1
wvCreateWindow
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave3
verdiDockWidgetMaximize -dock windowDock_nWave_3
srcTBRunSim
debExit
