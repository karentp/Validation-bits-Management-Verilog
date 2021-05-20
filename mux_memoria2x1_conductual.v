//++++++++++MODULO MULTIPLEXOR 2 X 1 CON VALID CON UN FLIP FLOP PARA GUARDAR EN MEMORIA EL ESTADO Y CON RESET +++++++++++++++

module mux_memoria2x1_conductual(
    input clk,
    input reset_L,
    input selector,
    input valid_input,
    input [1:0] data_in0,
    input [1:0] data_in1,
    output reg valid_output,
    output reg [1:0] data_out2x1_conductual
);
    // Este es un wire temporal que pasará los registros del MUX al Flip Flop
    reg [1:0] temporal_output = 2'b00;
    reg temporal_valid;

    // Este es el bloque always para la lógica del MUX 2x1
    always @(*) begin
        temporal_valid = valid_input;
        if (selector)
            temporal_output = data_in1;
        else
            temporal_output = data_in0;

    end

    // Este es el bloque always para la lógica del Flip Flop con reset

    always @(posedge clk) begin
        valid_output <= temporal_valid;
        if(temporal_valid)begin
            if (reset_L)
                data_out2x1_conductual <= temporal_output;
            else
                data_out2x1_conductual <= 2'b00;
        end
    end

endmodule