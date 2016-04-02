onerror {resume}
add list -width 13 /test/hsync
add list /test/vsync
add list /test/R
add list /test/G
add list /test/B
configure list -usestrobe 1
configure list -strobestart {0 ps} -strobeperiod {40 ns}
configure list -usesignaltrigger 0
configure list -delta none
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
