; This bot can kind of escape rooms

; Overclock the CPU to 20 cycles per second (helps with beam sensor)
push8 #20
push8 #IO_OVERCLOCK
io

start:

sensor:
; Read beam sensor
push8 #IO_SENSOR
io
pop8 type
popf distance
jmp check_type:

check_type:
push8 type
push8 #4
and
jnz get_gold
jmp right

get_gold:
; Maximum Speed
pushf 1.0
push8 #IO_MOTOR
io

right:
 Steer right
pushf 1.0
push8 #IO_STEER
io
pushf 0.0
push8 #IO_STEER
io

jmp sensor

type: dbf 0
distance: dbf 0.0
wander: dbf 0.0
