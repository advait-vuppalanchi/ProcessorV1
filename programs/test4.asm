movi R0, 12
movi R1, 34
movi R2, 56
movi R3, 78
movi R4, AA
movi R5, 55
movi R6, F0
movi R7, 0F

movs R0
add R1
movd R2

movs R2
sub R2
movd R3

movs R4
xor R5
movd R4

movs R4
cmi 0F

movs R4
ani F0
movd R5

movs R5
ori 03
movd R6

movs R6
xri FF
movd R7

movs R7
sbi 10
movd R8

movs R8
adi 05
movd R9

movs R9
and R4
movd R10

movs R10
or R4
movd R11

movs R11
xor R1
movd R0

movs R0
sub R0
movd R1

movs R1
ori 80
movd R2

movs R2
ani F0
movd R3

movs R3
xri 55
movd R4

movs R4
adi 01
movd R5

movs R5
sbi 20
movd R6

movs R6
or R7
movd R7

stop