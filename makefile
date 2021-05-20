CONDUCTUAL2x1 = mux_memoria2x1_conductual.v
YS2x1 = sintesis2x1.ys
YS2x14b = sintesis2x14b.ys
YS4x14b = sintesis4x14b.ys
BANCO  = BancoPrueba_conductual_estructural.v





all: 4x1_4bit


sintesis_mux2x1: $(YS2x1)
	@echo ----------------------------------
	@echo Corriendo Sintesis Completa para el Mux 2x1: 
	@echo ----------------------------------
	yosys $(YS2x1)
	@echo ----------------------------------
	@echo Cambiando nombre al module para evitar problemas:
	@echo ----------------------------------
	sed -i 's/mux_memoria2x1_conductual/mux_memoria2x1_estructural/' mux_memoria2x1_estructural.v
	sed -i 's/data_out2x1_conductual/data_out2x1_estructural/' mux_memoria2x1_estructural.v

sintesis_mux2x14b: $(YS2x14b)
	@echo ----------------------------------
	@echo Corriendo Sintesis Completa para el Mux 2x1: 
	@echo ----------------------------------
	yosys $(YS2x14b)
	@echo ----------------------------------
	@echo Cambiando nombre al module para evitar problemas:
	@echo ----------------------------------
	sed -i 's/mux_memoria2x1_4bitsconductual/mux_memoria2x1_4bitsestructural/' mux_memoria2x1_4bitsestructural.v
	sed -i 's/data_out2x1_conductual_4b/data_out2x1_estructural_4b/' mux_memoria2x1_4bitsestructural.v

sintesis_mux4x14b: $(YS4x14b)
	@echo ----------------------------------
	@echo Corriendo Sintesis Completa para el Mux 4x1: 
	@echo ----------------------------------
	yosys $(YS4x14b)
	@echo ----------------------------------
	@echo Cambiando nombre al module para evitar problemas:
	@echo ----------------------------------
	sed -i 's/mux_memoria4x1_4bitsconductual/mux_memoria4x1_4bitsestructural/' mux_memoria4x1_4bitsestructural.v
	sed -i 's/data_out4x1_conductual_4b/data_out4x1_estructural_4b/' mux_memoria4x1_4bitsestructural.v
	sed -i 's/mux_memoria2x1_conductual/mux_memoria2x1_conductual_inst/' mux_memoria4x1_4bitsestructural.v
	

prueba_mux2x1: $(BANCO) cmos_cells.v  probador.v
	@echo ----------------------------------
	@echo Corriendo pruebas del estructural y conductual 2x1:
	@echo ----------------------------------
	iverilog -o prueba.vvp $(BANCO) cmos_cells.v mux_memoria2x1_conductual.v mux_memoria2x1_estructural.v 
	emacs --batch .\BancoPrueba_conductual_estructural.v  -f verilog-batch-auto
	iverilog -o prueba.vvp $(BANCO) cmos_cells.v  mux_memoria2x1_conductual.v mux_memoria2x1_estructural.v 
	vvp prueba.vvp

prueba_mux2x14b: $(BANCO) cmos_cells.v  probador_2x1_4bits.v
	@echo ----------------------------------
	@echo Corriendo pruebas del estructural y conductual 2x1 de 4 bits:
	@echo ----------------------------------
	iverilog -o prueba.vvp $(BANCO) cmos_cells.v mux_memoria2x1_estructural.v mux_memoria2x1_4bitsestructural.v 
	emacs --batch .\BancoPrueba_conductual_estructural.v  -f verilog-batch-auto 
	iverilog -o prueba.vvp $(BANCO) cmos_cells.v mux_memoria2x1_estructural.v mux_memoria2x1_4bitsestructural.v 
	vvp prueba.vvp

prueba_mux4x14b: $(BANCO) cmos_cells.v  probador_2x1_4bits.v
	@echo ----------------------------------
	@echo Corriendo pruebas del estructural y conductual 4x1 de 4 bits:
	@echo ----------------------------------
	iverilog -o prueba.vvp $(BANCO) cmos_cells.v mux_memoria2x1_estructural.v mux_memoria2x1_4bitsestructural.v  mux_memoria4x1_4bitsestructural.v 
	emacs --batch .\BancoPrueba_conductual_estructural.v  -f verilog-batch-auto 
	iverilog -o prueba.vvp $(BANCO) cmos_cells.v mux_memoria2x1_estructural.v mux_memoria2x1_4bitsestructural.v  mux_memoria4x1_4bitsestructural.v 
	vvp prueba.vvp

2x1_2bit:
	@echo ----------------------------------
	@echo Sintesis, pruebas y gtkwave del MUX 2X1 de 2 bits:
	@echo ----------------------------------
	$(MAKE) sintesis_mux2x1
	$(MAKE) prueba_mux2x1
	gtkwave mux_memoria_valid.vcd

2x1_4bit:
	@echo ----------------------------------
	@echo Sintesis, pruebas y gtkwave del MUX 2X1 de 4 bits:
	@echo ----------------------------------
	$(MAKE) sintesis_mux2x14b
	$(MAKE) prueba_mux2x14b
	gtkwave mux_memoria_valid.vcd

4x1_4bit:
	@echo Sintesis, pruebas y gtkwave del MUX 2X1 de 2 bits:
	@echo ----------------------------------
	$(MAKE) sintesis_mux2x1
	@echo ----------------------------------
	@echo ----------------------------------
	@echo Sintesis, pruebas y gtkwave del MUX 2X1 de 4 bits:
	@echo ----------------------------------
	$(MAKE) sintesis_mux2x14b
	@echo Sintesis, pruebas y gtkwave del MUX 2X1 de 4 bits:
	@echo ----------------------------------
	$(MAKE) sintesis_mux4x14b
	$(MAKE) prueba_mux4x14b
	gtkwave mux_memoria_valid.vcd



	

	
