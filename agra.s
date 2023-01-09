
	.file	"agra_main.c"
	.text
	.align	2

	.arch armv5te
	.syntax unified
	.arm
	.fpu softvfp
	.global	draw_a_pixel
	.type draw_a_pixel, %function

draw_a_pixel:        @this is the code for pixel function
    .fnstart
    mul r0,r1,r0     @finding the new offset for the pixel in the framebuffer array
    add r0, r0, r2 	
    ldr r1, =#0x2020202A		 @'*' is 42 in ASCII

    str  r1, [r0]	 @storing in memory
    bx lr
    .fnend


	.global	draw_a_line
	.type	draw_a_line, %function
draw_a_line:
.LFB6:

	.cfi_startproc                 @function starts

	push	{r4, r5, fp, lr}       @stacking starts

	add	fp, sp, #12                

	sub	sp, sp, #32
	str	r0, [fp, #-32]
	str	r1, [fp, #-36]
	str	r2, [fp, #-40]
	str	r3, [fp, #-44]             @stacking ends

	mov	r3, #0					   @ creating variable							
	str	r3, [fp, #-20]	           @ using framepointer to keep track of variables

	mov	r3, #0					   @ creating variable
	str	r3, [fp, #-28]			   @ using framepointer to keep track of variables

	ldr	r0, [fp, #-44]
	bl	__aeabi_i2f
.LVL0:							  @ start performing calculation for finding slope of line	
	mov	r4, r0

	ldr	r0, [fp, #-36]
	bl	__aeabi_i2f
.LVL1:
	mov	r3, r0

	mov	r1, r3
	mov	r0, r4
	bl	__aeabi_fsub
.LVL2:
	mov	r3, r0
	mov	r5, r3

	ldr	r0, [fp, #-40]
	bl	__aeabi_i2f
.LVL3:
	mov	r4, r0

	ldr	r0, [fp, #-32]
	bl	__aeabi_i2f
.LVL4:
	mov	r3, r0

	mov	r1, r3
	mov	r0, r4
	bl	__aeabi_fsub
.LVL5:
	mov	r3, r0

	mov	r1, r3
	mov	r0, r5
	bl	__aeabi_fdiv			@ start performing calculation for finding slope of line
.LVL6:
	mov	r3, r0         			@ creating variable
	str	r3, [fp, #-20]			@ using framepointer to keep track of variables

	mov	r3, #0
	str	r3, [fp, #-16]			
.LBB2:							@loop Block begins
   								
	mov	r3, #0					@loop variable
	str	r3, [fp, #-24]

	b	.L2
.L5:
								@calculating next y point using slope calculation
	ldr	r0, [fp, #-24]
	bl	__aeabi_i2f
.LVL7:
	mov	r3, r0
	ldr	r1, [fp, #-20]	@ float
	mov	r0, r3
	bl	__aeabi_fmul
.LVL8:
	mov	r3, r0
	mov	r4, r3

	ldr	r0, [fp, #-32]
	bl	__aeabi_i2f
.LVL9:
	mov	r3, r0

	mov	r1, r3
	mov	r0, r4
	bl	__aeabi_fadd
.LVL10:
	mov	r3, r0
	str	r3, [fp, #-16]	
								@ checking condition for proper formating of line
	ldr	r3, .L6
	ldr	r3, [r3]
	mov	r0, r3
	bl	__aeabi_i2f
.LVL11:
	mov	r3, r0
	ldr	r1, [fp, #-16]	
	mov	r0, r3
	bl	__aeabi_fmul
.LVL12:
	mov	r3, r0
	mov	r4, r3

	ldr	r0, [fp, #-24]
	bl	__aeabi_i2f
.LVL13:
	mov	r3, r0
	mov	r1, r3
	mov	r0, r4
	bl	__aeabi_fadd
.LVL14:
	mov	r3, r0

	mov	r0, r3
	bl	__aeabi_f2iz
.LVL15:
	mov	r1, r0
	ldr	r3, .L6
	ldr	r2, [r3]
	ldr	r3, [fp, #-28]
	add	r3, r2, r3

	cmp	r1, r3
	bgt	.L3

	ldr	r3, [fp, #-28]
	cmp	r3, #0
	beq	.L3
						@ storing '*' in the framebuffer
	ldr	r3, .L6+4
	ldr	r4, [r3]

	ldr	r3, .L6
	ldr	r3, [r3]
	mov	r0, r3
	bl	__aeabi_i2f
.LVL16:
	mov	r3, r0
	ldr	r1, [fp, #-16]	@ float
	mov	r0, r3
	bl	__aeabi_fmul
.LVL17:
	mov	r3, r0
	mov	r5, r3

	ldr	r0, [fp, #-24]
	bl	__aeabi_i2f
.LVL18:
	mov	r3, r0
	mov	r1, r3
	mov	r0, r5
	bl	__aeabi_fadd
.LVL19:
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2iz
.LVL20:
	mov	r3, r0
	add	r3, r4, r3
	mov	r2, #42
	strb	r2, [r3]
	b	.L4
.L3:
						       @ more calculations for formating
	ldr	r3, .L6
	ldr	r3, [r3]
	mov	r0, r3
	bl	__aeabi_i2f
.LVL21:
	mov	r3, r0
	ldr	r1, [fp, #-16]	
	mov	r0, r3
	bl	__aeabi_fmul
.LVL22:
	mov	r3, r0
	mov	r4, r3

	ldr	r0, [fp, #-24]
	bl	__aeabi_i2f
.LVL23:
	mov	r3, r0
	mov	r1, r3
	mov	r0, r4
	bl	__aeabi_fadd
.LVL24:
	mov	r3, r0

	mov	r0, r3
	bl	__aeabi_f2iz
.LVL25:
	mov	r3, r0
	str	r3, [fp, #-28]
.L4:								@checking condition for loop

	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L2:								@checking condition for loop

	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-40]
	cmp	r2, r3
	ble	.L5
.LBE2:								@ unstacking

	sub	sp, fp, #12

	pop	{r4, r5, fp, pc}
.L7:
	.align	2
.L6:
	.word	buff_length
	.word	buffer
	.cfi_endproc


.LFE6:

	.align	2
	.global	draw_a_circle
	.syntax unified
	.arm
	.fpu softvfp
	.type	draw_a_circle, %function

draw_a_circle:
.LFB7:
	.cfi_startproc					@function starts
	str	fp, [sp, #-4]!				@stacking starts

	add	fp, sp, #0
	.cfi_def_cfa_register 11
	sub	sp, sp, #44
	str	r0, [fp, #-32]
	str	r1, [fp, #-36]
	str	r2, [fp, #-40]				@stacking ends
					
	mov	r3, #0						@creating a new variable
	str	r3, [fp, #-28]
.LBB3:

	mov	r3, #0						@start of outer loop 
	str	r3, [fp, #-24]

	b	.L9
.L13:
.LBB4:

	mov	r3, #0						@start of inner loop
	str	r3, [fp, #-20]

	b	.L10
.L12:
.LBB5:
		
	ldr	r2, [fp, #-20]				@calculation for finding new x point from center
	ldr	r3, [fp, #-32]
	sub	r3, r2, r3
	str	r3, [fp, #-16]
									@calculation for finding new x point from center
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-24]
	sub	r3, r2, r3
	str	r3, [fp, #-12]

	ldr	r3, [fp, #-16]				@calcultions for equation x^2+y^2=r^2 starts
	mul	r2, r3, r3

	ldr	r3, [fp, #-12]
	mov	r1, r3
	mul	r1, r3, r1
	mov	r3, r1

	add	r3, r2, r3
	str	r3, [fp, #-8]				@calcultions for equation x^2+y^2=r^2 starts

	ldr	r3, [fp, #-40]				@calcultions for findng points in framebuffer that satisfy eqution x^2+y^2=r^2 starts
	mov	r2, r3	
	mul	r2, r3, r2
	mov	r3, r2

	sub	r3, r3, #4

	ldr	r2, [fp, #-8]
	cmp	r2, r3
	blt	.L11

	ldr	r3, [fp, #-40]
	mov	r2, r3
	mul	r2, r3, r2
	mov	r3, r2

	add	r3, r3, #4
		
	ldr	r2, [fp, #-8]				
	cmp	r2, r3						@calcultions for findng points in framebuffer that satisfy eqution x^2+y^2=r^2 starts
	bgt	.L11

	ldr	r3, .L14					@storing '*' in framebuffer
	ldr	r2, [r3]
	ldr	r3, [fp, #-28]
	add	r3, r2, r3

	mov	r2, #42
	strb	r2, [r3]
.L11:

	ldr	r3, [fp, #-28]				@updating indexing variable for buffer
	add	r3, r3, #1
	str	r3, [fp, #-28]
.LBE5:

	ldr	r3, [fp, #-20]				@updating indexing variable for inner loop
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L10:									@outer loop checking condition

	ldr	r3, .L14+4
	ldr	r3, [r3]

	ldr	r2, [fp, #-20]
	cmp	r2, r3
	blt	.L12
.LBE4:
		
	ldr	r3, [fp, #-24]					@updating indexing variable for outer loop
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L9:
							@outer loop checking condition
	ldr	r3, .L14+8
	ldr	r3, [r3]
	ldr	r2, [fp, #-24]
	cmp	r2, r3
	blt	.L13
.LBE3:									@unstacking
	add	sp, fp, #0
	ldr	fp, [sp], #4

	bx	lr
.L15:
	.align	2
.L14:
	.word	buffer
	.word	buff_length
	.word	buff_heigth
	.cfi_endproc

