module DigitalTube (
    clk,
    rst_N,

    number,
    pin_out
);

input   clk, rst_N;

input           [3:0]   number;

output  reg     [6:0]   pin_out;



always @(posedge clk, negedge rst_N)
begin
    if (!rst_N) begin
        pin_out <= 7'b11111111;
    end
    else begin
        case (number)
            0: pin_out <= 7'b1000000;
            1: pin_out <= 7'b1111001;
            2: pin_out <= 7'b0100100;
            3: pin_out <= 7'b0110000;
            4: pin_out <= 7'b0011001;
            5: pin_out <= 7'b0010010;
            6: pin_out <= 7'b0000010;
            7: pin_out <= 7'b1111000;
            8: pin_out <= 7'b0000000;
            9: pin_out <= 7'b0010000;
            default: pin_out <= 7'b11111111;
        endcase
    end
end


endmodule

