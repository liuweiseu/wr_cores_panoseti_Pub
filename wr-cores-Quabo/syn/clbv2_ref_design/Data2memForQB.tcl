# 
# Project automation script for clbv2_wr_ref 
# 
# Created for ISE version 14.7
# 
# This file contains several Tcl procedures (procs) that you can use to automate
# your project by running from xtclsh or the Project Navigator Tcl console.
# If you load this file (using the Tcl command: source /media/wei/DATA/LW/Project/WR_Project/WR_Reference_Design/wr-cores-acme1/wr-cores/syn/clbv2_ref_design/Data2memForQB.tcl), then you can
# run any of the procs included here.
# 
# This script is generated assuming your project has HDL sources.
# Several of the defined procs won't apply to an EDIF or NGC based project.
# If that is the case, simply remove them from this script.
# 
# You may also edit any of these procs to customize them. See comments in each
# proc for more instructions.
# 
# This file contains the following procedures:
# 
# Top Level procs (meant to be called directly by the user):
#    run_process: you can use this top-level procedure to run any processes
#        that you choose to by adding and removing comments, or by
#        adding new entries.
#    rebuild_project: you can alternatively use this top-level procedure
#        to recreate your entire project, and the run selected processes.
# 
# Lower Level (helper) procs (called under in various cases by the top level procs):
#    show_help: print some basic information describing how this script works
#    add_source_files: adds the listed source files to your project.
#    set_project_props: sets the project properties that were in effect when this
#        script was generated.
#    create_libraries: creates and adds file to VHDL libraries that were defined when
#        this script was generated.
#    set_process_props: set the process properties as they were set for your project
#        when this script was generated.
# 

set myProject "clbv2_wr_ref"
set myScript "/media/wei/DATA/LW/Project/WR_Project/WR_Reference_Design/wr-cores-acme1/wr-cores/syn/clbv2_ref_design/Data2memForQB.tcl"

# 
# Main (top-level) routines
# 
# run_process
# This procedure is used to run processes on an existing project. You may comment or
# uncomment lines to control which processes are run. This routine is set up to run
# the Implement Design and Generate Programming File processes by default. This proc
# also sets process properties as specified in the "set_process_props" proc. Only
# those properties which have values different from their current settings in the project
# file will be modified in the project.
# 
proc run_process {} {

   global myScript
   global myProject

   ## put out a 'heartbeat' - so we know something's happening.
   puts "\n$myScript: running ($myProject)...\n"

   if { ! [ open_project ] } {
      return false
   }

   set_process_props
   #
   # Remove the comment characters (#'s) to enable the following commands 
   # process run "Synthesize"
   # process run "Translate"
   # process run "Map"
   # process run "Place & Route"
   #
   set task "Implement Design"
   if { ! [run_task $task] } {
      puts "$myScript: $task run failed, check run output for details."
      project close
      return
   }

   set task "Generate Programming File"
   if { ! [run_task $task] } {
      puts "$myScript: $task run failed, check run output for details."
      project close
      return
   }

   puts "Run completed (successfully)."
   project close

}

# 
# rebuild_project
# 
# This procedure renames the project file (if it exists) and recreates the project.
# It then sets project properties and adds project sources as specified by the
# set_project_props and add_source_files support procs. It recreates VHDL Libraries
# as they existed at the time this script was generated.
# 
# It then calls run_process to set process properties and run selected processes.
# 
proc rebuild_project {} {

   global myScript
   global myProject

   project close
   ## put out a 'heartbeat' - so we know something's happening.
   puts "\n$myScript: Rebuilding ($myProject)...\n"

   set proj_exts [ list ise xise gise ]
   foreach ext $proj_exts {
      set proj_name "${myProject}.$ext"
      if { [ file exists $proj_name ] } { 
         file delete $proj_name
      }
   }

   project new $myProject
   set_project_props
   add_source_files
   create_libraries
   puts "$myScript: project rebuild completed."

   run_process

}

# 
# Support Routines
# 

# 
proc run_task { task } {

   # helper proc for run_process

   puts "Running '$task'"
   set result [ process run "$task" ]
   #
   # check process status (and result)
   set status [ process get $task status ]
   if { ( ( $status != "up_to_date" ) && \
            ( $status != "warnings" ) ) || \
         ! $result } {
      return false
   }
   return true
}

# 
# show_help: print information to help users understand the options available when
#            running this script.
# 
proc show_help {} {

   global myScript

   puts ""
   puts "usage: xtclsh $myScript <options>"
   puts "       or you can run xtclsh and then enter 'source $myScript'."
   puts ""
   puts "options:"
   puts "   run_process       - set properties and run processes."
   puts "   rebuild_project   - rebuild the project from scratch and run processes."
   puts "   set_project_props - set project properties (device, speed, etc.)"
   puts "   add_source_files  - add source files"
   puts "   create_libraries  - create vhdl libraries"
   puts "   set_process_props - set process property values"
   puts "   show_help         - print this message"
   puts ""
}

proc open_project {} {

   global myScript
   global myProject

   if { ! [ file exists ${myProject}.xise ] } { 
      ## project file isn't there, rebuild it.
      puts "Project $myProject not found. Use project_rebuild to recreate it."
      return false
   }

   project open $myProject

   return true

}
# 
# set_project_props
# 
# This procedure sets the project properties as they were set in the project
# at the time this script was generated.
# 
proc set_project_props {} {

   global myScript

   if { ! [ open_project ] } {
      return false
   }

   puts "$myScript: Setting project properties..."

   project set family "Kintex7"
   project set device "xc7k160t"
   project set package "fbg676"
   project set speed "-1"
   project set top_level_module_type "HDL"
   project set synthesis_tool "XST (VHDL/Verilog)"
   project set simulator "ISim (VHDL/Verilog)"
   project set "Preferred Language" "Verilog"
   project set "Enable Message Filtering" "false"

}


