module DigitalTube_3b (
    clk,
    rst_N,

    number_BCD,
    pin_out
);

input   clk, rst_N;

input           [11:0]   number_BCD;

output  wire    [20:0]   pin_out;



DigitalTube DigitalTube_bit0_inst(
    .clk        (clk),
    .rst_N      (rst_N),

    .number     (number_BCD[3:0]),
    .pin_out    (pin_out[6:0])
);

DigitalTube DigitalTube_bit1_inst(
    .clk        (clk),
    .rst_N      (rst_N),

    .number     (number_BCD[7:4]),
    .pin_out    (pin_out[13:7])
);

DigitalTube DigitalTube_bit2_inst(
    .clk        (clk),
    .rst_N      (rst_N),

    .number     (number_BCD[11:8]),
    .pin_out    (pin_out[20:14])
);


endmodule

