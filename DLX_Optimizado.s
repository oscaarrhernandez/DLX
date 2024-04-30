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


.text
.global main

main:
		lw r4,valor_inicial ; cargar valor inicial en r4

		addi r1,r0,secuencia+4 ; apuntamos con r1 a la siguiente direccion de memoria secuencia[1]


		movi2fp f1, r4 ; mover dato de r4 a f1
		cvti2f f1,f1 ; convertir (cvt) integer (i) 2(to) f(float)
		
		addf f4,f0,f1 ; valorA de compación
		movf f11,f1


		addi r2,r0,1 ; contador de secuencia_tam
		addi r3,r0,3

mayor:
		movf f4,f1

loop:
		subi r8,r4,1 ; r8 = r4-1
		addf f10,f10,f1
		beqz r8,calculos ; if (r8 == 0)calculos
		
		
		andi r9,r4,1 ; r9 = r4 && 1
		
		addi r2,r2,1 ; r2++

		beqz r9,par ; if (r9 == 0)par
		;impar
		; AQUI HAY Stall
		mult r10,r4,r3 ; r10 = r4 x r3 -> r4 x 3
		addi r4,r10,1 ; r4 = r10 +1

		movi2fp f1,r4 ; movemos el dato de r4 a f1
		cvti2f f1,f1 ; convertimos a float

		sf 0(r1),f1 ; guardamos en secuencia 
		addi r1,r1,#4 ; apuntamos a la siguiente dirección de memoria de secuencia
		
		gtf f4,f1
		bfpf mayor

		j loop


par:
		srli r6,r4,1 ; r6 = r4/2
		add r4,r6,r0 ; r4 = r6

		movi2fp f1,r4 ; movemos el dato de r4 a f1
		cvti2f f1,f1 ; convertimos a float
		
		sf 0(r1),f1 ; guardamos en secuencia 
		addi r1,r1,#4 ; apuntamos a la siguiente dirección de memoria de secuencia

		gef f4,f1
		bfpf mayor

		j loop

calculos:
;lista_valor_medio
divf f18,f11,f4



		movi2fp f2, r2
		cvti2f f2,f2
		
		addi r15,r0,9
divf f12,f10,f2
		

		movi2fp f9, r15
		cvti2f f9,f9

		multf f15,f11,f2
		multf f16,f4,f2
		addf f30,f0,f15
		multf f17,f12,f2
		multf f19,f18,f2
		addf f30,f30,f16
divf f20,f11,f12
		addf f30,f30,f17
		multf f21,f20,f2
		addf f30,f30,f19
divf f22,f4,f11
		addf f30,f30,f21
		multf f23,f22,f2
divf f24,f4,f12
		multf f25,f24,f2
		addf f30,f30,f23
divf f26,f12,f11
		addf f30,f30,f25
		multf f27,f26,f2
divf f28,f12,f4
		addf f30,f30,f27
		multf f29,f28,f2
		

		addf f30,f30,f29

		divf f31,f30,f9
		sf secuencia+0,f11
		sf lista+0,f15
		sf lista+4,f16
		sf lista+8,f17
		sf lista+12,f19
		sf lista+16,f21
		sf lista+20,f23
		sf lista+24,f25
		sf lista+28,f27
		sf lista+32,f29
		sf secuencia_tamanho,f2
		sf secuencia_maximo,f4
		sf secuencia_valor_medio,f12
		sf lista_valor_medio,f31

		trap 0