# 
# add_source_files
# 
# This procedure add the source files that were known to the project at the
# time this script was generated.
# 
proc add_source_files {} {

   global myScript

   if { ! [ open_project ] } {
      return false
   }

   puts "$myScript: Adding sources to project..."

   xfile add "../../board/clbv2/wr_clbv2_pkg.vhd"
   xfile add "../../board/clbv2/wrc_board_clbv2.vhd"
   xfile add "../../board/clbv2/xwrc_board_clbv2.vhd"
   xfile add "../../board/common/wr_board_pkg.vhd"
   xfile add "../../board/common/xwrc_board_common.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_master_core/eb_commit_len_fifo.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_master_core/eb_framer.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_master_core/eb_master_eth_tx.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_master_core/eb_master_slave_wrapper.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_master_core/eb_master_top.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_master_core/eb_master_wb_if.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_master_core/eb_record_gen.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_cfg_fifo.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_checksum.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_commit_fifo.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_eth_rx.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_eth_tx.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_ethernet_slave.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_fifo.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_hdr_pkg.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_internals_pkg.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_pass_fifo.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_raw_slave.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_slave_core.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_slave_fsm.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_slave_top.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_stream_narrow.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_stream_widen.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_tag_fifo.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_tx_mux.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/eb_wbm_fifo.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_slave_core/etherbone_pkg.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_usb_core/ez_usb.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_usb_core/ez_usb_fifos.vhd"
   xfile add "../../ip_cores/etherbone-core/hdl/eb_usb_core/ez_usb_pkg.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_arbitrated_mux.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_async_signals_input_stage.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_bicolor_led_ctrl.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_big_adder.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_crc_gen.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_dec_8b10b.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_delay_gen.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_delay_line.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_dual_pi_controller.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_dyn_glitch_filt.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_extend_pulse.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_frequency_meter.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_fsm_watchdog.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_glitch_filt.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_i2c_slave.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_moving_average.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_prio_encoder.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_pulse_synchronizer.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_pulse_synchronizer2.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_reset.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_rr_arbiter.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_serial_dac.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_single_reset_gen.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_sync_ffs.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_sync_register.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gc_word_packer.vhd"
   xfile add "../../ip_cores/general-cores/modules/common/gencores_pkg.vhd"
   xfile add "../../ip_cores/general-cores/modules/genrams/common/generic_shiftreg_fifo.vhd"
   xfile add "../../ip_cores/general-cores/modules/genrams/common/inferred_async_fifo.vhd"
   xfile add "../../ip_cores/general-cores/modules/genrams/common/inferred_sync_fifo.vhd"
   xfile add "../../ip_cores/general-cores/modules/genrams/generic/generic_async_fifo.vhd"
   xfile add "../../ip_cores/general-cores/modules/genrams/generic/generic_sync_fifo.vhd"
   xfile add "../../ip_cores/general-cores/modules/genrams/genram_pkg.vhd"
   xfile add "../../ip_cores/general-cores/modules/genrams/memory_loader_pkg.vhd"
   xfile add "../../ip_cores/general-cores/modules/genrams/xilinx/gc_shiftreg.vhd"
   xfile add "../../ip_cores/general-cores/modules/genrams/xilinx/generic_dpram.vhd"
   xfile add "../../ip_cores/general-cores/modules/genrams/xilinx/generic_dpram_dualclock.vhd"
   xfile add "../../ip_cores/general-cores/modules/genrams/xilinx/generic_dpram_sameclock.vhd"
   xfile add "../../ip_cores/general-cores/modules/genrams/xilinx/generic_dpram_split.vhd"
   xfile add "../../ip_cores/general-cores/modules/genrams/xilinx/generic_simple_dpram.vhd"
   xfile add "../../ip_cores/general-cores/modules/genrams/xilinx/generic_spram.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_async_bridge/wb_async_bridge.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_async_bridge/xwb_async_bridge.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_axi4lite_bridge/axi4_pkg.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_axi4lite_bridge/wb_axi4lite_bridge.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_axi4lite_bridge/xwb_axi4lite_bridge.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_bus_fanout/xwb_bus_fanout.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_clock_crossing/xwb_clock_crossing.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_crossbar/sdb_rom.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_crossbar/wb_skidpad.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_crossbar/xwb_crossbar.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_crossbar/xwb_register_link.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_crossbar/xwb_sdb_crossbar.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_dma/xwb_dma.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_dma/xwb_streamer.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_dpram/xwb_dpram.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_gpio_port/wb_gpio_port.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_gpio_port/xwb_gpio_port.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_i2c_bridge/wb_i2c_bridge.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_i2c_master/i2c_master_bit_ctrl.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_i2c_master/i2c_master_byte_ctrl.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_i2c_master/i2c_master_top.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_i2c_master/wb_i2c_master.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_i2c_master/xwb_i2c_master.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_irq/irqm_core.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_irq/wb_irq_lm32.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_irq/wb_irq_master.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_irq/wb_irq_pkg.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_irq/wb_irq_slave.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_irq/wb_irq_timer.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_lm32/generated/lm32_allprofiles.v"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_lm32/generated/xwb_lm32.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_lm32/platform/generic/jtag_tap.v"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_lm32/platform/generic/lm32_multiplier.v"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_lm32/src/jtag_cores.v"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_lm32/src/lm32_adder.v"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_lm32/src/lm32_addsub.v"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_lm32/src/lm32_dp_ram.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_lm32/src/lm32_logic_op.v"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_lm32/src/lm32_mc_arithmetic.v"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_lm32/src/lm32_ram.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_lm32/src/lm32_shifter.v"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_onewire_master/sockit_owm.v"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_onewire_master/wb_onewire_master.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_onewire_master/xwb_onewire_master.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_serial_lcd/wb_serial_lcd.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_simple_pwm/simple_pwm_wb.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_simple_pwm/simple_pwm_wbgen2_pkg.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_simple_pwm/wb_simple_pwm.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_simple_pwm/xwb_simple_pwm.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_simple_timer/wb_tics.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_simple_timer/xwb_tics.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_slave_adapter/wb_slave_adapter.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_spi/spi_clgen.v"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_spi/spi_shift.v"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_spi/spi_top.v"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_spi/wb_spi.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_spi/xwb_spi.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_spi_flash/wb_spi_flash.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_uart/simple_uart_pkg.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_uart/simple_uart_wb.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_uart/uart_async_rx.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_uart/uart_async_tx.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_uart/uart_baud_gen.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_uart/wb_simple_uart.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_uart/xwb_simple_uart.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_vic/vic_prio_enc.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_vic/wb_slave_vic.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_vic/wb_vic.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wb_vic/xwb_vic.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wbgen2/wbgen2_dpssram.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wbgen2/wbgen2_eic.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wbgen2/wbgen2_fifo_async.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wbgen2/wbgen2_fifo_sync.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wbgen2/wbgen2_pkg.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wbgenplus/wbgenplus_pkg.vhd"
   xfile add "../../ip_cores/general-cores/modules/wishbone/wishbone_pkg.vhd"
   xfile add "../../ip_cores/general-cores/platform/xilinx/wb_xil_multiboot/multiboot_fsm.vhd"
   xfile add "../../ip_cores/general-cores/platform/xilinx/wb_xil_multiboot/multiboot_regs.vhd"
   xfile add "../../ip_cores/general-cores/platform/xilinx/wb_xil_multiboot/spi_master.vhd"
   xfile add "../../ip_cores/general-cores/platform/xilinx/wb_xil_multiboot/xwb_xil_multiboot.vhd"
   xfile add "../../ip_cores/general-cores/platform/xilinx/wb_xilinx_fpga_loader/wb_xilinx_fpga_loader.vhd"
   xfile add "../../ip_cores/general-cores/platform/xilinx/wb_xilinx_fpga_loader/xloader_registers_pkg.vhd"
   xfile add "../../ip_cores/general-cores/platform/xilinx/wb_xilinx_fpga_loader/xloader_wb.vhd"
   xfile add "../../ip_cores/general-cores/platform/xilinx/wb_xilinx_fpga_loader/xwb_xilinx_fpga_loader.vhd"
   xfile add "../../ip_cores/gn4124-core/hdl/gn4124core/rtl/dma_controller.vhd"
   xfile add "../../ip_cores/gn4124-core/hdl/gn4124core/rtl/dma_controller_wb_slave.vhd"
   xfile add "../../ip_cores/gn4124-core/hdl/gn4124core/rtl/l2p_arbiter.vhd"
   xfile add "../../ip_cores/gn4124-core/hdl/gn4124core/rtl/l2p_dma_master.vhd"
   xfile add "../../ip_cores/gn4124-core/hdl/gn4124core/rtl/p2l_decode32.vhd"
   xfile add "../../ip_cores/gn4124-core/hdl/gn4124core/rtl/p2l_dma_master.vhd"
   xfile add "../../ip_cores/gn4124-core/hdl/gn4124core/rtl/spartan6/gn4124_core.vhd"
   xfile add "../../ip_cores/gn4124-core/hdl/gn4124core/rtl/spartan6/gn4124_core_pkg.vhd"
   xfile add "../../ip_cores/gn4124-core/hdl/gn4124core/rtl/spartan6/l2p_ser.vhd"
   xfile add "../../ip_cores/gn4124-core/hdl/gn4124core/rtl/spartan6/p2l_des.vhd"
   xfile add "../../ip_cores/gn4124-core/hdl/gn4124core/rtl/spartan6/pulse_sync_rtl.vhd"
   xfile add "../../ip_cores/gn4124-core/hdl/gn4124core/rtl/spartan6/serdes_1_to_n_clk_pll_s2_diff.vhd"
   xfile add "../../ip_cores/gn4124-core/hdl/gn4124core/rtl/spartan6/serdes_1_to_n_data_s2_se.vhd"
   xfile add "../../ip_cores/gn4124-core/hdl/gn4124core/rtl/spartan6/serdes_n_to_1_s2_diff.vhd"
   xfile add "../../ip_cores/gn4124-core/hdl/gn4124core/rtl/spartan6/serdes_n_to_1_s2_se.vhd"
   xfile add "../../ip_cores/gn4124-core/hdl/gn4124core/rtl/wbmaster32.vhd"
   xfile add "../../ip_cores/gn4124-core/hdl/spec/ip_cores/l2p_fifo.ngc"
   xfile add "../../ip_cores/vme64x-core/hdl/rtl/vme64x_core.vhd"
   xfile add "../../ip_cores/vme64x-core/hdl/rtl/vme64x_pkg.vhd"
   xfile add "../../ip_cores/vme64x-core/hdl/rtl/vme_bus.vhd"
   xfile add "../../ip_cores/vme64x-core/hdl/rtl/vme_cr_csr_space.vhd"
   xfile add "../../ip_cores/vme64x-core/hdl/rtl/vme_funct_match.vhd"
   xfile add "../../ip_cores/vme64x-core/hdl/rtl/vme_irq_controller.vhd"
   xfile add "../../ip_cores/vme64x-core/hdl/rtl/vme_user_csr.vhd"
   xfile add "../../ip_cores/vme64x-core/hdl/rtl/xvme64x_core.vhd"
   xfile add "../../modules/fabric/wr_fabric_pkg.vhd"
   xfile add "../../modules/fabric/xwb_fabric_sink.vhd"
   xfile add "../../modules/fabric/xwb_fabric_source.vhd"
   xfile add "../../modules/fabric/xwrf_loopback/lbk_pkg.vhd"
   xfile add "../../modules/fabric/xwrf_loopback/lbk_wishbone_controller.vhd"
   xfile add "../../modules/fabric/xwrf_loopback/wrf_loopback.vhd"
   xfile add "../../modules/fabric/xwrf_loopback/xwrf_loopback.vhd"
   xfile add "../../modules/fabric/xwrf_mux.vhd"
   xfile add "../../modules/fabric/xwrf_reg.vhd"
   xfile add "../../modules/timing/dmtd_phase_meas.vhd"
   xfile add "../../modules/timing/dmtd_with_deglitcher.vhd"
   xfile add "../../modules/timing/hpll_period_detect.vhd"
   xfile add "../../modules/timing/multi_dmtd_with_deglitcher.vhd"
   xfile add "../../modules/timing/pulse_gen.vhd"
   xfile add "../../modules/timing/pulse_stamper.vhd"
   xfile add "../../modules/wr_dacs/spec_serial_dac.vhd"
   xfile add "../../modules/wr_dacs/spec_serial_dac_arb.vhd"
   xfile add "../../modules/wr_eca/eca.vhd"
   xfile add "../../modules/wr_eca/eca_ac_wbm.vhd"
   xfile add "../../modules/wr_eca/eca_ac_wbm_auto.vhd"
   xfile add "../../modules/wr_eca/eca_ac_wbm_auto_pkg.vhd"
   xfile add "../../modules/wr_eca/eca_adder.vhd"
   xfile add "../../modules/wr_eca/eca_auto.vhd"
   xfile add "../../modules/wr_eca/eca_auto_pkg.vhd"
   xfile add "../../modules/wr_eca/eca_channel.vhd"
   xfile add "../../modules/wr_eca/eca_data.vhd"
   xfile add "../../modules/wr_eca/eca_free.vhd"
   xfile add "../../modules/wr_eca/eca_internals_pkg.vhd"
   xfile add "../../modules/wr_eca/eca_msi.vhd"
   xfile add "../../modules/wr_eca/eca_offset.vhd"
   xfile add "../../modules/wr_eca/eca_piso_fifo.vhd"
   xfile add "../../modules/wr_eca/eca_pkg.vhd"
   xfile add "../../modules/wr_eca/eca_queue.vhd"
   xfile add "../../modules/wr_eca/eca_queue_auto.vhd"
   xfile add "../../modules/wr_eca/eca_queue_auto_pkg.vhd"
   xfile add "../../modules/wr_eca/eca_rmw.vhd"
   xfile add "../../modules/wr_eca/eca_scan.vhd"
   xfile add "../../modules/wr_eca/eca_scubus_channel.vhd"
   xfile add "../../modules/wr_eca/eca_sdp.vhd"
   xfile add "../../modules/wr_eca/eca_search.vhd"
   xfile add "../../modules/wr_eca/eca_tag_channel.vhd"
   xfile add "../../modules/wr_eca/eca_tdp.vhd"
   xfile add "../../modules/wr_eca/eca_tlu.vhd"
   xfile add "../../modules/wr_eca/eca_tlu_auto.vhd"
   xfile add "../../modules/wr_eca/eca_tlu_auto_pkg.vhd"
   xfile add "../../modules/wr_eca/eca_tlu_fsm.vhd"
   xfile add "../../modules/wr_eca/eca_walker.vhd"
   xfile add "../../modules/wr_eca/eca_wb_event.vhd"
   xfile add "../../modules/wr_eca/eca_wr_time.vhd"
   xfile add "../../modules/wr_eca/wr_eca.vhd"
   xfile add "../../modules/wr_endpoint/endpoint_pkg.vhd"
   xfile add "../../modules/wr_endpoint/endpoint_private_pkg.vhd"
   xfile add "../../modules/wr_endpoint/ep_1000basex_pcs.vhd"
   xfile add "../../modules/wr_endpoint/ep_autonegotiation.vhd"
   xfile add "../../modules/wr_endpoint/ep_clock_alignment_fifo.vhd"
   xfile add "../../modules/wr_endpoint/ep_crc32_pkg.vhd"
   xfile add "../../modules/wr_endpoint/ep_leds_controller.vhd"
   xfile add "../../modules/wr_endpoint/ep_packet_filter.vhd"
   xfile add "../../modules/wr_endpoint/ep_pcs_tbi_mdio_wb.vhd"
   xfile add "../../modules/wr_endpoint/ep_registers_pkg.vhd"
   xfile add "../../modules/wr_endpoint/ep_rtu_header_extract.vhd"
   xfile add "../../modules/wr_endpoint/ep_rx_buffer.vhd"
   xfile add "../../modules/wr_endpoint/ep_rx_bypass_queue.vhd"
   xfile add "../../modules/wr_endpoint/ep_rx_crc_size_check.vhd"
   xfile add "../../modules/wr_endpoint/ep_rx_early_address_match.vhd"
   xfile add "../../modules/wr_endpoint/ep_rx_oob_insert.vhd"
   xfile add "../../modules/wr_endpoint/ep_rx_path.vhd"
   xfile add "../../modules/wr_endpoint/ep_rx_pcs_16bit.vhd"
   xfile add "../../modules/wr_endpoint/ep_rx_pcs_8bit.vhd"
   xfile add "../../modules/wr_endpoint/ep_rx_status_reg_insert.vhd"
   xfile add "../../modules/wr_endpoint/ep_rx_vlan_unit.vhd"
   xfile add "../../modules/wr_endpoint/ep_rx_wb_master.vhd"
   xfile add "../../modules/wr_endpoint/ep_sync_detect.vhd"
   xfile add "../../modules/wr_endpoint/ep_sync_detect_16bit.vhd"
   xfile add "../../modules/wr_endpoint/ep_timestamping_unit.vhd"
   xfile add "../../modules/wr_endpoint/ep_ts_counter.vhd"
   xfile add "../../modules/wr_endpoint/ep_tx_crc_inserter.vhd"
   xfile add "../../modules/wr_endpoint/ep_tx_header_processor.vhd"
   xfile add "../../modules/wr_endpoint/ep_tx_inject_ctrl.vhd"
   xfile add "../../modules/wr_endpoint/ep_tx_packet_injection.vhd"
   xfile add "../../modules/wr_endpoint/ep_tx_path.vhd"
   xfile add "../../modules/wr_endpoint/ep_tx_pcs_16bit.vhd"
   xfile add "../../modules/wr_endpoint/ep_tx_pcs_8bit.vhd"
   xfile add "../../modules/wr_endpoint/ep_tx_vlan_unit.vhd"
   xfile add "../../modules/wr_endpoint/ep_wishbone_controller.vhd"
   xfile add "../../modules/wr_endpoint/wr_endpoint.vhd"
   xfile add "../../modules/wr_endpoint/xwr_endpoint.vhd"
   xfile add "../../modules/wr_mini_nic/minic_packet_buffer.vhd"
   xfile add "../../modules/wr_mini_nic/minic_wb_slave.vhd"
   xfile add "../../modules/wr_mini_nic/minic_wbgen2_pkg.vhd"
   xfile add "../../modules/wr_mini_nic/wr_mini_nic.vhd"
   xfile add "../../modules/wr_mini_nic/xwr_mini_nic.vhd"
   xfile add "../../modules/wr_pps_gen/pps_gen_wb.vhd"
   xfile add "../../modules/wr_pps_gen/wr_pps_gen.vhd"
   xfile add "../../modules/wr_pps_gen/xwr_pps_gen.vhd"
   xfile add "../../modules/wr_si57x_interface/si570_if_wb.vhd"
   xfile add "../../modules/wr_si57x_interface/si570_if_wbgen2_pkg.vhd"
   xfile add "../../modules/wr_si57x_interface/wr_si57x_interface.vhd"
   xfile add "../../modules/wr_si57x_interface/xwr_si57x_interface.vhd"
   xfile add "../../modules/wr_softpll_ng/softpll_pkg.vhd"
   xfile add "../../modules/wr_softpll_ng/spll_aligner.vhd"
   xfile add "../../modules/wr_softpll_ng/spll_period_detect.vhd"
   xfile add "../../modules/wr_softpll_ng/spll_wb_slave.vhd"
   xfile add "../../modules/wr_softpll_ng/spll_wbgen2_pkg.vhd"
   xfile add "../../modules/wr_softpll_ng/wr_softpll_ng.vhd"
   xfile add "../../modules/wr_softpll_ng/xwr_softpll_ng.vhd"
   xfile add "../../modules/wr_streamers/dropping_buffer.vhd"
   xfile add "../../modules/wr_streamers/escape_detector.vhd"
   xfile add "../../modules/wr_streamers/escape_inserter.vhd"
   xfile add "../../modules/wr_streamers/rx_streamer.vhd"
   xfile add "../../modules/wr_streamers/streamers_pkg.vhd"
   xfile add "../../modules/wr_streamers/streamers_priv_pkg.vhd"
   xfile add "../../modules/wr_streamers/tx_streamer.vhd"
   xfile add "../../modules/wr_streamers/wr_streamers_wb.vhd"
   xfile add "../../modules/wr_streamers/wr_streamers_wbgen2_pkg.vhd"
   xfile add "../../modules/wr_streamers/xrtx_streamers_stats.vhd"
   xfile add "../../modules/wr_streamers/xrx_streamer.vhd"
   xfile add "../../modules/wr_streamers/xrx_streamers_stats.vhd"
   xfile add "../../modules/wr_streamers/xtx_streamer.vhd"
   xfile add "../../modules/wr_streamers/xtx_streamers_stats.vhd"
   xfile add "../../modules/wr_streamers/xwr_streamers.vhd"
   xfile add "../../modules/wr_tbi_phy/disparity_gen_pkg.vhd"
   xfile add "../../modules/wr_tbi_phy/enc_8b10b.vhd"
   xfile add "../../modules/wr_tbi_phy/wr_tbi_phy.vhd"
   xfile add "../../modules/wr_tlu/tlu.vhd"
   xfile add "../../modules/wr_tlu/tlu_fsm.vhd"
   xfile add "../../modules/wr_tlu/tlu_pkg.vhd"
   xfile add "../../modules/wrc_core/wr_core.vhd"
   xfile add "../../modules/wrc_core/wrc_diags_pkg.vhd"
   xfile add "../../modules/wrc_core/wrc_diags_wb.vhd"
   xfile add "../../modules/wrc_core/wrc_periph.vhd"
   xfile add "../../modules/wrc_core/wrc_syscon_pkg.vhd"
   xfile add "../../modules/wrc_core/wrc_syscon_wb.vhd"
   xfile add "../../modules/wrc_core/wrcore_pkg.vhd"
   xfile add "../../modules/wrc_core/xwr_core.vhd"
   xfile add "../../modules/wrc_core/xwrc_diags_wb.vhd"
   xfile add "../../platform/xilinx/chipscope/chipscope_icon.ngc"
   xfile add "../../platform/xilinx/chipscope/chipscope_ila.ngc"
   xfile add "../../platform/xilinx/wr_gtp_phy/family7-gtx/whiterabbit_gtxe2_channel_wrapper_gt.vhd"
   xfile add "../../platform/xilinx/wr_gtp_phy/family7-gtx/wr_gtx_phy_family7.vhd"
   xfile add "../../platform/xilinx/wr_gtp_phy/gtp_bitslide.vhd"
   xfile add "../../platform/xilinx/wr_xilinx_pkg.vhd"
   xfile add "../../platform/xilinx/xwrc_platform_xilinx.vhd"
   xfile add "../../top/clbv2_ref_design/clbv2_wr_ref_top.bmm"
   xfile add "../../top/clbv2_ref_design/clbv2_wr_ref_top.ucf"
   xfile add "../../top/clbv2_ref_design/clbv2_wr_ref_top.vhd"

   # Set the Top Module as well...
   project set top "top" "clbv2_wr_ref_top"

   puts "$myScript: project sources reloaded."

} ; # end add_source_files

