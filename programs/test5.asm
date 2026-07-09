movi R10, F0
movi R11, F1

movi R0, 12
movi R1, 34
movi R2, 56
movi R3, AA

movs R10
stor R0

movs R11
stor R1

movi R0, 00
movi R1, 00

movs R10
load R4

movs R11
load R5

movs R4
add R5
movd R6

movs R6
adi 10
movd R7

movs R7
xri FF
movd R8

movs R8
ani F0
movd R9

movs R9
ori 0A
movd R0

movs R0
sub R4
movd R1

movs R1
xor R5
movd R2

movs R2
and R3
movd R3

movs R3
or R6
movd R4

movs R4
sbi 20
movd R5

movs R5
adi 01
movd R6

stop