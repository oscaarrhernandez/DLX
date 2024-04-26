.data 
;; VARIABLES DE ENTRADA Y SALIDA: NO MODIFICAR ORDEN 
; VARIABLE DE ENTRADA: (SE PODRA MODIFICAR EL VALOR ENTRE 1 Y 100) 
valor_inicial:   .word   7
 
;; VARIABLES DE SALIDA: 
secuencia:   .space  120*4 
secuencia_tamanho:  .word   0 
secuencia_maximo:  .word   0 
secuencia_valor_medio: .float  0  
lista:    .space    9*4 
lista_valor_medio:  .float  0 
;; FIN VARIABLES DE ENTRADA Y SALIDA 
PrintFormat: .asciiz "%d\n"
						 .align  2
PrintPar:    .word PrintFormat
Printvalue:  .space 4


.text
.global main

main:
		lw r4,valor_inicial

		movi2fp f1, r4
		cvti2f f1,f1

		addi r1,r0,secuencia
		sf 0(r1),f1
		addi r1,r1, #4

		addi r2,r0,1

		movi2fp f5, r2
		cvti2f f5,f5

		addi r3,r0,3
		movi2fp f3, r3
		cvti2f f3,f3


loop:
		subi r8,r4,1
		jal print
		beqz r8,guardar
		
		addi r2,r2,1

		andi r8,r4,1
		beqz r8,par
		bnez r8,impar

par:
		srli r6,r4,1
		add r4,r6,r0

		movi2fp f1,r4
		cvti2f f1,f1
		
		sf 0(r1),f1
		addi r1,r1,#4

		j loop

impar:
		multf f8,f1,f3
		addf f8,f8,f5
		
		movf f1,f8

		sf 0(r1),f1
		addi r1,r1,#4

		j loop

print:
		sw Printvalue, r6 ; A[n] tienes que imprimir
		addi r14,r0,PrintPar
		trap 5
		jr r31

guardar:
		movi2fp f2,r2
		cvti2f f2,f2
		sf secuencia_tamanho,f2


		j finish

finish:
		trap 0
