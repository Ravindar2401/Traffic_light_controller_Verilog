module Traffic_light_controller(
    input clk,
    input reset,
    input sec_tick,
    output reg [2:0] roadA,
    output reg [2:0] roadB
);

parameter s0 = 2'b00,
          s1 = 2'b01,
          s2 = 2'b10,
          s3 = 2'b11;

parameter GREEN  = 3'b001,
          YELLOW = 3'b010,
          RED    = 3'b100;

reg [1:0] state, next_state;
reg [7:0] count;
wire [7:0] limit;

assign limit = (state == s0 || state == s2) ? 8'd10 : 8'd3;

wire timer_done = (count == limit - 1);

always @(posedge clk or negedge reset)
begin
    if(!reset)
        count <= 0;
    else if(sec_tick)
    begin
        if(timer_done)
            count <= 0;
        else
            count <= count + 1;
    end
end

always @(posedge clk or negedge reset)
begin
    if(!reset)
        state <= s0;
    else
        state <= next_state;
end

always @(*)
begin
    next_state = state;
    case(state)
        s0: if(sec_tick && timer_done) next_state = s1;
        s1: if(sec_tick && timer_done) next_state = s2;
        s2: if(sec_tick && timer_done) next_state = s3;
        s3: if(sec_tick && timer_done) next_state = s0;
    endcase
end

always @(*)
begin
    case(state)
        s0: begin roadA = GREEN;  roadB = RED;    end
        s1: begin roadA = YELLOW; roadB = RED;    end
        s2: begin roadA = RED;    roadB = GREEN;  end
        s3: begin roadA = RED;    roadB = YELLOW; end
        default: begin roadA = RED; roadB = RED;  end
    endcase
end

endmodule