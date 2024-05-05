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

		movi2fp f1, r4 ; mover dato de r4 a f1
		cvti2f f1,f1 ; convertir (cvt) integer (i) 2(to) f(float)

		addi r1,r0,secuencia ; indice de secuencia en r1
		sf 0(r1),f1 ; guardar en la direccion de r1 (secuencia[0]) f1
		addi r1,r1, #4 ; apuntamos con r1 a la siguiente direccion de memoria secuencia[1]

		addi r2,r0,1 ; contador de secuencia_tam
		addi r3,r0,3

mayor:
		movf f4,f1

loop:
		subi r8,r4,1 ; r8 = r4-1
		add r13,r13,r4
		beqz r8,jump ; if (r8 == 0)jump
		
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

		j loop


jump:
		movi2fp f2, r2 ; movemos el dato de r2 a f2
		cvti2f f2,f2 ; convertimos a float
		sf secuencia_tamanho,f2 ; guardamos en la variable secuencia_tamanho el valor de f2

		j calculos ; if (r2 == 0) calculos


calculos:
		movf f11,f1
		movi2fp f10,r13
		cvti2f f10,f10 ; Sumasecuencia

		sf secuencia_maximo,f4 ; guardamos en secuencia_maximo el valor de f4
		; f10 -> suma secuencia
		; f11 -> vIni
		; f4  -> vMax
		; f2  -> vT
		; f12 -> vMed

		divf f12,f10,f2 ; f12 = sumasecuencia / tamaño secuencia = vMed
		sf secuencia_valor_medio,f12 ; guardamos el valor de f12 en la variable

		addi r1,r0,lista
		;vIni*vT
		multf f15,f11,f2
		sf 0(r1),f15
		addi r1,r1,#4
		;vMax*vT
		multf f16,f4,f2
		sf 0(r1),f16
		addi r1,r1,#4
		;vMed*vT
		multf f17,f12,f2
		sf 0(r1),f17
		addi r1,r1,#4
		;(vIni/vMax)*vT
		divf f18,f11,f4
		multf f19,f18,f2
		sf 0(r1),f19
		addi r1,r1,#4
		;(vIni/vMed)*vT
		divf f20,f11,f12
		multf f21,f20,f2
		sf 0(r1),f21
		addi r1,r1,#4
		;(vMax/vIni)*vT
		divf f22,f4,f11
		multf f23,f22,f2
		sf 0(r1),f23
		addi r1,r1,#4
		;(vMax/vMed)*vT
		divf f24,f4,f12
		multf f25,f24,f2
		sf 0(r1),f25
		addi r1,r1,#4
		;(vMed/vIni)*vT
		divf f26,f12,f11
		multf f27,f26,f2
		sf 0(r1),f27
		addi r1,r1,#4
		;(vMed/vMax)*vT
		divf f28,f12,f4
		multf f29,f28,f2
		sf 0(r1),f29
		addi r1,r1,#4

		;lista_valor_medio
		addi r15,r0,9
		movi2fp f9, r15
		cvti2f f9,f9

		addf f30,f0,f15
		addf f30,f30,f16
		addf f30,f30,f17
		addf f30,f30,f19
		addf f30,f30,f21
		addf f30,f30,f23
		addf f30,f30,f25
		addf f30,f30,f27
		addf f30,f30,f29


		divf f31,f30,f9
		sf lista_valor_medio,f31


		j finish

finish:
		trap 0
