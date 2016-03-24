onerror {resume}
add list -width 17 /quadrati/hsync
add list /quadrati/vsync
add list /quadrati/R
add list /quadrati/G
add list /quadrati/B
configure list -usestrobe 1
configure list -strobestart {0 ps} -strobeperiod {40 ns}
configure list -usesignaltrigger 0
configure list -delta none
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
