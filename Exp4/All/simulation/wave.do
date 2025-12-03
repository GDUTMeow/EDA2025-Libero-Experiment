onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testAll/a
add wave -noupdate /testAll/b
add wave -noupdate /testAll/c
add wave -noupdate /testAll/y
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {999164 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {999050 ps} {1000050 ps}
