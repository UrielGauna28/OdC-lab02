	.equ SCREEN_WIDTH,   640
	.equ SCREEN_HEIGH,   480
	.equ cuadrado_width,   64
	.equ cuadrado_heigh,   64
	.equ pos_x, 100 // Posición X de la línea
	.equ pos_y, 200 // Posición Y de la línea
	.equ BITS_PER_PIXEL, 32
	.equ GPIO_BASE,    0x3f200000
	.equ GPIO_GPFSEL0, 0x00
	.equ GPIO_GPLEV0,  0x34

	
	.include "funciones.s"
	.globl main
	


main:
	// x0 contiene la direccion base del framebuffer
	mov x20, x0 // Guarda la dirección base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------

	movz x10, 0xff, lsl 16
	movk x10, 0xffff, lsl 00
	


	mov x2, SCREEN_WIDTH         // X Size
	mov x3,4
	
	mov x4,190
	mul x4,x4,x2
	add x4,x4,279
	

	

loop1:
	
	mov x1, SCREEN_HEIGH         // Y Size
loop0:	
	loop_a: // lineas rectas cada 
		stur w10,[x0]  // Colorear el pixel N
		add x0,x0,2560 // Siguiente pixel
		sub x0,x0,2560
		add x0,x0,320
		stur w10,[x0]
		sub x1,x1,1
		loop_b:	
			stur w10,[x5]
			add x5,x5,1
			sub x1,x1,5
			cbz x1, loop_b
			
			
			
		
		cbnz x1,loop_a

		
	
	
	sub x1,x1,1    // Decrementar contador X
	cbz x1,loop0  // Si no terminó la fila, salto
	sub x2,x2,1    // Decrementar contador Y
	cbnz x2,loop1  // Si no es la última fila, salto

	// Ejemplo de uso de gpios
	mov x9, GPIO_BASE

	// Atención: se utilizan registros w porque la documentación de broadcom
	// indica que los registros que estamos leyendo y escribiendo son de 32 bits

	// Setea gpios 0 - 9 como lectura
	str wzr, [x9, GPIO_GPFSEL0]

	// Lee el estado de los GPIO 0 - 31
	ldr w10, [x9, GPIO_GPLEV0]

	// And bit a bit mantiene el resultado del bit 2 en w10 (notar 0b... es binario)
	// al inmediato se lo refiere como "máscara" en este caso:
	// - Al hacer AND revela el estado del bit 2
	// - Al hacer OR "setea" el bit 2 en 1
	// - Al hacer AND con el complemento "limpia" el bit 2 (setea el bit 2 en 0)
	and w11, w10, 0b00000010

	// si w11 es 0 entonces el GPIO 1 estaba liberado
	// de lo contrario será distinto de 0, (en este caso particular 2)
	// significando que el GPIO 1 fue presionado
	
	//---------------------------------------------------------------
	// Infinite Loop

	

	

	
	
InfLoop:
	b InfLoop
