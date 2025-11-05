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
#include <stdio.h>                                                                                                                                      
#include <stdint.h>

static uint32_t seed = 42;

void srand(uint32_t s) { seed = s;}

unsigned long pseudo_rand(uint32_t max) {
    seed = (1664525 * seed + 1013904223) % 0xFFFFFFFF;
    return seed % max;
}                                                        
