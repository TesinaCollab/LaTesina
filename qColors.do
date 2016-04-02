onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /quadrati/vsync
add wave -noupdate /quadrati/hsync
add wave -noupdate -color Red /quadrati/R
add wave -noupdate /quadrati/G
add wave -noupdate -color Blue /quadrati/B
add wave -noupdate -color Gold /quadrati/disp_enable
add wave -noupdate /quadrati/Ypix
add wave -noupdate /quadrati/Xpix
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {201279340000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 168
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 1
configure wave -timelineunits ms
update
WaveRestoreZoom {194662371250 ps} {207896308750 ps}
