	.equ SCREEN_WIDTH,   640
	.equ SCREEN_HEIGH,   480
	.equ BITS_PER_PIXEL, 32
	.equ CUA, 100
	.equ CUA2, 50
	.equ TRIAN, 100
	.equ GPIO_BASE,    0x3f200000
	.equ GPIO_GPFSEL0, 0x00
	.equ GPIO_GPLEV0,  0x34

	.globl main
	

main:
	// x0 contiene la direccion base del framebuffer
	mov x20, x0 // Guarda la dirección base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------

	movz x10, 0x16, lsl 16
	movk x10, 0x6866, lsl 00
	
	movz x11, 0xed, lsl 16
	movk x11, 0x9277, lsl 00

	mov x2, SCREEN_HEIGH         // Y Size
	
loop1:
	mov x1, SCREEN_WIDTH         // X Size
loop0:
	stur w10,[x0]  // Colorear el pixel N
	add x0,x0,4    // Siguiente pixel
	sub x1,x1,1    // Decrementar contador X
	cbnz x1,loop0  // Si no terminó la fila, salto
	sub x2,x2,1    // Decrementar contador Y
	cbnz x2,loop1  // Si no es la última fila, salto 
	
	
	mov x0, x20 // reactivo el estado de x0 al inicial
	mov x2, SCREEN_WIDTH
	
	// proporciono la ubicacion donde quiero que comience a dibujar
	mov x3, 4 //guardo el 4 para luego usarlo en la ubicacion de inicio
	
	mov x4, 190        // Coordenada Y
    mul x4, x4, x2  // y * SCREEN_WIDTH
    add x4, x4, 270    // y * SCREEN_WIDTH + x
    lsl x4, x4, 2             // (y * SCREEN_WIDTH + x) * 4 (cada píxel son 4 bytes)
    add x0, x0, x4 
	
	mov x9, CUA
	
	mov x6, CUA // Y size
loop3:
	mov x5, CUA // X size
loop2:
	stur w11, [x0] //pinta primer pixel
	add x0, x0, 4 // sig pixel
	sub x5, x5, 1 //decremento tamaño de x
	cbnz x5, loop2 // si la fila no termino paso a la sig
	sub x0, x0, x9, lsl 2 // Restar el tamaño del cuadrado en bytes para volver al inicio de la fila
	add x0, x0, x2, lsl 2 // Mover a la siguiente fila en la pantalla
	sub x6, x6, 1 // Decrementar contador Y
	cbnz x6, loop3 // Si no es la última fila del cuadrado, repetir

//comienzo a hacer triangulo
    movz x11, 0xd0, lsl 16
    movk x11, 0xF3F3, lsl 00

    mov x0, x20 // reactivo el estado de x0 al inicial
    mov x2, SCREEN_WIDTH
    
    // proporciono la ubicacion donde quiero que comience a dibujar
    mov x3, 4 //guardo el 4 para luego usarlo en la ubicacion de inicio
    
    // Calcular la dirección inicial del triángulo
    mov x4, 290  // Coordenada Y
    mul x4, x4, x2  // y * SCREEN_WIDTH
    add x4, x4, 270  // y * SCREEN_WIDTH + x
    lsl x4, x4, 2  // (y * SCREEN_WIDTH + x) * 4 (cada píxel son 4 bytes)
    add x0, x0, x4

    mov x6, TRIAN // Y size
    mov x8, TRIAN           // Inicializar el tamaño X
    mov x12, 0

loop5:
    mov x5, x8 // X size
    mov x12, x8
loop4:
    stur w11, [x0] // Pinta el pixel
    add x0, x0, 4 // Siguiente pixel
    sub x5, x5, 1 // Decrementar tamaño de X
    cbnz x5, loop4 // Si la fila no terminó, sigue pintando la fila

    // Mover a la siguiente fila del triángulo
    sub x0, x0, x12, lsl 2 // Volver al inicio de la fila
    add x0, x0, x2, lsl 2 // Mover a la siguiente fila en la pantalla
	add x0, x0, 4
    sub x8, x8, 2 // Reducir el tamaño X para la siguiente fila
    sub x6, x6, 1 // Decrementar contador Y
    cbnz x6, loop5 // Si no es la última fila del triángulo, repetir





	
    
	
	

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
