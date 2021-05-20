//++++++++++MODULO PROBADOR PARA MUX CON MEMORIA: GENERADOR DE SEÑALES Y MONITOR DE DATOS +++++++++++++++

module probador( 
    
    input  [3:0] data_out2x1_conductual_4b,
    input  [3:0] data_out2x1_estructural_4b,
    input valid_output,
    output reg clk,
    output reg reset_L,
    output reg selector,
    output reg valid_input,
    output reg [3:0] data_in0_4b,
    output reg [3:0] data_in1_4b
    
    );


	// Bloque de procedimiento, no sintetizable, se recorre una unica vez
    reg dummy1, dummy2;

	initial begin
        // Nombre de archivo del "dump"
		$dumpfile("mux_memoria_valid.vcd");

        // Directiva para "dumpear" variables	
		$dumpvars;		
	
		// Mensaje que se imprime en consola una vez
		$display ("\t\ttiempo\t\tclk,\tselector,\treset_L\tvalid_input\tdata_in0_4b,\tdata_in1_4b,\tdata_out conductual\tdata_out estructural\tvalid_output");

		// Mensaje que se imprime en consola cada vez que un elemento de la lista cambia
		$monitor($time,"\t\t%b\t%b\t\t%b\t%b\t\t%b\t\t%b\t\t%b\t\t%b\t\t%b", clk, selector, reset_L, valid_input,data_in0_4b, data_in1_4b, data_out2x1_conductual_4b, data_out2x1_estructural_4b,valid_output);

        // Asignamos valores 
		{data_in0_4b} = 3'b0001; 
        {data_in1_4b} = 3'b0000;
        {selector} = 1'b0;
        {reset_L} = 1'b0;
        {valid_input} = 1'b1;
        {dummy1, dummy2} = 1'b0;
        
        // Repite 8 veces
		repeat (15) begin

            // Espera/sincroniza con el flanco positivo del reloj	
            @(posedge clk);	

            // Suma 1 a cada entrada
            {data_in0_4b} <= {data_in0_4b} + 1; 
            {data_in1_4b} <= {data_in1_4b} + 1; 
            //data_in0_4b <= data_in0_4b +1;
            { selector, reset_L} <= {selector, reset_L} +1;
            //{ selector, valid_input} <= {selector, valid_input} +1;
            { valid_input,dummy1} <= {valid_input, dummy1} +1;
            //{ reset_L} <= {reset_L} +1;

		end

		@(posedge clk);

        // Asigna un tipo bit con valor 0
        {data_in0_4b} <= 4'b0000; 
        {data_in1_4b} <= 4'b0000;
        {selector} <= 1'b0;
        {reset_L} <= 1'b0;
        {valid_input} <= 1'b0;

        // Termina de almacenar señales
		$finish;

	end

	// Reloj

    //Valor inicial del reloj para que no sea indeterminado
	initial	clk 	<= 0;	

    //Toggle cada 2*10 nano segundos		
	always	#2 clk 	<= ~clk;
    		
endmodule
