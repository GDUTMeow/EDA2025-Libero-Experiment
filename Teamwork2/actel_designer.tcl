
layout -timing_driven
report -type "status" {top_module_place_and_route_report.txt}
report -type "globalnet" {top_module_globalnet_report.txt}
report -type "globalusage" {top_module_globalusage_report.txt}
report -type "iobank" {top_module_iobank_report.txt}
report -type "pin" -listby "name" {top_module_report_pin_byname.txt}
report -type "pin" -listby "number" {top_module_report_pin_bynumber.txt}

save_design

