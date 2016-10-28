; If it spins 360 AND sees a distance of 256, we want it to move forward
; that distance of 256
; Overclock the CPU to 20 cycles per second (helps with beam sensor)
push8 #100
push8 #IO_OVERCLOCK
io

compass:
push8 #IO_COMPASS
io
popf facing

sensor:
; Read beam sensor
push8 #IO_SENSOR
io
pop8 type
popf distance
jmp check_type:

check_type:
push8 type
push8 #12
and
jnz get_gold
pushf 0.0
push8 #IO_MOTOR
io
jmp right

get_gold:
; Maximum Speed
pushf 1.0
push8 #IO_MOTOR
io
jmp sensor

check_256:
pushf -1.0
push8 #IO_STEER
io
pushf 0.0
push8 #IO_STEER
io
push8 #IO_SENSOR
io
pop8 type
pushf 256.0
and
jnz wander

wander:

right:
pushf 1.0
push8 #IO_STEER
io
pushf 0.0
push8 #IO_STEER
io
; push8 &curr_compass
; jsr
; pushf facing
; pushf curr
; and
; jnz check_256     ;they are the same
jmp sensor

curr_compass:
push8 #IO_COMPASS
io
popf curr
ret

type: dbf 0
distance: dbf 0.0
facing: dbf 0.0
curr: dbf 0.0
