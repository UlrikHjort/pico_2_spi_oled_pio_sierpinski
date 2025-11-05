/**************************************************************************
--          PICO2 RISC-V Sierpinski OLED SPI Bitbang
-- 
--           Copyright (C) 2025 By Ulrik Hørlyk Hjort
--
--  This Program is Free Software; You Can Redistribute It and/or
--  Modify It Under The Terms of The GNU General Public License
--  As Published By The Free Software Foundation; Either Version 2
--  of The License, or (at Your Option) Any Later Version.
--
--  This Program is Distributed in The Hope That It Will Be Useful,
--  But WITHOUT ANY WARRANTY; Without Even The Implied Warranty of
--  MERCHANTABILITY or FITNESS for A PARTICULAR PURPOSE.  See The
--  GNU General Public License for More Details.
--
-- You Should Have Received A Copy of The GNU General Public License
-- Along with This Program; if not, See <Http://Www.Gnu.Org/Licenses/>.
***************************************************************************/
	.section .text
    .global sierpinski
    .type   sierpinski, @function
    .extern OLED_putpixel
	.extern pseudo_rand

/*
The Sierpinski trinagle algorithm as implemented 
below in assembler shown here in c: 


void draw_sierpinski() {
        const uint32_t x1 = 64;
        const uint32_t y1 = 0;

        const uint32_t x2 = 0;
        const uint32_t y2 = 63;

        const uint32_t x3 = 127;
        const uint32_t y3 = 64;

        uint32_t xp = 50;
        uint32_t yp = 50;
		uint32_t i = 1000; 

        while(i) {
			xp = (x1 + xp) /2;
			yp = (y1 + yp) /2;              
			OLED_putpixel(xp,yp);
			xp = (x2 + xp) /2;
			yp = (y2 + yp) /2;              
			OLED_putpixel(xp,yp);
			xp = (x3 + xp) /2;
			yp = (y3 + yp) /2;              
			
			OLED_putpixel(xp,yp);
			i--;
        }                        
}
*/
	
	.equ A1, 64
	.equ A2, 0
	.equ B1, 0
	.equ B2, 63
	.equ C1, 127
	.equ C2, 64
	.equ P1, 50
	.equ P2, 50
	
sierpinski:
    addi sp, sp, -24
    sw   ra, 16(sp)
	sw   s0, 0(sp)
	sw   s1, 4(sp)
	sw   s2, 8(sp)
	sw   s3, 12(sp)		

	li a0, A1
	li a1, A2
	jal ra, OLED_putpixel
	li a0, B1
	li a1, B2
	jal ra, OLED_putpixel
	li a0, C1
	li a1, C2
	jal ra, OLED_putpixel
	li s3, 3000
	li s1, P1
	li s2, P2

loop:
	li a0,3
	jal ra, pseudo_rand
	mv t0, a0
	mv a0, s1
	mv a1, s2

	li t1, 0
	beq t0,t1, R1
	li t1, 1
	beq t0,t1, R2
	j R3
	
R1:	
	addi a0, a0,A1
	srli a0,a0,1
	addi a1, a1,A2
	srli a1,a1,1
	mv s1,a0
	mv s2,a1	
	jal ra, OLED_putpixel
	j cont
R2:	
	addi a0, a0,B1
	srli a0,a0,1
	addi a1, a1,B2
	srli a1,a1,1
	mv s1,a0
	mv s2,a1	
	jal ra, OLED_putpixel
	j cont
R3:	
	addi a0, a0,C1
	srli a0,a0,1
	addi a1, a1,C2
	srli a1,a1,1
	mv s1, a0
	mv s2, a1	
	jal ra, OLED_putpixel	
	j cont
cont:	
	addi s3,s3, -1
	bne s3, zero, loop

	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)	
	lw   ra, 16(sp)    
    addi sp, sp, 24
    ret
