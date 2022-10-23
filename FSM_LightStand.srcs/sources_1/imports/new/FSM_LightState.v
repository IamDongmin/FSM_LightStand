`timescale 1ns / 1ps

module FSM_LightState(
    input i_clk,
    input i_reset,
    input [2:0] i_button,

    output [2:0] o_lightState
    );

    parameter S_LED_Off = 3'b000,
              S_LED_1 = 3'b001,
              S_LED_2 = 3'b010,
              S_LED_3 = 3'b011,
              S_LED_4 = 3'b100;

    reg [2:0] curState = S_LED_Off, nextState = S_LED_Off;
    reg [2:0] r_lightState;

    assign o_lightState = r_lightState;

//상태 변경
    always @(posedge i_clk or posedge i_reset) begin
        if(i_reset) curState <= S_LED_Off;
        else        curState <= nextState;
    end

//이벤트 처리
    always @(curState or i_button) begin
        case (curState)
        S_LED_Off : begin
            if(i_button[0])      nextState <= S_LED_Off;
            else if(i_button[1]) nextState <= S_LED_1;
            else if(i_button[2]) nextState <= S_LED_Off;
            else                 nextState <= S_LED_Off;
        end
        S_LED_1 : begin
            if(i_button[0])      nextState <= S_LED_Off;
            else if(i_button[1]) nextState <= S_LED_2;
            else if(i_button[2]) nextState <= S_LED_Off;
            else                 nextState <= S_LED_1;
        end
        S_LED_2 : begin
            if(i_button[0])      nextState <= S_LED_Off;
            else if(i_button[1]) nextState <= S_LED_3;
            else if(i_button[2]) nextState <= S_LED_1;
            else                 nextState <= S_LED_2;
        end
        S_LED_3 : begin
            if(i_button[0])      nextState <= S_LED_Off;
            else if(i_button[1]) nextState <= S_LED_4;
            else if(i_button[2]) nextState <= S_LED_2;
            else                 nextState <= S_LED_3;
        end
        S_LED_4 : begin
            if(i_button[0])      nextState <= S_LED_Off;
            else if(i_button[1]) nextState <= S_LED_4;
            else if(i_button[2]) nextState <= S_LED_3;
            else                 nextState <= S_LED_4;
        end
        endcase
    end

//상태에 따른 동작
    always @(curState) begin
        case (curState)
            S_LED_Off : r_lightState <= 3'b000; 
            S_LED_1 : r_lightState <= 3'b001;
            S_LED_2 : r_lightState <= 3'b010;
            S_LED_3 : r_lightState <= 3'b011;
            S_LED_4 : r_lightState <= 3'b100;
            default: r_lightState <= 3'b000;
        endcase
    end
endmodule
