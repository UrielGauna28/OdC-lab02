	.ifndef FUNCTION
	FUNCTION: 
			.include "./functions.s"
	.equ SCREEN_WIDTH,   640
	.equ SCREEN_HEIGH,   480
	.equ BITS_PER_PIXEL, 32
	.equ GPIO_BASE,    0x3f200000
	.equ GPIO_GPFSEL0, 0x00
	.equ GPIO_GPLEV0,  0x34
	

	.globl main



	


main:
	// x0 contiene la direccion base del framebuffer
	mov x20, x0 // Guarda la dirección base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------

	movz x11, 0x16, lsl 16
	movk x11, 0x1233, lsl 00


    // Llama a la función para pintar un cuadrado
	
    mov x1, 0// Coordenada X inicial del cuadrado
    mov x2, 240  // Coordenada Y inicial del cuadrado
    mov x3, 120 // Tamaño X del cuadrado
    mov x4, 240  // Tamaño Y del cuadrado
	bl draw_square

	
	

    mov x1, 120  // Coordenada X inicial del cuadrado
    mov x2, 320  // Coordenada Y inicial del cuadrado
    mov x3, 80 // Tamaño X del cuadrado
    mov x4, 300  // Tamaño Y del cuadrado
    bl draw_square
	

	
    mov x1, 200  // Coordenada X inicial del cuadrado
    mov x2, 245  // Coordenada Y inicial del cuadrado
    mov x3, 100// Tamaño X del cuadrado
    mov x4, 300  // Tamaño Y del cuadrado
    bl draw_square

	

	mov x1, 300  // Coordenada X inicial del cuadrado
    mov x2, 225  // Coordenada Y inicial del cuadrado
    mov x3, 100 // Tamaño X del cuadrado
    mov x4, 300  // Tamaño Y del cuadrado
    bl draw_square
	
	
	mov x1, 400  // Coordenada X inicial del cuadrado
    mov x2, 305  // Coordenada Y inicial del cuadrado
    mov x3, 95  // Tamaño X del cuadrado
    mov x4, 300  // Tamaño Y del cuadrado
    bl draw_square

	
	mov x1, 495  // Coordenada X inicial del cuadrado
    mov x2, 325  // Coordenada Y inicial del cuadrado
    mov x3, 70  // Tamaño X del cuadrado
    mov x4, 300  // Tamaño Y del cuadrado
    bl draw_square
	
		
	mov x1, 565  // Coordenada X inicial del cuadrado
    mov x2, 290  // Coordenada Y inicial del cuadrado
    mov x3, 75  // Tamaño X del cuadrado
    mov x4, 300  // Tamaño Y del cuadrado
    bl draw_square
	

	
	movz x11, 0xFF, lsl 16
	movk x11, 0xFF00, lsl 00
	mov x1, 30  // Coordenada X inicial del cuadrado
    mov x2, 250  // Coordenada Y inicial del cuadrado
    mov x3, 75  // Tamaño X del cuadrado
    mov x4, 60  // Tamaño Y del cuadrado
    bl draw_square



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
	.endif

InfLoop:
	b InfLoop
