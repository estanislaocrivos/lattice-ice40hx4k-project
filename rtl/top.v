/* Placeholder design: confirms the toolchain works end-to-end on a fresh
   copy of this template before you replace it with real RTL. Blinks the
   first LED off a free-running counter. */

module top #(
    parameter NB_COUNTER = 24
) (
    output o_led,

    input clock
);

    reg [NB_COUNTER-1:0] counter;

    always @(posedge clock) begin
        counter <= counter + 1;
    end

    assign o_led = counter[NB_COUNTER-1];

endmodule
