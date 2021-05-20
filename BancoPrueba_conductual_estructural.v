//++++++++++MODULO PROBADOR PARA MUX CON MEMORIA: GENERADOR DE SEÑALES Y MONITOR DE DATOS +++++++++++++++


`timescale 	1ns	/ 100ps
// escala	unidad temporal (valor de "#1") / precisi�n

// includes de archivos de verilog

`include "mux_memoria4x1_4bitsconductual.v"
//`include "mux_memoria2x1_conductual.v"
`include "probador.v"

 // Testbench

module BancoPruebas;
	
    wire clk, selector, reset_L, valid_input, valid_output;

	//Entradas_2bits
	wire [1:0] data_in0, data_in1, data_out2x1_estructural, data_out2x1_conductual,  selector4x1 ;

	//Entradas_4bits
	wire [3:0] data_in0_4b, data_in1_4b, data_out2x1_estructural_4b, data_out2x1_conductual_4b, data_in0_4x1_4b, data_in1_4x1_4b, data_in2_4x1_4b,data_in3_4x1_4b, data_out4x1_conductual_4b, data_out4x1_estructural_4b;

	// Descripcion conductual del MUX con memoria 2x1 de 2 bits
	mux_memoria2x1_conductual	mux2x1cond(/*AUTOINST*/
						   // Outputs
						   .valid_output	(valid_output),
						   .data_out2x1_conductual(data_out2x1_conductual[1:0]),
						   // Inputs
						   .clk			(clk),
						   .reset_L		(reset_L),
						   .selector		(selector),
						   .valid_input		(valid_input),
						   .data_in0		(data_in0[1:0]),
						   .data_in1		(data_in1[1:0]));

	// Descripcion estructural del MUX con memoria 2x1 de 2 bits
	mux_memoria2x1_estructural	mux2x1est(/*AUTOINST*/
						  // Outputs
						  .data_out2x1_estructural(data_out2x1_estructural[1:0]),
						  .valid_output		(valid_output),
						  // Inputs
						  .clk			(clk),
						  .data_in0		(data_in0[1:0]),
						  .data_in1		(data_in1[1:0]),
						  .reset_L		(reset_L),
						  .selector		(selector),
						  .valid_input		(valid_input));

	// Descripcion conductual del MUX con memoria 2x1 de 4 bits
	mux_memoria2x1_4bitsconductual	mux2x1_4bitscond(/*AUTOINST*/
							 // Outputs
							 .valid_output		(valid_output),
							 .data_out2x1_conductual_4b(data_out2x1_conductual_4b[3:0]),
							 // Inputs
							 .clk			(clk),
							 .reset_L		(reset_L),
							 .selector		(selector),
							 .valid_input		(valid_input),
							 .data_in0_4b		(data_in0_4b[3:0]),
							 .data_in1_4b		(data_in1_4b[3:0]));


	// Descripcion estructural del MUX con memoria 2x1 de 4 bits
	mux_memoria2x1_4bitsestructural	mux2x1_4bitsest(/*AUTOINST*/
							// Outputs
							.data_out2x1_estructural_4b(data_out2x1_estructural_4b[3:0]),
							.valid_output	(valid_output),
							// Inputs
							.clk		(clk),
							.data_in0_4b	(data_in0_4b[3:0]),
							.data_in1_4b	(data_in1_4b[3:0]),
							.reset_L	(reset_L),
							.selector	(selector),
							.valid_input	(valid_input));


	// Descripcion conductual del MUX con memoria 4x1 de 4 bits
	mux_memoria4x1_4bitsconductual	mux4x1_4bitscond(/*AUTOINST*/
							 // Outputs
							 .valid_output		(valid_output),
							 .data_out4x1_conductual_4b(data_out4x1_conductual_4b[3:0]),
							 // Inputs
							 .clk			(clk),
							 .reset_L		(reset_L),
							 .selector4x1		(selector4x1[1:0]),
							 .valid_input		(valid_input),
							 .data_in0_4x1_4b	(data_in0_4x1_4b[3:0]),
							 .data_in1_4x1_4b	(data_in1_4x1_4b[3:0]),
							 .data_in2_4x1_4b	(data_in2_4x1_4b[3:0]),
							 .data_in3_4x1_4b	(data_in3_4x1_4b[3:0]));

	// Descripcion estructural del MUX con memoria 4x1 de 4 bits
	mux_memoria4x1_4bitsestructural	mux4x1_4bitsest(/*AUTOINST*/
							// Outputs
							.data_out4x1_estructural_4b(data_out4x1_estructural_4b[3:0]),
							.valid_output	(valid_output),
							// Inputs
							.clk		(clk),
							.data_in0_4x1_4b(data_in0_4x1_4b[3:0]),
							.data_in1_4x1_4b(data_in1_4x1_4b[3:0]),
							.data_in2_4x1_4b(data_in2_4x1_4b[3:0]),
							.data_in3_4x1_4b(data_in3_4x1_4b[3:0]),
							.reset_L	(reset_L),
							.selector4x1	(selector4x1[1:0]),
							.valid_input	(valid_input));
						

	// Probador: generador de señales y monitor, depende del MUX que se este probando
	probador 	prob(/*AUTOINST*/
			     // Outputs
			     .clk		(clk),
			     .reset_L		(reset_L),
			     .selector		(selector),
			     .valid_input	(valid_input),
			     .data_in0		(data_in0[1:0]),
			     .data_in1		(data_in1[1:0]),
			     .data_in0_4b	(data_in0_4b[3:0]),
			     .data_in1_4b	(data_in1_4b[3:0]),
			     .selector4x1	(selector4x1[1:0]),
			     .data_in0_4x1_4b	(data_in0_4x1_4b[3:0]),
			     .data_in1_4x1_4b	(data_in1_4x1_4b[3:0]),
			     .data_in2_4x1_4b	(data_in2_4x1_4b[3:0]),
			     .data_in3_4x1_4b	(data_in3_4x1_4b[3:0]),
			     // Inputs
			     .valid_output	(valid_output),
			     .data_out2x1_conductual(data_out2x1_conductual[1:0]),
			     .data_out2x1_estructural(data_out2x1_estructural[1:0]),
			     .data_out2x1_conductual_4b(data_out2x1_conductual_4b[3:0]),
			     .data_out2x1_estructural_4b(data_out2x1_estructural_4b[3:0]),
			     .data_out4x1_conductual_4b(data_out4x1_conductual_4b[3:0]));


endmodule
