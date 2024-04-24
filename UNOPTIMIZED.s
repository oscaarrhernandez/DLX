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

main:
	lw   r1, 0 ; indice secuencia
	lw   r2,valor_inicial	; cargamos valor_inicial en r2
	add  r3,r0,r2 ; A[n-1]
	lw   r10,secuencia_tamanho
	add  r10,r0,1 ; suma 1 a secuencia_tamanho
	add  r4,r0,r2 ; A[n]
	add  r5,r0,3 ; valor 3 en el registro r5. Usado para x3

loop:
	subi r6,r3,1  ; Si A[n-1] es 1 finaliza
	jal print
	beqz r6,finish
	add  r10,r10,1 ; suma 1 a secuencia_tamanho
	;sw secuencia(r1),r6
	andi r7,r3,1  ; Si A[n-1] es impar
	beqz r7,par
	mult r4,r3,r5 ; Impar A[n]=3xA[n]+1
	addi r4,r4,1
	add  r10,r10,1 ; suma 1 a secuencia_tamanho
	add  r3,r4,r0 ; A[n-1]=A[n]s
	j loop

par:
	srli r4,r3,1  ; A[n]=A[n-1]/2
	add r3,r4,r0  ; A[n-1]=A[n]
	j loop

print:
	sw Printvalue,r4
	addi r14,r0,PrintPar
	trap 5
	jr r31

finish:
	sw secuencia_tamanho, r10
	trap 0
