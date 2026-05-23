# Traffic_light_controller_Verilog
An optimized Dual-Road Traffic Light Controller with structural glitch rectification using Vivado.

Designed and simulated a 2-Road Traffic Light Controller (TLC) in Xilinx Vivado using structural and behavioral Verilog.

**Hardware Fixes: Delta Delay Race Condition**
Ran into a critical simulation glitch where the FSM was skipping the 3-second Yellow light state (`s1`) due to simulator Delta Delay ($\Delta$).

**Issue:** The combinational `timer_done` signal triggered the next state logic before the counter could latch the proper reset value within the same clock cycle.
**Fix:** Fixed it by gating the next-state logic with `if (sec_tick && timer_done)`. This created a synchronous barrier that aligned state transitions perfectly with the 1Hz pulse, eliminating the glitch completely.

**Project Hierarchy & Modules**
Split the architecture into 3 clean modules for better synthesis:
1. **clk_divider.v:** Scales down the high-frequency internal FPGA clock to a stable 1Hz `sec_tick`.
2. **Traffic_light_controller.v:** Core FSM tracking highway and side-road timing loops based on state parameters.
3. **traffic_light_controller_top.v:** Top-level wrapper routing IO lines and integrating the clock divider with the FSM block.

**Simulation Parameters**
Tool: Xilinx Vivado (Behavioral Simulation)
Timing:Highway Green (10s), Side Road Yellow (3s)
Status:Passed functional verification with correct timing waveforms.
