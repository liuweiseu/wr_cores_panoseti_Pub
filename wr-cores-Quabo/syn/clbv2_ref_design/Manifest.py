target = "xilinx"
action = "synthesis"

syn_device = "xc7k160t"
syn_grade = "-2"
syn_package = "fbg676"

syn_top = "clbv2_wr_ref_top"
syn_project = "clbv2_wr_ref.xise"

syn_tool = "ise"

modules = { "local" : "../../top/clbv2_ref_design/"}
