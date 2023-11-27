`timescale 1ns / 1ps

module tick_gen #(
        parameter DELAY_OUT = 0, // there is timing issue, between sec, min, hour, hour is 2clk slower
                                // so, we delay sec 2clk, min 1clk,
                                // then we can align sec,min,hour
        parameter COUNT_BIT = 6, //sec, min, hour cnt bit
        parameter INPUT_CNT = 60 // 60, 60, 24
)(
        input clk,
        input reset,
        input i_run_en,
        input i_tick,

        output reg o_tick_gen,
        output [COUNT_BIT-1:0] o_cnt_val
);

        reg [COUNT_BIT-1:0] r_cnt_val;

        always @(posedge clk)begin
                if(reset)begin
                        o_tick_gen <=0;
                        r_cnt_val <= {COUNT_BIT{1'b0}};
                end else if(i_run_en & i_tick)begin // i_tick 1sec or 1min or 1hour
                        if(r_cnt_val == INPUT_CNT-1)begin
                                r_cnt_val <= 0;     // 59sec -> 0sec / 59min -> 0min  / 23hour -> 0hour
                                o_tick_gen <= 1'b1; // 60sec -> 1min / 60min -> 1hour
                        end else begin
                                r_cnt_val <= r_cnt_val +1'b1;
                        end
                end else begin
                        o_tick_gen <= 1'b0;
                end
        end

        genvar gi;

        generate
                if(DELAY_OUT == 0)begin
                        assign o_cnt_val = r_cnt_val; //the reason, o_cnt_val is wire .

                end else if(DELAY_OUT == 1)begin //DELAY_OUT ==1
                        reg [COUNT_BIT-1:0] r_cnt_val_d;
                        always@(posedge clk)begin       //since we add this always loop
                                                        //so, r_cnt_val delay1
                                r_cnt_val_d <= r_cnt_val;
                        end
                        assign o_cnt_val = r_cnt_val_d;
