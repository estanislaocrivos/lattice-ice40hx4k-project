module top(
    input  clk,
    output led_green,
    output led_red,
    output led_yellow,
    output led_blue
);
    reg [23:0] counter = 0;

    always @(posedge clk)
        counter <= counter + 1;

    assign led_green  = counter[23]; // ~0.7 Hz
    assign led_red    = counter[22]; // ~1.4 Hz
    assign led_yellow = counter[21]; // ~2.8 Hz
    assign led_blue   = counter[20]; // ~5.7 Hz
endmodule
