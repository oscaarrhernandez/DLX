.data 
;; VARIABLES DE ENTRADA Y SALIDA: NO MODIFICAR ORDEN 
; VARIABLE DE ENTRADA: (SE PODRA MODIFICAR EL VALOR ENTRE 1 Y 100) 
valor_inicial:   .word   97
 
;; VARIABLES DE SALIDA: 
secuencia:   .space  120*4 
secuencia_tamanho:  .word   0 
secuencia_maximo:  .word   0 
secuencia_valor_medio: .float  0  
lista:    .space    9*4 
lista_valor_medio:  .float  0 
;; FIN VARIABLES DE ENTRADA Y SALIDA 
nueve: .float 0.111111
uno: .float 1

.text
.global main

main:
		lw r4,valor_inicial
		addi r1,r0, secuencia+4

		lf f5,uno
		lf f9,nueve


		movi2fp f1, r4
		cvti2f f1,f1
		addf f4,f0,f1
		divf f3,f5,f1
		movf f11,f1
		addi r2,r0,1



mayor:
		movf f4,f1 ; copiamos el dato de f1 a f4, dejando en f4 de nuevo el maximo valor de la lista

loop:
		subi r8,r4,1 ; r8 = r4-1
		add r13,r13,r4
		beqz r8,calculos ; if (r8 == 0)calculos
		
		andi r9,r4,1 ; r9 = r4 && 1
		
		addi r2,r2,1 ; r2++

		beqz r9,par ; if (r9 == 0)par
		;impar
		slli r10,r4,1 ; r10 = r4*2
		add r4,r10,r4 ; r4 = r10 +r4 -> r4 = r4*2 + r4
		addi r4,r4,1 ; r4 = r4 +1

		movi2fp f1,r4 ; movemos el dato de r4 a f1
		cvti2f f1,f1 ; convertimos a float

		sf 0(r1),f1 ; guardamos en secuencia 
		addi r1,r1,#4 ; apuntamos a la siguiente dirección de memoria de secuencia
		
		gtf f4,f1 ; comparamos si f4 > f1
		bfpf mayor ; en caso de que no sea saltamos a mayor. bfpf -> branch if false; bfpt -> branch if true



		subi r8,r4,1 ; r8 = r4-1
		add r13,r13,r4
		beqz r8,calculos ; if (r8 == 0)calculos
		
		andi r9,r4,1 ; r9 = r4 && 1
		
		addi r2,r2,1 ; r2++

		beqz r9,par ; if (r9 == 0)par
		;impar
		slli r10,r4,1 ; r10 = r4*2
		add r4,r10,r4 ; r4 = r10 +r4 -> r4 = r4*2 + r4
		addi r4,r4,1 ; r4 = r4 +1

		movi2fp f1,r4 ; movemos el dato de r4 a f1
		cvti2f f1,f1 ; convertimos a float

		sf 0(r1),f1 ; guardamos en secuencia 
		addi r1,r1,#4 ; apuntamos a la siguiente dirección de memoria de secuencia
		
		gtf f4,f1 ; comparamos si f4 > f1
		bfpf mayor ; en caso de que no sea saltamos a mayor. bfpf -> branch if false; bfpt -> branch if true

j loop


par:
		srli r6,r4,1 ; r6 = r4/2
		add r4,r6,r0 ; r4 = r6

		movi2fp f1,r4 ; movemos el dato de r4 a f1
		cvti2f f1,f1 ; convertimos a float
		
		sf 0(r1),f1 ; guardamos en secuencia 
		addi r1,r1,#4 ; apuntamos a la siguiente dirección de memoria de secuencia


		subi r8,r4,1 ; r8 = r4-1
		add r13,r13,r4
		beqz r8,calculos ; if (r8 == 0)calculos

		andi r9,r4,1 ; r9 = r4 && 1
		
		addi r2,r2,1 ; r2++

		beqz r9,par ; if (r9 == 0)par
		;impar
		slli r10,r4,1 ; r10 = r4*2
		add r4,r10,r4 ; r4 = r10 +r4 -> r4 = r4*2 + r4
		addi r4,r4,1 ; r4 = r4 +1

		movi2fp f1,r4 ; movemos el dato de r4 a f1
		cvti2f f1,f1 ; convertimos a float

		sf 0(r1),f1 ; guardamos en secuencia 
		addi r1,r1,#4 ; apuntamos a la siguiente dirección de memoria de secuencia
		
		gtf f4,f1 ; comparamos si f4 > f1
		bfpf mayor ; en caso de que no sea saltamos a mayor. bfpf -> branch if false; bfpt -> branch if true
		

		subi r8,r4,1 ; r8 = r4-1
		add r13,r13,r4
		beqz r8,calculos ; if (r8 == 0)calculos

		andi r9,r4,1 ; r9 = r4 && 1
		
		addi r2,r2,1 ; r2++

		beqz r9,par ; if (r9 == 0)par
		;impar
		slli r10,r4,1 ; r10 = r4*2
		add r4,r10,r4 ; r4 = r10 +r4 -> r4 = r4*2 + r4
		addi r4,r4,1 ; r4 = r4 +1

		movi2fp f1,r4 ; movemos el dato de r4 a f1
		cvti2f f1,f1 ; convertimos a float

		sf 0(r1),f1 ; guardamos en secuencia 
		addi r1,r1,#4 ; apuntamos a la siguiente dirección de memoria de secuencia
		
		gtf f4,f1 ; comparamos si f4 > f1
		bfpf mayor ; en caso de que no sea saltamos a mayor. bfpf -> branch if false; bfpt -> branch if true

j loop

calculos:
; f3 -> 1/vIni
; f5 = 1
; f7 -> 1/vMax
; f8 -> 1/vMed
; f12 -> SecuenciaMedio
; f15 -> vini*vt
; f16 -> vmax*vt
; f17 -> vini*vt* 1/vmax
; f18 -> vini*vt* 1/vmed
; f21 -> suma* 1/vini
; f19 -> vmax*vt* 1/vini
; f20 -> vmax*vt* 1/vmed
; f22 -> suma* 1/vmax
		divf f7,f5,f4
		movi2fp f10,r13

		cvti2f f10,f10 ; Sumasecuencia

		multf f21,f10,f3
		movi2fp f2, r2

		cvti2f f2,f2 ; secuenciatamaño

		multf f15,f11,f2

		multf f16,f4,f2

		addf f30,f10,f15
		;SecuenciaMedio
		divf f12,f10,f2

		addf f30,f30,f16

		sf secuencia_tamanho,f2
		sf secuencia_maximo,f4

		multf f17,f15,f7

		sf lista+8,f10


		sf secuencia+0,f11
		sf lista+0,f15
		sf lista+4,f16
		sf secuencia_valor_medio,f12

		divf f8,f5,f12

		addf f30,f30,f21

		multf f18,f15,f8

		addf f30,f30,f17

		multf f19,f16,f3

		sf lista+16,f18
		addf f30,f30,f18

		multf f20,f16,f8

		addf f30,f30,f19

		addf f30,f30,f20

		multf f22,f10,f7

		sf lista+20,f19
		sf lista+24,f20
		sf lista+28,f21

		addf f30,f30,f22

		
		multf f31,f30,f9
		sf lista+12,f17
		sf lista+32,f22

		sf lista_valor_medio,f31
		trap 0
