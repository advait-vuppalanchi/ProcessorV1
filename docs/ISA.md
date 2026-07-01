# DSM Processor — ISA Specification

A simple 8-bit accumulator-based processor implemented in Verilog,
based on "Design of a Simple Processor" by Prof P.J. Narayanan, IIIT Hyderabad.

## Overview
- Word width: 8 bits
- All data and instructions are 8 bits wide
- Register file: R0–R11 (12 general purpose registers, 3-bit select)
- Memory: 256 bytes (8-bit address space)
- Architecture: Single bus, accumulator-based

## Internal Registers

| Register | Width | Purpose |
|----------|-------|---------|
| AR | 8-bit | Accumulator. Source and destination of all ALU ops |
| OR | 8-bit | Operand Register. Holds right operand for ALU |
| PC | 8-bit | Program Counter. Address of next instruction to fetch |
| IR | 8-bit | Instruction Register. Holds current fetched opcode |
| MAR | 8-bit | Memory Address Register. Holds address for memory access |
| R0–R11 | 8-bit each | General purpose register file |

## Instruction Format

All instructions are 8 bits (1 word). Some instructions
need a second word for an immediate operand (marked as 2-word).

For register-type instructions, the lower 4 bits of the
opcode encode which register is being used:

  [7:4] — operation (upper 4 bits)
  [3:0] — register select (R0=000, R1=001, ... R7=111)

Example:
  add R0 = 0001 0000 = 0x10
  add R3 = 0001 0011 = 0x13
  sub R5 = 0010 0101 = 0x25

## Instruction Set

### Arithmetic and Logic Instructions

| Assembly Instruction | Opcode Range | Words | Action |
|----------|-------------|-------|--------|
| add R | 0x10–0x1B | 1 | AR ← AR + R |
| sub R | 0x20–0x2B | 1 | AR ← AR - R |
| xor R | 0x30–0x3B | 1 | AR ← AR XOR R |
| and R | 0x40–0x4B | 1 | AR ← AR AND R |
| or R | 0x50–0x5B | 1 | AR ← AR OR R |
| cmp R | 0x60-0x6B | 1 | Compare AR and R (updates flags only) |

### Immediate mode

| Assembly Instruction | Opcode | Words | Action |
|----------|-------------|-------|--------|
| addi xx | 0x01 | 2 | AR ← AR + xx |
| subi xx | 0x02 | 2 | AR ← AR - xx |
| xri xx | 0x03 | 2 | AR ← AR XOR xx |
| ani xx | 0x04 | 2 | AR ← AR AND xx |
| ori xx | 0x05 | 2 | AR ← AR OR xx |
| cmi xx | 0x06 | 2 | Compare AR and xx (updates flags only) |

### Data Movement

| Assembly Instruction | Opcode Range | Words | Action |
|----------|-------------|-------|--------|
| movs R | 0x70–0x7B | 1 | AR ← R (move register to accumulator) |
| movd R | 0x80–0x8B | 1 | R ← AR (move accumulator to register) |
| movi R xx | 0x90–0x9B | 2 | R ← xx (load immediate into register) |
| stor R | 0xA0–0xAB | 1 | Mem[AR] ← R (store register to memory) |
| load R | 0xB0–0xBB | 1 | R ← Mem[AR] (load from memory to register) |

### Control

| Assembly Instruction | Opcode | Words | Action |
|----------|--------|-------|--------|
| nop | 0x00 | 1 | Do nothing |
| stop | 0x07 | 1 | Halt processor |

## ALU Operation Select Codes

The ALU select lines (SALU) are internal — not visible
to the programmer but needed for Verilog implementation.

| SALU | Operation | Used By |
|------|-----------|---------|
| 000 | ADD | `add`, `adi` |
| 001 | SUB | `sub`, `sbi`, `cmp` |
| 010 | AND | `and`, `ani` |
| 011 | OR | `or`, `ori` |
| 100 | XOR | `xor`, `xri` |
| 101 | PASS0 (Pass Left Input) | `movs` |

## Sample Program — Add Two Numbers

Goal: compute 5 + 3, store result in R2

Assembly:
  movi R0, 5     ; R0 = 5
  movi R1, 3     ; R1 = 3
  movs R0        ; AR = R0 = 5
  add  R1        ; AR = AR + R1 = 8
  movd R2        ; R2 = AR = 8
  stop

Machine code (hex):
  Address  Hex    Meaning
  0x00     0x90   movi R0 (opcode)
  0x01     0x05   immediate value 5
  0x02     0x91   movi R1 (opcode)
  0x03     0x03   immediate value 3
  0x04     0x70   movs R0
  0x05     0x11   add R1
  0x06     0x82   movd R2
  0x07     0x07   stop