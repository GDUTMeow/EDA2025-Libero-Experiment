# Created by Microsemi Libero Software 11.9.0.4
# Wed Dec 03 20:46:21 2025

# (OPEN DESIGN)

open_design "all.adb"

# set default back-annotation base-name
set_defvar "BA_NAME" "all_ba"
set_defvar "IDE_DESIGNERVIEW_NAME" {Impl1}
set_defvar "IDE_DESIGNERVIEW_COUNT" "1"
set_defvar "IDE_DESIGNERVIEW_REV0" {Impl1}
set_defvar "IDE_DESIGNERVIEW_REVNUM0" "1"
set_defvar "IDE_DESIGNERVIEW_ROOTDIR" {F:\Git\GDUTMeow\EDA2025-Libero-Experiment\Exp4\All\designer}
set_defvar "IDE_DESIGNERVIEW_LASTREV" "1"
set_design  -name "all" -family "ProASIC3"
set_device -die {A3P060} -package {100 VQFP} -speed {STD} -voltage {1.5} -IO_DEFT_STD {LVTTL} -RESERVEMIGRATIONPINS {1} -RESTRICTPROBEPINS {1} -RESTRICTSPIPINS {0} -TARGETDEVICESFORMIGRATION {IS2X2M1} -TEMPR {COM} -UNUSED_MSS_IO_RESISTOR_PULL {None} -VCCI_1.5_VOLTR {COM} -VCCI_1.8_VOLTR {COM} -VCCI_2.5_VOLTR {COM} -VCCI_3.3_VOLTR {COM} -VOLTR {COM}



layout -timing_driven
report -type "status" {all_place_and_route_report.txt}
report -type "globalnet" {all_globalnet_report.txt}
report -type "globalusage" {all_globalusage_report.txt}
report -type "iobank" {all_iobank_report.txt}
report -type "pin" -listby "name" {all_report_pin_byname.txt}
report -type "pin" -listby "number" {all_report_pin_bynumber.txt}

save_design
