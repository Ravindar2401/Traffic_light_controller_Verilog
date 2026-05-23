module traffic_light_controller_top(
    input clk,reset,
    output [2:0] roadA,roadB
    );
wire sec_tick;

clk_divider dut1(.clk(clk),.reset(reset),.sec_tick(sec_tick));

Traffic_light_controller dut2(.clk(clk),.reset(reset),.sec_tick(sec_tick),.roadA(roadA),.roadB(roadB));



endmodule
