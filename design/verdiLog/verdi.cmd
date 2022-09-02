simSetSimulator "-vcssv" -exec "simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "simv.daidir"
srcTBInvokeSim
srcHBSelect "test_tb" -win $_nTrace1
wvCreateWindow
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave3
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock windowDock_InteractiveConsole_2
verdiDockWidgetSetCurTab -dock windowDock_OneSearch
verdiDockWidgetSetCurTab -dock widgetDock_<Message>
verdiDockWidgetSetCurTab -dock windowDock_nWave_3
srcTBRunSim -opt {50.00s}
srcTBRunSim -opt {50.00s}
srcTBSimReset
srcTBRunSim -opt {50.00s}
srcTBRunSim -opt {50.00s}
srcDeselectAll -win $_nTrace1
srcSelect -signal "a" -line 18 -pos 1 -win $_nTrace1
srcAction -pos 17 1 0 -win $_nTrace1 -name "a" -ctrlKey off
srcDeselectAll -win $_nTrace1
srcSelect -signal "a" -line 18 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
verdiDockWidgetSetCurTab -dock widgetDock_<Class._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Object._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Class._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Object._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Stack>
srcDeselectAll -win $_nTrace1
srcTBSimReset
wvTpfCloseForm -win $_nWave3
wvGetSignalClose -win $_nWave3
wvCloseWindow -win $_nWave3
srcTBRunSim
srcTBAddBrkPnt -abs 5s
srcTBDelAllBrkPnt
