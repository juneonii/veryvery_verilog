`timescale 1ns / 1ps

module tb_watch_top;

        localparam COUNT_BIT = 30;
        localparam SEC_BIT =6;
        localparam MIN_BIT = 6;
        localparam HOUR_BIT = 5;

        reg clk,reset;
        reg i_run_en;
        reg [COUNT_BIT-1:0] i_freq;

        wire [SEC_BIT-1:0] o_sec;
        wire [MIN_BIT-1:0] o_min;
        wire [HOUR_BIT-1:0] o_hour;

        always
                #5 clk = ~clk;

        initial begin
                $display("INITIALIZE [%d] " , $time);
                        i_freq <= 10;
                $display("RESET [%d] " , $time);
                        reset <=0;
                        clk <=0;
                        i_run_en <=0;
                $display("START [%d] " , $time);
                        #100
                        reset <= 1;
                        #10
                        reset <= 0;
                        i_run_en <= 1;
                        #10
                        @(posedge clk);
                        #10000000

                $display("FINISH [%d] " , $time);
                        i_run_en <=0;

                $finish;
        end

        watch_top #(
                .COUNT_BIT(COUNT_BIT),
                .SEC_BIT(SEC_BIT),
                .MIN_BIT(MIN_BIT),
                .HOUR_BIT(HOUR_BIT)
        ) dut_watch_top(
                .clk(clk),
                .reset(reset),
                .i_run_en(i_run_en),
                .i_freq(i_freq),
                .o_sec(o_sec),
                .o_min(o_min),
                .o_hour(o_hour)
        );

endmodule
