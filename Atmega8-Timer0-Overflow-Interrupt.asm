.include	"m8def.inc"
.list
.def		temp0 = R16

.cseg
.org			0

rjmp			init			; Переход на начало программы
rjmp			return			; External Interrupt 0
rjmp			return			; External Interrupt 1
rjmp			return			; Timer2 Compare A Handler
rjmp			return			; Timer2 Overflow Handler
rjmp			return			; Timer1 Capture Handler
rjmp			return			; Timer1 Compare A Handler
rjmp			return			; Timer1 Compare B Handler
rjmp			return			; Timer1 Overflow Handler
rjmp			TIM0			; Timer0 Overflow Handler
rjmp			return			; SPI Transfer Complete Handler
rjmp			return			; USART, RX Complete Handler
rjmp			return			; USART, UDR Empty Handler
rjmp			return			; USART, TX Complete Handler
rjmp			return			; ADC Conversion Complete Handler
rjmp			return			; EEPROM Ready Handler
rjmp			return			; Analog Comparator Handler
rjmp			return			; TWI Two-wire Serial Interface
rjmp			return			; SPM_RDY Store Program Memory Ready

init:
ldi			temp0, low(RAMEND)
out			SPL, temp0
ldi			temp0, high(RAMEND)
out			SPH, temp0

ldi			temp0, 0xFF
out			DDRD, temp0
ldi			temp0, 0x00
out			PORTD, temp0

;ldi			temp0, 0b00000000
;out			GICR, temp0

ldi			temp0, 0b00000001
out			TIMSK, temp0

ldi			temp0, 0b11111100
out			TCNT0, temp0

ldi			temp0, 0b00000001
out			TCCR0, temp0

sei

Loop:
rjmp  Loop

; --------------------Interrupts Handlers
return:
reti

TIM0:
ldi			temp0, 0xff
out			PORTD, temp0
reti