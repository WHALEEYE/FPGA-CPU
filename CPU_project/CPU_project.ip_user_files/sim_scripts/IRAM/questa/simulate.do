onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib IRAM_opt

do {wave.do}

view wave
view structure
view signals

do {IRAM.udo}

run -all

quit -force
