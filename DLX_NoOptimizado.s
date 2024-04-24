.data 
;; VARIABLES DE ENTRADA Y SALIDA: NO MODIFICAR ORDEN 
; VARIABLE DE ENTRADA: (SE PODRA MODIFICAR EL VALOR ENTRE 1 Y 100) 
valor_inicial:   .word   3 
 
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

; r1 valor inicial
; r2 indice de la secuencia
; r3 valor 3 para la multiplicacion
; r4 tamaño_secuencia
; r5 secuencia maximo
; r6 A[n-1]
; r7 A[n]



main:
    
    lw r1,valor_inicial ;Cargar valor inicial
    lw r2,1 ;indice de la secuencia
    add r6,r0,r1 ; A[n-1]
		lw r4,1 ; r4(registro de tamsecuencia) = 1
		add r7,r0,r1; A[n]
		add r3,r0,3 ; valor 3 usado en x3

loop:
		subi r8,r6,1 ; si A[n-1] es 1 finaliza
		jal print ;
		beqz r8, finish ; si A[n-1] == 0 saltar a finish
    addi r4,r4,1 ; suma 1 a tamsecuencia

		andi r9,r6,1 ; si A[n-1] es impar
		beqz r9,par ; r6 AND 1 == 0 saltar a par
		mult r7,r3,r6 ; Multiplicacion Secuencia impar
		addi r7,r7,1; Sumarle uno a la multiplicación
		addi r4,r4,1 ; suma 1 a tamsecuencia
		add r6,r7,r0 ; A[n-1]=A[n]
		j loop

par:
		srli r7,r6,1 ; A[n]=A[n-1]/2 desplazamiento logico inmediato a la derecha
		addi r4,r4,1 ; suma 1 a tamsecuencia
		add r6,r7,r0 ; A[n-1]=A[n]
		j loop

print:
		sw Printvalue,r7
		addi r14,r0,PrintPar
		trap 5
		jr r31

finish:
		trap 0
