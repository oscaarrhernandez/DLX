;secuencia[0]=valor_inicial
;secuencia[n] :
;					si secuencia[n-1] par: (secuencia[n-1])/2
;					si secuencia[n-1] impar: secuencia[n-1]x3+1
;Hasta secuencia[n-1]=1

.data
;; VARIABLES DE ENTRADA Y SALIDA: NO MODIFICAR ORDEN
; VARIABLE DE ENTRADA: (SE PODRA MODIFICAR EL VALOR ENTRE 1 Y 100)
valor_inicial: .word 7
;; VARIABLES DE SALIDA:
secuencia: .space 120*4
secuencia_tamanho: .word 0
secuencia_maximo: .word 0
secuencia_valor_medio: .float 0
lista: .space 9*4
lista_valor_medio: .float 0
;; FIN VARIABLES DE ENTRADA Y SALIDA
PrintFormat: .asciiz "%d\n"
						 .align  2
PrintPar:    .word PrintFormat
Printvalue:  .space 4


.text
.global main

; r0 -> 0
; r1 -> secuencia
; r2 -> tamano
; r3 -> 3
; r4 -> valor

main:

		lw r4, valor_inicial

		movi2fp f1, r4
		cvti2f f1,f1

		addi r1,r0,secuencia
		sf 0(r1),f1
		addi r1,r1, #4
		
		addf f5,f0,f1 ; f5 = vMax
		
		lw r2, secuencia_tamanho
									; f1 = A[n-1]
		addf f2,f0,f1 ; f2 = A[n]


		add r3,r0,3
		movi2fp f3, r3

loop:
		subf f4,f2,1
		jal print

		beqz f4,finish

		addi r2,r2,1

		andi f4,f2,1
		beqz f4,par
		multf f2,f3,f1
		addf f2,f2,1
		addf f1,f2,f0

		sf 0(r1),f1
		addi r1,r1, #4

		j loop

par:
		srli f2,f1,1
		addf f1,f2,f0
		sf 0(r1),f1
		addi r1,r1, #4


print:
	sw Printvalue,r4
	addi r14,r0,PrintPar
	trap 5
	jr r31

finish:

	trap 0
