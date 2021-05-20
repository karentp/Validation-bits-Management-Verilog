//++++++++++MODULO PROBADOR PARA MUX CON MEMORIA: GENERADOR DE SEÑALES Y MONITOR DE DATOS +++++++++++++++

module probador( 

    //Entradas y salidas generales
    
    input valid_output,
    output reg clk,
    output reg reset_L,
    output reg selector,
    output reg valid_input,

    //Entradas y salidas mux 2x1 de 2 bits

    input  [1:0] data_out2x1_conductual,
    input  [1:0] data_out2x1_estructural,
    output reg [1:0] data_in0,
    output reg [1:0] data_in1,

    //Entradas y salidas mux 2x1 de 4 bits
    input  [3:0] data_out2x1_conductual_4b,
    input  [3:0] data_out2x1_estructural_4b,
    output reg [3:0] data_in0_4b,
    output reg [3:0] data_in1_4b,

    //Entradas y salidas mux 4x1 de 4 bits
    output reg [1:0] selector4x1,
    output reg [3:0] data_in0_4x1_4b, //entrada 4 bits
    output reg [3:0] data_in1_4x1_4b, //entrada 4 bits
    output reg [3:0] data_in2_4x1_4b, //entrada 4 bits
    output reg [3:0] data_in3_4x1_4b, //entrada 4 bits
    input [3:0] data_out4x1_conductual_4b //salida 4 bits


    
    );


	// Bloque de procedimiento, no sintetizable, se recorre una unica vez
    reg dummy1, dummy2;

	initial begin
        // Nombre de archivo del "dump"
		$dumpfile("mux_memoria_valid.vcd");

        // Directiva para "dumpear" variables	
		$dumpvars;		
	
		// Mensaje que se imprime en consola una vez
		$display ("\t\ttiempo\t\tclk,\tselector,\treset_L\tvalid_input\tdata_in0,\tdata_in1,\tdata_out conductual\tdata_out estructural\tvalid_output");

		// Mensaje que se imprime en consola cada vez que un elemento de la lista cambia
		$monitor($time,"\t\t%b\t%b\t\t%b\t%b\t\t%b\t\t%b\t\t%b\t\t%b\t\t%b", clk, selector, reset_L, valid_input,data_in0, data_in1, data_out2x1_conductual, data_out2x1_estructural,valid_output);

        // Asignamos valores 

        //Generales
        {selector} = 1'b0;
        {reset_L} = 1'b1;
        {valid_input} = 1'b1;
        {dummy1, dummy2} = 1'b0;

        //Mux 2x1 2bits
        {data_in0} = 2'b01; 
        {data_in1} = 2'b00;

        //Mux 2x1 4bits
        {data_in0_4b} = 4'b0001; 
        {data_in1_4b} = 4'b0000;

        //Mux 4x1 4 bits
        {selector4x1} = 2'b00;
        {data_in0_4x1_4b} <= 4'b0000;
        {data_in1_4x1_4b} <= 4'b0010; 
        {data_in2_4x1_4b} <= 4'b1100;
        {data_in3_4x1_4b} <= 4'b0001;
        // Repite 8 veces
		repeat (12) begin

            // Espera/sincroniza con el flanco positivo del reloj	
            @(posedge clk);	

            // Suma 1 a cada entrada
            //Generales
            { selector} <= {selector} +1;
            { valid_input,dummy1} <= {valid_input, dummy1} +1;
            { reset_L,dummy1} <= {reset_L, dummy1} +1;
           

            //Mux 2x1 2 bits
            {data_in0, data_in1} <= {data_in0, data_in1} + 1; 

            //Mux 2x1 4bits
            {data_in0_4b} <= {data_in0_4b} + 1; 
            {data_in1_4b} <= {data_in1_4b} + 1; 

            //Mux 4x1 4bits
            { selector4x1} <= {selector4x1} +1;
            {dummy1, data_in1_4x1_4b} <= {dummy1, data_in1_4x1_4b} + 1; 
            {dummy2, data_in3_4x1_4b} <= {dummy2, data_in3_4x1_4b} + 1; 
            {data_in0_4x1_4b, dummy2} <= {data_in0_4x1_4b, dummy2} + 1; 
            {data_in2_4x1_4b, dummy1} <= {data_in2_4x1_4b, dummy1} + 1; 

             
    

		end

		@(posedge clk);

        // Asigna un tipo bit con valor 0

        {selector} <= 1'b0;
        {reset_L} <= 1'b0;
        {valid_input} <= 1'b0;

        //Mux 2x1 4 bits
        {data_in0} <= 2'b00; 
        {data_in1} <= 2'b00;

        //Mux 2x1 4 bits
        {data_in0_4b} <= 4'b0000; 
        {data_in1_4b} <= 4'b0000;

        //Mux 4x1 4bits
        {data_in0_4x1_4b} <= 4'b0000; 
        {data_in1_4x1_4b} <= 4'b0000;
        {data_in2_4x1_4b} <= 4'b0000; 
        {data_in3_4x1_4b} <= 4'b0000;

        // Termina de almacenar señales
		$finish;

	end

	// Reloj

    //Valor inicial del reloj para que no sea indeterminado
	initial	clk 	<= 0;	

    //Toggle cada 2*10 nano segundos		
	always	#2 clk 	<= ~clk;
    		
endmodule
