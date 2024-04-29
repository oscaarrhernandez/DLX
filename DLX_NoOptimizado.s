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
		addf f10,f0,f0
		addi r1,r0,secuencia
		lf f4,0(r1)
		lf f11,0(r1)
		addf f10,f10,f4
		addi r1,r1,#4
		subi r2,r2,1
		beqz r2,calculos

		lf f5, 0(r1)
		addf f10,f10,f5
		addi r1,r1,#4

		j loopmax

loopmax:
		subi r2,r2,1
		beqz r2,calculos
		gef f4,f5
		bfpt simayor
		bfpf simenor
		j loopmax

simayor:
		lf f5, 0(r1)
		addf f10,f10,f5
		addi r1,r1,#4
		j loopmax

simenor:
		lf f4,0(r1)
		addf f10,f10,f4
		addi r1,r1,#4
		j loopmax

calculos:
		sf secuencia_maximo,f5
		; f10 -> suma secuencia
		; f11 -> vIni
		; f5  -> vMax
		; f2  -> vT
		; f12 -> vMed
		divf f12,f10,f2
		sf secuencia_valor_medio,f12

		addi r1,r0,lista
		;vIni*vT
		multf f15,f11,f2
		sf 0(r1),f15
		addi r1,r1,#4
		;vMax*vT
		multf f16,f5,f2
		sf 0(r1),f16
		addi r1,r1,#4
		;vMed*vT
		multf f17,f12,f2
		sf 0(r1),f17
		addi r1,r1,#4
		;(vIni/vMax)*vT
		divf f18,f11,f5
		multf f19,f18,f2
		sf 0(r1),f19
		addi r1,r1,#4
		;(vIni/vMed)*vT
		divf f20,f11,f12
		multf f21,f20,f2
		sf 0(r1),f21
		addi r1,r1,#4
		;(vMax/vIni)*vT
		divf f22,f5,f11
		multf f23,f22,f2
		sf 0(r1),f23
		addi r1,r1,#4
		;(vMax/vMed)*vT
		divf f24,f5,f12
		multf f25,f24,f2
		sf 0(r1),f25
		addi r1,r1,#4
		;(vMed/vIni)*vT
		divf f26,f12,f11
		multf f27,f26,f2
		sf 0(r1),f27
		addi r1,r1,#4
		;(vMed/vMax)*vT
		divf f28,f12,f5
		multf f29,f28,f2
		sf 0(r1),f29
		addi r1,r1,#4

		j finish

finish:
		trap 0
