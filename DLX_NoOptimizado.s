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

.text
.global main

main:
    ;Cargar valor inicial en registro 1
    lw R1, valor_inicial

    ;indice de la secuencia
    LW R2, 0

    loop:
        ;R1==0?
        BEQZ R1, end_loop

        ;Almacenar en secuencia
        SW secuencia(R2),R1
        ;Incrementar tamaño secuencia
        ADDI R3, R2, 1
        SW secuencia_tamanho,R3

        ;ComprobarMax
        SUB R1, secuencia_maximo, R4
        BEQZ R1, update_max
        J continue

    update_max:
        SW secuencia_maximo,R1

    continue:
        ;Calcular sig elemento
        REM R3,R1,2
        BEQ> R3, par ;Si es par salta   

        ;Si es impar
        MULI R1, R1, 3   # R1 = R1 * 3
        ADDI R1, R1, 1   # R1 = R1 + 1
        J continue

    par:
        SRA R1, R1, 1 ;Mover bit a la derecha es dividir entre 2
        ADDI R2, R2, 1 ;indice++
        J loop 

end_loop:
    trap 0;FIN
