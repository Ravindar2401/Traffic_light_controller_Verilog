module clk_divider(
    input clk, reset,
    output reg sec_tick
);

parameter CLK_FREQ = 50000000;

reg [25:0] count;

always @(posedge clk or negedge reset)
begin
    if(!reset)
    begin
        count <= 0;
        sec_tick <= 0;
    end
    else if(count == CLK_FREQ-1)
    begin
        count <= 0;
        sec_tick <= 1'b1;
    end
    else
    begin
        count <= count + 1;
        sec_tick <= 1'b0;
    end
end

endmodule