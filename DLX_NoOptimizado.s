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
		lw r4,valor_inicial ; cargar valor inicial en r4

		movi2fp f1, r4 ; mover dato de r4 a f1
		cvti2f f1,f1 ; convertir (cvt) integer (i) 2(to) f(float)

		addi r1,r0,secuencia ; indice de secuencia en r1
		sf 0(r1),f1 ; guardar en la direccion de r1 (secuencia[0]) f1
		addi r1,r1, #4 ; apuntamos con r1 a la siguiente direccion de memoria secuencia[1]

		addi r2,r0,1 ; contador de secuencia_tam
		addi r3,r0,3

loop:
		subi r8,r4,1 ; r8 = r4-1
		beqz r8,jump ; if (r8 == 0)jump
		
		addi r2,r2,1 ; r2++

		andi r9,r4,1 ; r9 = r4 && 1
		beqz r9,par ; if (r9 == 0)par
		;impar
		mult r10,r4,r3 ; r10 = r4 x r3 -> r4 x 3
		addi r10,r10,1 ; r10 = r10 + 1 
		add r4,r10,r0 ; r4 = r10 

		movi2fp f1,r4 ; movemos el dato de r4 a f1
		cvti2f f1,f1 ; convertimos a float

		sf 0(r1),f1 ; guardamos en secuencia 
		addi r1,r1,#4 ; apuntamos a la siguiente dirección de memoria de secuencia

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
		addf f10,f0,f0 ; f10 = 0
		addi r1,r0,secuencia ; reiniciamos el indice de secuencia al principio
		lf f4,0(r1) ; cargamos f4 con el valor de secuencia
		lf f11,0(r1); cargamos f11 con el valor de secuencia -> para hacer el sumatorio
		addf f10,f10,f4 ; f10 = f4
		addi r1,r1,#4 ; apuntamos a la siguiente direccion de memoria
		subi r2,r2,1 ; restamos a r2(el secuencia_tamanho pero en registro no en float) 1
		beqz r2,calculos ; if (r2 == 0) calculos

		lf f5, 0(r1) ; cargamos f5 con el valor de secuencia 
		addf f10,f10,f5 ; f10 = f10+f5
		addi r1,r1,#4 ; apuntamos a la siguiente direccion de memoria

		j loopmax
		;;;;;; f4 tiene el primer valor de secuencia
		;;;;;; f5 tiene el segundo valor de secuencia
loopmax:
		subi r2,r2,1 ; restamos 1 al tamaño 
		beqz r2,calculos ; if (r2 == 0) calculos
		gef f4,f5 ; gef -> greater equal f4 >= f5
							; bit de comparación en el registro de estado de FP
		bfpt simayor ; Test de bit de comparación en el registro de estado FP. Bifurca si cierto. salta a simayor -> f4 >= f5
		bfpf simenor ; Test de bit de comparación en el registro de estado FP. Bifurca si falso. salta a simenor -> f4 < f5
		j loopmax

simayor:
		lf f5, 0(r1) ; cargar f5 (el nomayor de los dos) con el siguiente valor de secuencia
		addf f10,f10,f5 ; f10 = f10+f5
		addi r1,r1,#4 ; apuntamos a la siguiente direccion de memoria
		j loopmax

simenor:
		lf f4,0(r1) ; cargar f4 (el nomayor de los dos) con el siguiente valor de secuencia
		addf f10,f10,f4 ; f10 = f10+f4
		addi r1,r1,#4 ; apuntamos a la siguiente direccion de memoria
		j loopmax

calculos:
		sf secuencia_maximo,f5 ; guardamos en secuencia_maximo el valor de f5
		; f10 -> suma secuencia
		; f11 -> vIni
		; f5  -> vMax
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
