//++++++++++MODULO MULTIPLEXOR 2 X 1 CON VALID DE 4 BITS CON UN FLIP FLOP PARA GUARDAR EN MEMORIA EL ESTADO Y CON RESET +++++++++++++++

`include "mux_memoria2x1_conductual.v"
module mux_memoria2x1_4bitsconductual(
    input clk,
    input reset_L,
    input selector,
    input valid_input,
    input [3:0] data_in0_4b, //entrada 4 bits
    input [3:0] data_in1_4b, //entrada 4 bits
    output reg valid_output,
    output reg [3:0] data_out2x1_conductual_4b //salida 4 bits

);

    wire [3:0] data_out_temp;
    wire valid_temp;

    // Hacemos el mux 2x1 de 4 bit a partir del mux 2x1 de 2 bits.

    mux_memoria2x1_conductual muxEntrada10(.selector(selector), .reset_L(reset_L), .clk(clk), .valid_input(valid_input),
                                          .data_in0(data_in0_4b[1:0]), .data_in1(data_in1_4b[1:0]), .valid_output(temporal_valid), .data_out2x1_conductual(data_out_temp[1:0]));
    
    mux_memoria2x1_conductual muxEntrada32(.selector(selector), .reset_L(reset_L), .clk(clk), .valid_input(valid_input),
                                          .data_in0(data_in0_4b[3:2]), .data_in1(data_in1_4b[3:2]), .valid_output(valid_temp), .data_out2x1_conductual(data_out_temp[3:2]));
    
    always @(*) begin
        data_out2x1_conductual_4b = data_out_temp;
        valid_output = valid_temp;
    end


endmodule