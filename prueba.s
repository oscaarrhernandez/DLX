.data 
;; VARIABLES DE ENTRADA Y SALIDA: NO MODIFICAR ORDEN 
; VARIABLE DE ENTRADA: (SE PODRA MODIFICAR EL VALOR ENTRE 1 Y 100) 
valor_inicial:   .word   10
 
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

		movi2fp f2, r2
		cvti2f f2,f2

		addi r3,r0,3
		movi2fp f3, r3
		cvti2f f3,f3


loop:
		subi r8,r4,1
		beqz r8,jump
		
		addi r2,r2,1

		andi r9,r4,1
		beqz r9,par
		;impar
		mult r10,r4,r3
		addi r10,r10,1
		add r4,r10,r0

		movi2fp f1,r4
		cvti2f f1,f1

		sf 0(r1),f1
		addi r1,r1,#4


		j loop

par:
		srli r6,r4,1
		add r4,r6,r0

		movi2fp f1,r4
		cvti2f f1,f1
		
		sf 0(r1),f1
		addi r1,r1,#4

		j loop



jump:
		movi2fp f2, r2
		cvti2f f2,f2
		sf secuencia_tamanho,f2
		addf f1,f0,f0
		addi r1,r0,secuencia
		lf f4,0(r1)
		;addi f1,f1,0(r1)
		addi r1,r1,#4
		subi r2,r2,1
		beqz r2,finish

		lf f5, 0(r1)
		;add f1,f1,0(r1)
		addi r1,r1,#4

		j loopmax

loopmax:
		subi r2,r2,1
		beqz r2,finish
		gef f4,f5
		bfpt simayor
		bfpf simenor


		j loopmax

simayor:
		lf f5, 0(r1)
		;add f1,f1,0(r1)
		addi r1,r1,#4
		j loopmax

simenor:
		lf f4,0(r1)
		addi r1,r1,#4
		j loopmax
finish:

		sf secuencia_maximo,f5

		trap 0
