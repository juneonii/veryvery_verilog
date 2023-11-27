`timescale 1ns / 1ps

module watch_top#(
        parameter COUNT_BIT = 30,       //we set it under 1GHz ~= 2^30
        parameter SEC_BIT = 6,          // 60sec < 2^6
        parameter MIN_BIT = 6,          // 60min < 2^6
        parameter HOUR_BIT = 5          // 24hour < 2^5
)(
        input clk,
        input reset,
        input i_run_en,
        input [COUNT_BIT -1:0] i_freq,

        output [SEC_BIT-1:0] o_sec,
        output [MIN_BIT-1:0] o_min,
        output [HOUR_BIT-1:0] o_hour
);

        wire w_one_sec_tick;
        wire w_one_min_tick;
        wire w_one_hour_tick;

        one_sec_gen #(          // one_sec_gen make '1 second'
                .COUNT_BIT(COUNT_BIT)
        ) dut_one_sec_gne(
                .clk(clk),
                .reset(reset),
                .i_run_en(i_run_en),
                .i_freq(i_freq),
                .o_one_sec_tick(w_one_sec_tick)
        );

        tick_gen #(             // tick_gen_sec count 'second' and make '1 minute'
                .DELAY_OUT(2),  // cause betweed second and hour has 2 cycle delays
                .COUNT_BIT(SEC_BIT),
                .INPUT_CNT(60)
        ) dut_tick_gen_sec(
                .clk(clk),
                .reset(reset),
                .i_run_en(i_run_en),
                .i_tick(w_one_sec_tick),
                .o_tick_gen(w_one_min_tick),
                .o_cnt_val(o_sec)
        );

        tick_gen #(             // tick_gen_min count 'minute' and make '1 hour'
                .DELAY_OUT(1),  // cause betweed minute and hour has 1 cycle delays
                .COUNT_BIT(MIN_BIT),
                .INPUT_CNT(60)
        ) dut_tick_gen_min(
                .clk(clk),
                .reset(reset),
                .i_run_en(i_run_en),
                .i_tick(w_one_min_tick),
                .o_tick_gen(w_one_hour_tick),
                .o_cnt_val(o_min)
        );

        tick_gen #(             // tick_gen_hour count 'hour' and then.. after 23hour is 0hour start~
                .DELAY_OUT(0),
                .COUNT_BIT(HOUR_BIT),
                .INPUT_CNT(24)
        ) dut_tick_gen_hour(
                .clk(clk),
                .reset(reset),
                .i_run_en(i_run_en),
                .i_tick(w_one_hour_tick),
                .o_tick_gen(),
                .o_cnt_val(o_hour)
        );



endmodule
