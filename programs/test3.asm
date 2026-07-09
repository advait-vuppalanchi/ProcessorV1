movi R10, F0
movi R11, F1

movi R0, 3C
movi R1, A5

movs R10
stor R0

movs R11
stor R1

movi R0, 00
movi R1, 00

movs R10
load R2

movs R11
load R3

movs R2
add R3
movd R4

movs R3
xor R2
movd R5

movs R4
sbi 10
movd R6

stop