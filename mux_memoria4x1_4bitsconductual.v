//++++++++++MODULO MULTIPLEXOR 4 X 1 CON VALID DE 4 BITS CON UN FLIP FLOP PARA GUARDAR EN MEMORIA EL ESTADO Y CON RESET +++++++++++++++

module mux_memoria4x1_4bitsconductual(
    input clk,
    input reset_L,
    input [1:0]selector4x1,
    input valid_input,
    input [3:0] data_in0_4x1_4b, //entrada 4 bits
    input [3:0] data_in1_4x1_4b, //entrada 4 bits
    input [3:0] data_in2_4x1_4b, //entrada 4 bits
    input [3:0] data_in3_4x1_4b, //entrada 4 bits
    output reg valid_output,
    output reg [3:0] data_out4x1_conductual_4b //salida 4 bits

);

    wire [3:0] data_out_S1,data_out_S0,data_out_temp;
    wire valid_temp;

    // Hacemos el mux 2x1 de 4 bit a partir del mux 2x1 de 2 bits.



    mux_memoria2x1_4bitsconductual muxEntrada01(.selector(selector4x1[0]), .reset_L(reset_L), .clk(clk), .valid_input(valid_input),
                                          .data_in0_4b(data_in0_4x1_4b), .data_in1_4b(data_in1_4x1_4b), .valid_output(temporal_valid), .data_out2x1_conductual_4b(data_out_S0));
    
    mux_memoria2x1_4bitsconductual muxEntrada23(.selector(selector4x1[0]), .reset_L(reset_L), .clk(clk), .valid_input(valid_input),
                                          .data_in0_4b(data_in2_4x1_4b), .data_in1_4b(data_in3_4x1_4b), .valid_output(temporal_valid2), .data_out2x1_conductual_4b(data_out_S1));
    
    mux_memoria2x1_4bitsconductual muxEntradaFinal(.selector(selector4x1[1]), .reset_L(reset_L), .clk(clk), .valid_input(valid_input),
                                          .data_in0_4b(data_out_S0), .data_in1_4b(data_out_S1), .valid_output(valid_temp), .data_out2x1_conductual_4b(data_out_temp));
    
    
   
    always @(*) begin
        data_out4x1_conductual_4b = data_out_temp;
        valid_output = valid_temp;
    end


endmodule