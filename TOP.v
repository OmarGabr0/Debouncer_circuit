module top #(parameter num_stages=2, counter_final_value =99) (
    input wire noisy_in,
    input wire clk,
    input wire rst_n,

    output wire debouncer_out
);

// internal 
wire TIMER_DONE,TIMER_EN;
wire SYNC_SIG;

//////////

bitsync #(.num_stages(num_stages)) u0_bitsync (
    .noisy_in(noisy_in),
    .rst_n(rst_n),
    .clk(clk),

    .sync_sig(SYNC_SIG)
);

fsm u0_fsm(
    .sync_sig(SYNC_SIG),
    .clk(clk),
    .rst_n(rst_n),
    .timer_done(TIMER_DONE),

    .timer_en(TIMER_EN),
    .debouncer_out(debouncer_out)

);

timer #(.counter_final_value(counter_final_value)) u0_timer(
    .clk(clk),
    .rst_n(rst_n),
    .timer_en(TIMER_EN),

    .timer_done(TIMER_DONE)
);



endmodule