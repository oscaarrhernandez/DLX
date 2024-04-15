.data
# Variables y constantes
valor_inicial: .word 3  

.text


main:
    # Tu código comienza aquí
    # Por ejemplo, cargar valores en registros, realizar operaciones, etc.

    # Ejemplo: cargar un valor en el registro $t0
    li $t0, 10   # carga el valor 10 en el registro $t0

    # Ejemplo: imprimir un mensaje
    la $a0, message    # carga la dirección del mensaje en $a0
    li $v0, 4          # carga el código de la llamada al sistema para imprimir una cadena en $v0
    syscall            # llama al sistema para imprimir el mensaje

    # Tu código continúa aquí

    # Finaliza el programa
    li $v0, 10   # carga el código de la llamada al sistema para salir del programa en $v0
    syscall      # llama al sistema para salir del programa

# Sección de datos (opcional)
.data
# Aquí puedes definir mensajes y otros datos estáticos
message: .asciiz "Hola, mundo!"   # define un mensaje de texto

# Punto de entrada del programa
.globl _start
_start:
    # Llama a la etiqueta main para iniciar el programa
    jal main
