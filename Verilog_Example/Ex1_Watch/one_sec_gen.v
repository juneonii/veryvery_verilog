`timescale 1ns / 1ps

module one_sec_gen#(
        parameter COUNT_BIT = 30 // we limit it under 1GHz == 1,000,000,000 ~= 2^30
                                //COUNT_BIT  sets clock speed.


)(
        input clk,
        input reset,
        input i_run_en,
        input [COUNT_BIT -1:0] i_freq, // we make clk == 100MHz
                                        // so, i_freq = 100MHz is 1sec.
        output reg o_one_sec_tick
);

        reg [COUNT_BIT -1:0] r_counter;

        always @(posedge clk)begin
                if(reset)begin
                        r_counter <={COUNT_BIT{1'b0}};
                        o_one_sec_tick <=0;
                end else if(i_run_en)begin
                        if(r_counter == i_freq-1)begin  // r_counter starts from 0 to i_freq-1
                                r_counter <=0;
                                o_one_sec_tick <=1;
                        end else begin
                                r_counter <= r_counter +1'b1;   //r_counter adds 1'b1 at every clk.
                                                                //if clk is 100MHz,
                                                                //Counting 100M is 1sec.
                                o_one_sec_tick <= 0;
                        end
                end else begin
                        o_one_sec_tick <= 1'b0;

                end

        end

endmodule

