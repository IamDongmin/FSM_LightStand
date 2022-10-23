`timescale 1ns / 1ps

module tb_LightStand();

    reg i_clk = 0;
    reg i_reset = 0;
    reg [2:0] i_button;

    wire o_light;

    top_LightStand dut(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(i_button),
        .o_light(o_light)
    );

    always #0.001 i_clk = ~i_clk;

    initial begin
        #00 i_button = 3'b000;
        #5000 i_button = 3'b001;
        #5000 i_button = 3'b010;
        #5000 i_button = 3'b011;
        #5000 i_button = 3'b100;
        #5000 i_button = 3'b011;
        #5000 i_button = 3'b010;
        #5000 i_button = 3'b001;
        #5000 i_button = 3'b000;
        #5000 $finish;
    end

endmodule
