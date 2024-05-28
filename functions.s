	.equ SCREEN_WIDTH,   640
	.equ SCREEN_HEIGH,   480
	.equ BITS_PER_PIXEL, 32
	.equ GPIO_BASE,    0x3f200000
	.equ GPIO_GPFSEL0, 0x00
	.equ GPIO_GPLEV0,  0x34

draw_square: 
	mov x0, x20
	mov x6, SCREEN_WIDTH

	mov x7, 4

    mov x8, x2
    mul x8, x8, x6
    add x8, x8, x1
    lsl x8, x8, 2
    add x0, x0, x8

    mov x13, x4
    mov x12, x3 //TAMAÑO X

	loop_square0: 
		mov x5, x12

    loop_square:
        stur w11, [x0]
        add x0, x0, 4
        sub x5, x5, 1
        cbnz x5, loop_square
		sub x0,x0, x12, lsl 2
		add x0, x0, x6, lsl 2
		sub x13, x13, 1 
		cbnz x13, loop_square0

	ret
