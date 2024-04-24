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

; r0 -> 0													 r1 -> secuencia
; r2 -> indice de la secuencia		 r3 -> valor 3 para la multiplicacion
; r4 -> tamaño_secuencia					 r5 -> valor inicial
; r6 A[n-1] -> almacenamos siempre este valor en la secuencia
; r7 A[n]
; r8 comprobacion salida de bucle  r9 comprobacion si es impar
; r14 -> PrintPar 								 r31 -> finish
; r10 -> valor maximo							 r11 -> valor medio

main:
		lw r5,valor_inicial ;Cargar valor inicial
		add r6,r0,r5 ; Pasamos a r6 el valor inicial

		addi r1,r0,secuencia ;Cargar la primera posicion secuencia
		sb 0(r1),r0
		addi r1, r1, #4 ;Mover a la siguiente posición de la secuencia
		sb 0(r1),r6 ;Guardar valor inicial en la secuencia
		addi r1, r1, #4 ;Mover a la siguiente posición de la secuencia

		add r10,r0,r6 ;Cargar valor maximo

    ;addi r2,r0,1 ;indice de la secuencia
		lw r4,secuencia_tamanho ;Cargar tamaño de la secuencia
		addi r4,r0,1 ; r4(registro de tamsecuencia) = 1
		sw secuencia_tamanho,r4 ;Guardar tamaño de la secuencia
		
		add r7,r0,r6; A[n]
		add r3,r0,3 ; valor 3 usado en x3

loop:
		subi r8,r6,1 ; r6-1=r8 ;;;; si A[n-1] es 1 finaliza
		jal print ; imprimir por terminal el valor de A[n]

		sb 0(r1),r6 ; Guardar A[n-1] en la secuencia
		addi r1,r1,4 ; Mover a la siguiente posición de la secuencia

		beqz r8, finbucle ; r8 = A[n-1]-1 == 0 saltar a finbucle

		addi r4,r4,1 ; suma 1 a tamsecuencia
		sw secuencia_tamanho,r4 ;Guardar tamaño de la secuencia

		andi r9,r6,1 ; si A[n-1] es impar
		beqz r9,par ; r6 AND 1 == 0 saltar a par
		mult r7,r3,r6 ; Multiplicacion Secuencia impar
		addi r7,r7,1; Sumarle uno a la multiplicación
		add r6,r7,r0 ; A[n-1]=A[n]

		sb 0(r1),r6 ; Guardar A[n-1] en la secuencia
		addi r1,r1,4 ; Mover a la siguiente posición de la secuencia

		slt r12,r10,r6 ; si r10 < r6 r12==1 sino r12==0
		bnez r12,savemayor; si r12==1 saltar a savemayor

		j loop

par:
		srli r7,r6,1 ; A[n]=A[n-1]/2 desplazamiento logico inmediato a la derecha
		add r6,r7,r0 ; A[n-1]=A[n]

		sb 0(r1),r6 ; Guardar A[n-1] en la secuencia
		addi r1,r1,4 ; Mover a la siguiente posición de la secuencia

		addi r4,r4,1 ; suma 1 a tamsecuencia
		sw secuencia_tamanho,r4 ;Guardar tamaño de la secuencia

		slt r12,r10,r6 ; si r10 < r6 r12==1 sino r12==0
		bnez r12,savemayor; si r12==1 saltar a savemayor

		j loop

savemayor:
		add r10,r6,r0 ; r10 = A[n]
		j loop

finbucle:
		;secuencia tamaño en r4 vT 							; valor inicial en r5 vIni
		;valor maximo en r10 vMax 							; valor medio en r11 vMed
		
		


		sw secuencia_maximo,r10 ;Guardar valor maximo
		sw secuencia_tamanho,r4 ;Guardar tamaño de la secuencia
		sw secuencia_valor_medio,r11 ;Guardar valor medio
		j finish;

print:
		sw Printvalue,r6
		addi r14,r0,PrintPar
		trap 5
		jr r31

finish:
		trap 0