# 
# create_libraries
# 
# This procedure defines VHDL libraries and associates files with those libraries.
# It is expected to be used when recreating the project. Any libraries defined
# when this script was generated are recreated by this procedure.
# 
proc create_libraries {} {

   global myScript

   if { ! [ open_project ] } {
      return false
   }

   puts "$myScript: Creating libraries..."


   # must close the project or library definitions aren't saved.
   project save

} ; # end create_libraries

# 
# set_process_props
# 
# This procedure sets properties as requested during script generation (either
# all of the properties, or only those modified from their defaults).
# 
proc set_process_props {} {

   global myScript

   if { ! [ open_project ] } {
      return false
   }

   puts "$myScript: setting process properties..."

   project set "Compiled Library Directory" "\$XILINX/<language>/<simulator>"
   project set "Use DSP Block" "Auto" -process "Synthesize - XST"
   project set "DCI Update Mode" "As Required" -process "Generate Programming File"
   project set "Enable Cyclic Redundancy Checking (CRC)" "true" -process "Generate Programming File"
   project set "Configuration Rate" "3" -process "Generate Programming File"
   project set "Pack I/O Registers/Latches into IOBs" "Off" -process "Map"
   project set "Place And Route Mode" "Route Only" -process "Place & Route"
   project set "Number of Clock Buffers" "32" -process "Synthesize - XST"
   project set "Max Fanout" "100000" -process "Synthesize - XST"
   project set "Use Clock Enable" "Auto" -process "Synthesize - XST"
   project set "Use Synchronous Reset" "Auto" -process "Synthesize - XST"
   project set "Use Synchronous Set" "Auto" -process "Synthesize - XST"
   project set "Regenerate Core" "Under Current Project Setting" -process "Regenerate Core"
   project set "Filter Files From Compile Order" "true"
   project set "Last Applied Goal" "Balanced"
   project set "Last Applied Strategy" "Xilinx Default (unlocked)"
   project set "Last Unlock Status" "false"
   project set "Manual Compile Order" "false"
   project set "Placer Effort Level" "High" -process "Map"
   project set "Extra Cost Tables" "0" -process "Map"
   project set "LUT Combining" "Off" -process "Map"
   project set "Combinatorial Logic Optimization" "false" -process "Map"
   project set "Starting Placer Cost Table (1-100)" "1" -process "Map"
   project set "Power Reduction" "Off" -process "Map"
   project set "Report Fastest Path(s) in Each Constraint" "true" -process "Generate Post-Place & Route Static Timing"
   project set "Generate Datasheet Section" "true" -process "Generate Post-Place & Route Static Timing"
   project set "Generate Timegroups Section" "false" -process "Generate Post-Place & Route Static Timing"
   project set "Report Fastest Path(s) in Each Constraint" "true" -process "Generate Post-Map Static Timing"
   project set "Generate Datasheet Section" "true" -process "Generate Post-Map Static Timing"
   project set "Generate Timegroups Section" "false" -process "Generate Post-Map Static Timing"
   project set "Project Description" ""
   project set "Property Specification in Project File" "Store all values"
   project set "Reduce Control Sets" "Auto" -process "Synthesize - XST"
   project set "Shift Register Minimum Size" "2" -process "Synthesize - XST"
   project set "Case Implementation Style" "None" -process "Synthesize - XST"
   project set "RAM Extraction" "true" -process "Synthesize - XST"
   project set "ROM Extraction" "true" -process "Synthesize - XST"
   project set "FSM Encoding Algorithm" "Auto" -process "Synthesize - XST"
   project set "Optimization Goal" "Speed" -process "Synthesize - XST"
   project set "Optimization Effort" "Normal" -process "Synthesize - XST"
   project set "Resource Sharing" "true" -process "Synthesize - XST"
   project set "Shift Register Extraction" "true" -process "Synthesize - XST"
   project set "User Browsed Strategy Files" ""
   project set "VHDL Source Analysis Standard" "VHDL-93"
   project set "Analysis Effort Level" "Standard" -process "Analyze Power Distribution (XPower Analyzer)"
   project set "Analysis Effort Level" "Standard" -process "Generate Text Power Report"
   project set "Input TCL Command Script" "" -process "Generate Text Power Report"
   project set "Load Physical Constraints File" "Default" -process "Analyze Power Distribution (XPower Analyzer)"
   project set "Load Physical Constraints File" "Default" -process "Generate Text Power Report"
   project set "Load Simulation File" "Default" -process "Analyze Power Distribution (XPower Analyzer)"
   project set "Load Simulation File" "Default" -process "Generate Text Power Report"
   project set "Load Setting File" "" -process "Analyze Power Distribution (XPower Analyzer)"
   project set "Load Setting File" "" -process "Generate Text Power Report"
   project set "Setting Output File" "" -process "Generate Text Power Report"
   project set "Produce Verbose Report" "false" -process "Generate Text Power Report"
   project set "Other XPWR Command Line Options" "" -process "Generate Text Power Report"
   project set "Place MultiBoot Settings into Bitstream" "false" -process "Generate Programming File"
   project set "Revision Select" "00" -process "Generate Programming File"
   project set "Revision Select Tristate" "Disable" -process "Generate Programming File"
   project set "BPI Sync Mode" "Disable" -process "Generate Programming File"
   project set "ICAP Select" "Auto" -process "Generate Programming File"
   project set "SPI 32-bit Addressing" "No" -process "Generate Programming File"
   project set "Set SPI Configuration Bus Width" "1" -process "Generate Programming File"
   project set "Use SPI Falling Edge" "No" -process "Generate Programming File"
   project set "Watchdog Timer Mode" "Off" -process "Generate Programming File"
   project set "Enable External Master Clock" "Disable" -process "Generate Programming File"
   project set "Encrypt Bitstream" "false" -process "Generate Programming File"
   project set "User Access Register Value" "None" -process "Generate Programming File"
   project set "JTAG to XADC Connection" "Enable" -process "Generate Programming File"
   project set "Other Bitgen Command Line Options" "" -process "Generate Programming File"
   project set "Maximum Signal Name Length" "20" -process "Generate IBIS Model"
   project set "Show All Models" "false" -process "Generate IBIS Model"
   project set "Disable Detailed Package Model Insertion" "false" -process "Generate IBIS Model"
   project set "Launch SDK after Export" "true" -process "Export Hardware Design To SDK with Bitstream"
   project set "Launch SDK after Export" "true" -process "Export Hardware Design To SDK without Bitstream"
   project set "Target UCF File Name" "" -process "Back-annotate Pin Locations"
   project set "Ignore User Timing Constraints" "false" -process "Map"
   project set "Register Ordering" "4" -process "Map"
   project set "Use RLOC Constraints" "Yes" -process "Map"
   project set "Other Map Command Line Options" "" -process "Map"
   project set "Use LOC Constraints" "true" -process "Translate"
   project set "Other Ngdbuild Command Line Options" "" -process "Translate"
   project set "Use 64-bit PlanAhead on 64-bit Systems" "true" -process "Floorplan Area/IO/Logic (PlanAhead)"
   project set "Use 64-bit PlanAhead on 64-bit Systems" "true" -process "I/O Pin Planning (PlanAhead) - Pre-Synthesis"
   project set "Use 64-bit PlanAhead on 64-bit Systems" "true" -process "I/O Pin Planning (PlanAhead) - Post-Synthesis"
   project set "Ignore User Timing Constraints" "false" -process "Place & Route"
   project set "Other Place & Route Command Line Options" "" -process "Place & Route"
   project set "BPI Reads Per Page" "1" -process "Generate Programming File"
   project set "Configuration Clk (Configuration Pins)" "Pull Up" -process "Generate Programming File"
   project set "UserID Code (8 Digit Hexadecimal)" "0xFFFFFFFF" -process "Generate Programming File"
   project set "Disable JTAG Connection" "false" -process "Generate Programming File"
   project set "Configuration Pin Done" "Pull Up" -process "Generate Programming File"
   project set "Create ASCII Configuration File" "false" -process "Generate Programming File"
   project set "Create Binary Configuration File" "false" -process "Generate Programming File"
   project set "Create Bit File" "true" -process "Generate Programming File"
   project set "Enable BitStream Compression" "true" -process "Generate Programming File"
   project set "Run Design Rules Checker (DRC)" "true" -process "Generate Programming File"
   project set "Create IEEE 1532 Configuration File" "false" -process "Generate Programming File"
   project set "Create ReadBack Data Files" "false" -process "Generate Programming File"
   project set "Configuration Pin Init" "Pull Up" -process "Generate Programming File"
   project set "Configuration Pin M0" "Pull Up" -process "Generate Programming File"
   project set "Configuration Pin M1" "Pull Up" -process "Generate Programming File"
   project set "Configuration Pin M2" "Pull Up" -process "Generate Programming File"
   project set "Configuration Pin Program" "Pull Up" -process "Generate Programming File"
   project set "Power Down Device if Over Safe Temperature" "false" -process "Generate Programming File"
   project set "JTAG Pin TCK" "Pull Up" -process "Generate Programming File"
   project set "JTAG Pin TDI" "Pull Up" -process "Generate Programming File"
   project set "JTAG Pin TDO" "Pull Up" -process "Generate Programming File"
   project set "JTAG Pin TMS" "Pull Up" -process "Generate Programming File"
   project set "Unused IOB Pins" "Pull Down" -process "Generate Programming File"
   project set "Security" "Enable Readback and Reconfiguration" -process "Generate Programming File"
   project set "Done (Output Events)" "Default (4)" -process "Generate Programming File"
   project set "Enable Outputs (Output Events)" "Default (5)" -process "Generate Programming File"
   project set "Wait for DCI Match (Output Events)" "Auto" -process "Generate Programming File"
   project set "Wait for PLL Lock (Output Events)" "No Wait" -process "Generate Programming File"
   project set "Release Write Enable (Output Events)" "Default (6)" -process "Generate Programming File"
   project set "FPGA Start-Up Clock" "CCLK" -process "Generate Programming File"
   project set "Enable Internal Done Pipe" "true" -process "Generate Programming File"
   project set "Allow Logic Optimization Across Hierarchy" "false" -process "Map"
   project set "Maximum Compression" "false" -process "Map"
   project set "Generate Detailed MAP Report" "false" -process "Map"
   project set "Map Slice Logic into Unused Block RAMs" "false" -process "Map"
   project set "Perform Timing-Driven Packing and Placement" "false"
   project set "Trim Unconnected Signals" "true" -process "Map"
   project set "Create I/O Pads from Ports" "false" -process "Translate"
   project set "Macro Search Path" "" -process "Translate"
   project set "Netlist Translation Type" "Timestamp" -process "Translate"
   project set "User Rules File for Netlister Launcher" "" -process "Translate"
   project set "Allow Unexpanded Blocks" "false" -process "Translate"
   project set "Allow Unmatched LOC Constraints" "false" -process "Translate"
   project set "Allow Unmatched Timing Group Constraints" "false" -process "Translate"
   project set "Perform Advanced Analysis" "false" -process "Generate Post-Place & Route Static Timing"
   project set "Report Paths by Endpoint" "3" -process "Generate Post-Place & Route Static Timing"
   project set "Report Type" "Verbose Report" -process "Generate Post-Place & Route Static Timing"
   project set "Number of Paths in Error/Verbose Report" "3" -process "Generate Post-Place & Route Static Timing"
   project set "Stamp Timing Model Filename" "" -process "Generate Post-Place & Route Static Timing"
   project set "Report Unconstrained Paths" "" -process "Generate Post-Place & Route Static Timing"
   project set "Perform Advanced Analysis" "false" -process "Generate Post-Map Static Timing"
   project set "Report Paths by Endpoint" "3" -process "Generate Post-Map Static Timing"
   project set "Report Type" "Verbose Report" -process "Generate Post-Map Static Timing"
   project set "Number of Paths in Error/Verbose Report" "3" -process "Generate Post-Map Static Timing"
   project set "Report Unconstrained Paths" "" -process "Generate Post-Map Static Timing"
   project set "Add I/O Buffers" "true" -process "Synthesize - XST"
   project set "Global Optimization Goal" "AllClockNets" -process "Synthesize - XST"
   project set "Keep Hierarchy" "No" -process "Synthesize - XST"
   project set "Register Balancing" "No" -process "Synthesize - XST"
   project set "Register Duplication" "true" -process "Synthesize - XST"
   project set "Library for Verilog Sources" "" -process "Synthesize - XST"
   project set "Export Results to XPower Estimator" "" -process "Generate Text Power Report"
   project set "Asynchronous To Synchronous" "false" -process "Synthesize - XST"
   project set "Automatic BRAM Packing" "false" -process "Synthesize - XST"
   project set "BRAM Utilization Ratio" "100" -process "Synthesize - XST"
   project set "Bus Delimiter" "<>" -process "Synthesize - XST"
   project set "Case" "Maintain" -process "Synthesize - XST"
   project set "Cores Search Directories" "" -process "Synthesize - XST"
   project set "Cross Clock Analysis" "false" -process "Synthesize - XST"
   project set "DSP Utilization Ratio" "100" -process "Synthesize - XST"
   project set "Equivalent Register Removal" "true" -process "Synthesize - XST"
   project set "FSM Style" "LUT" -process "Synthesize - XST"
   project set "Generate RTL Schematic" "Yes" -process "Synthesize - XST"
   project set "Generics, Parameters" "" -process "Synthesize - XST"
   project set "Hierarchy Separator" "/" -process "Synthesize - XST"
   project set "HDL INI File" "" -process "Synthesize - XST"
   project set "LUT Combining" "Auto" -process "Synthesize - XST"
   project set "Library Search Order" "" -process "Synthesize - XST"
   project set "Netlist Hierarchy" "As Optimized" -process "Synthesize - XST"
   project set "Optimize Instantiated Primitives" "false" -process "Synthesize - XST"
   project set "Pack I/O Registers into IOBs" "Auto" -process "Synthesize - XST"
   project set "Power Reduction" "false" -process "Synthesize - XST"
   project set "Read Cores" "true" -process "Synthesize - XST"
   project set "LUT-FF Pairs Utilization Ratio" "100" -process "Synthesize - XST"
   project set "Use Synthesis Constraints File" "true" -process "Synthesize - XST"
   project set "Verilog Include Directories" "" -process "Synthesize - XST"
   project set "Verilog Macros" "" -process "Synthesize - XST"
   project set "Work Directory" "/media/wei/DATA/LW/Project/WR_Project/WR_Reference_Design/wr-cores-acme1/wr-cores/syn/clbv2_ref_design/xst" -process "Synthesize - XST"
   project set "Write Timing Constraints" "false" -process "Synthesize - XST"
   project set "Other XST Command Line Options" "" -process "Synthesize - XST"
   project set "Timing Mode" "Performance Evaluation" -process "Map"
   project set "Generate Asynchronous Delay Report" "false" -process "Place & Route"
   project set "Generate Clock Region Report" "false" -process "Place & Route"
   project set "Generate Post-Place & Route Power Report" "false" -process "Place & Route"
   project set "Generate Post-Place & Route Simulation Model" "false" -process "Place & Route"
   project set "Power Reduction" "false" -process "Place & Route"
   project set "Place & Route Effort Level (Overall)" "High" -process "Place & Route"
   project set "Auto Implementation Compile Order" "true"
   project set "Placer Extra Effort" "None" -process "Map"
   project set "Power Activity File" "" -process "Map"
   project set "Register Duplication" "Off" -process "Map"
   project set "Generate Constraints Interaction Report" "false" -process "Generate Post-Map Static Timing"
   project set "Synthesis Constraints File" "" -process "Synthesize - XST"
   project set "RAM Style" "Auto" -process "Synthesize - XST"
   project set "Maximum Number of Lines in Report" "1000" -process "Generate Text Power Report"
   project set "MultiBoot: Insert IPROG CMD in the Bitfile" "Enable" -process "Generate Programming File"
   project set "Watchdog Timer Value" "0x00000000" -process "Generate Programming File"
   project set "AES Initial Vector" "" -process "Generate Programming File"
   project set "HMAC Key (Hex String)" "" -process "Generate Programming File"
   project set "Encrypt Key Select" "BBRAM" -process "Generate Programming File"
   project set "AES Key (Hex String)" "" -process "Generate Programming File"
   project set "Input Encryption Key File" "" -process "Generate Programming File"
   project set "Output File Name" "clbv2_wr_ref_top" -process "Generate IBIS Model"
   project set "Timing Mode" "Performance Evaluation" -process "Place & Route"
   project set "Cycles for First BPI Page Read" "1" -process "Generate Programming File"
   project set "Fallback Reconfiguration" "Disable" -process "Generate Programming File"
   project set "Enable Debugging of Serial Mode BitStream" "false" -process "Generate Programming File"
   project set "Create Logic Allocation File" "false" -process "Generate Programming File"
   project set "Create Mask File" "false" -process "Generate Programming File"
   project set "Starting Address for Fallback Configuration" "None" -process "Generate Programming File"
   project set "Allow SelectMAP Pins to Persist" "false" -process "Generate Programming File"
   project set "Enable Multi-Threading" "Off" -process "Map"
   project set "Generate Constraints Interaction Report" "false" -process "Generate Post-Place & Route Static Timing"
   project set "Move First Flip-Flop Stage" "true" -process "Synthesize - XST"
   project set "Move Last Flip-Flop Stage" "true" -process "Synthesize - XST"
   project set "ROM Style" "Auto" -process "Synthesize - XST"
   project set "Safe Implementation" "No" -process "Synthesize - XST"
   project set "Power Activity File" "" -process "Place & Route"
   project set "Extra Effort (Highest PAR level only)" "None" -process "Place & Route"
   project set "Enable Multi-Threading" "Off" -process "Place & Route"
   project set "Functional Model Target Language" "Verilog" -process "View HDL Source"
   project set "Change Device Speed To" "-1" -process "Generate Post-Place & Route Static Timing"
   project set "Change Device Speed To" "-1" -process "Generate Post-Map Static Timing"

   puts "$myScript: project property values set."

} ; # end set_process_props

proc main {} {

   if { [llength $::argv] == 0 } {
      show_help
      return true
   }

   foreach option $::argv {
      switch $option {
         "show_help"           { show_help }
         "run_process"         { run_process }
         "rebuild_project"     { rebuild_project }
         "set_project_props"   { set_project_props }
         "add_source_files"    { add_source_files }
         "create_libraries"    { create_libraries }
         "set_process_props"   { set_process_props }
         default               { puts "unrecognized option: $option"; show_help }
      }
   }
}

if { $tcl_interactive } {
   show_help
} else {
   if {[catch {main} result]} {
      puts "$myScript failed: $result."
   }
}

