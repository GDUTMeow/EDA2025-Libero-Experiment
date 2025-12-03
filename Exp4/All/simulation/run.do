quietly set ACTELLIBNAME ProASIC3
quietly set PROJECT_DIR "F:/Git/GDUTMeow/EDA2025-Libero-Experiment/Exp4/All"

if {[file exists postsynth/_info]} {
   echo "INFO: Simulation library postsynth already exists"
} else {
   file delete -force postsynth 
   vlib postsynth
}
vmap postsynth postsynth
vmap proasic3 "C:/Microsemi/Libero_SoC_v11.9/Designer/lib/modelsim/precompiled/vlog/proasic3"

vlog -vlog01compat -work postsynth "${PROJECT_DIR}/synthesis/all.v"
vlog "+incdir+${PROJECT_DIR}/stimulus" -vlog01compat -work postsynth "${PROJECT_DIR}/stimulus/testAll.v"

vsim -L proasic3 -L postsynth  -t 1ps postsynth.testAll
add wave /testAll/*
run 1000ns
