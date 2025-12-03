onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testdecoder2x4/pa
add wave -noupdate /testdecoder2x4/pb
add wave -noupdate /testdecoder2x4/pen
add wave -noupdate -radix binary -expand /testdecoder2x4/py
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {24604 ps} 0}
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
WaveRestoreZoom {0 ps} {64512 ps}
