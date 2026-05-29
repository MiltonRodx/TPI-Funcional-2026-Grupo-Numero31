
# Requerimiento 1: Estados de Transición

- Implemente la función transicion que modele el cambio de estados del semáforo:
Especificación:
Entrada: color-actual (símbolo: en-rojo, en-amarillo, en-verde) y cambiar-a (símbolo del color destino: rojo, amarillo, verde)
Salida: devuelve una lista con el estado y una acción a realizar, esta última como literal “cambiar-a-<color>”.
Comportamiento: Por defecto, retorna color actual y 'accion-por-defecto si la transición no es válida
Ejemplo esperado:
(transicion 'en-rojo 'verde) → ('en-rojo "cambiar-a-verde")

;; ========================================================
;; FUNCIÓN: transicion
;; NATURALEZA: Pura
;; ESTRATEGIA: Condicional
;; IMPACTO: No destructiva
;; ========================================================
 (Defun transicion (color_actual  cambiar_a)      ;modela cambio de estado
(Cond
((And(eq color_actual ‘rojo)(eq cambiar_a ‘amarillo))  (list color_actual cambiar_a))
((And (eq color_actual ‘amarillo)(eq cambiar_a ‘verde))  (list color_actual  cambiar_a))
((And (eq color_actual ‘verde)(eq cambiar_a ‘rojo)) (list color_actual  cambiar_a))
(T color_actual “Error al ingresar colores vuelva a ejecutar la función”)
))


# Requerimiento 2: Temporizador Automático
- Para la implementación de un actuador que realizará el cambio de luces se necesita implementar un mecanismo automatizado de temporización. Se solicita implementar una función Timer, que recibirá el tiempo actual en formato tiempo Unix (o tiempo epoch).
Desarrolle la función timer para automatizar las transiciones basadas en tiempo Unix:
Reglas de temporización:
Rojo: 90 segundos
Amarillo: 6 segundos 
Verde: 120 segundos
Especificación:
Entrada: Tiempo Unix actual (entero)
Salida: Color correspondiente al momento específico
Comportamiento: Calcular automáticamente qué color debe estar activo en el timestamp dado



;; ========================================================
;; FUNCIÓN: timer
;; NATURALEZA: Pura
;; ESTRATEGIA: Condicional
;; IMPACTO: No destructiva
;; ========================================================

(Defun timer  (tiempoActual) 
   (Cond
((And (numberp tiempoActual)(>= tiempoActual 6)(<= tiempoActual 90)) “ROJO”)
((And (numberp tiempoActual)(> =tiempoActual 0) (<= tiempoActual 6)) “AMARILLO”)
((And(numberp tiempoActual)(> =tiempoActual 90)(<= tiempoActual 120)) “VERDE”)
(T “Tiempo fuera del rango”)
))


# Requerimiento 3: Sistema de Auditoría
- El equipo de analistas forenses necesita poder determinar qué color tenía una luz a determinada hora. Se necesita implementar un mecanismo de registro de los diferentes cambios de estado de las luces durante la ejecución del programa. Se ha solicitado que para la versión actual se implemente una función que imprima en la terminal de ejecución el cambio de estados del semáforo.
Implemente un mecanismo de logging para análisis forense de tráfico:
Especificación:
Función que registre cada cambio de estado
Formato de salida: "Tiempo <epoch>: la luz ha cambiado de <color-anterior> a <color-nuevo>"
Propósito: Permitir reconstrucción histórica de estados del semáforo


;; ========================================================
;; FUNCIÓN:  registraCambiosDeEstado
;; NATURALEZA: Pura
;; ESTRATEGIA: Condicional
;; IMPACTO: No destructiva
;; ========================================================
(defun registraCambiosDeEstado (colorAnterior colorNuevo tiempo)
  
    (If  (numberp tiempo)
      (list 'Tiempo tiempo 'la_luz_ha_cambiado colorAnterior 'a  colorNuevo)
     'Error-parámetros-inválidos
  ))


# Requerimiento 4: Análisis de Ciclos Semafóricos
- Para la coordinación y planificación de la vía se necesita calcular cuántos ciclos, transición entre rojo a rojo, se realizarán pasado un determinado tiempo. A la hora de determinar la duración de un ciclo semafórico se acostumbra a tener en cuenta la psicología del conductor, según la cual, ciclos menores de 35 segundos o mayores de 150 segundos se acomodan difícilmente a la mentalidad del usuario de la vía pública, por lo que tienden a evitarse. Por lo que se solicita implementar una función duracion-ciclo que calcule la duración que tendrá cada ciclo con las reglas de negocio actuales y una funcion de recomendacion sobre la duración del ciclo. 
Desarrolle funciones para análisis de eficiencia del sistema:
4a. Función duracion-ciclo
Entrada: un numero determinado de segundos
Propósito: Calcular duración total de un ciclo completo (rojo → amarillo → verde → rojo)
Consideración psicológica: Evaluar si la duración está en el rango óptimo (35-150 segundos)    


;; ========================================================
;; FUNCIÓN:  duracion-ciclo 
;; NATURALEZA: Pura
;; ESTRATEGIA: Condicional
;; IMPACTO: No destructiva
;; ========================================================
(Defun duracion-ciclo (segundos)
(Cond
((< segundos 35) (list segundos “ciclo demasiado corto”))
((> segundos 120) (list segundos “ciclo demasiado largo”))
(T(list segundos  “Ciclo dentro del rango optimo”))
))
4b. Función recomendacion-ciclo
Entrada: Duración calculada del ciclo
Salida: Recomendación de optimización basada en estándares de ingeniería de tráfico
;; ========================================================
;; FUNCIÓN:  recomendacion-ciclo 
;; NATURALEZA: Pura
;; ESTRATEGIA: Condicional
;; IMPACTO: No destructiva
;; ========================================================
(Defun recomendacion-ciclo (duracion)
(Cond
((< duración 35) “Aumentar la duración del ciclo”)
((> duración 120) “ Reducir la duración  del ciclo”)
(T “La configuración actual de Semáforos  es la adecuada “)
))


# Requerimiento 5: Planificación Temporal
- Para la coordinación y planificación de la vía se necesita calcular cuantos ciclos se completan en determinada cantidad de minutos, por ejemplo en 15 minutos; se requiere una función ciclos-por-tiempo que calcule la cantidad de ciclos incluidos en ese tiempo.
Implemente ciclos-por-tiempo:
Especificación:
Entrada: Duración en minutos
Salida: Número de ciclos completos en ese período
Aplicación: Planificación de mantenimiento y análisis de capacidad
;; ========================================================
;; FUNCIÓN:  ciclos-por-tiempo
;; NATURALEZA: Pura
;; ESTRATEGIA: Algorítmica y condicional
;; IMPACTO: No destructiva
;; ========================================================
(Defun ciclos-por-tiempo  (duracion);sabiendo que un ciclo es (+ 90 6 120)-> 216
( If (numberp duracion) 
(round (/ (* duracion 60)  216));duracion esta en minutos  por eso lo multiplicamos por 60 para pasarlo a segundos 
“Error se debe ingresar  un numero”
))


# Requerimiento 6: Informe de Distribución Temporal
- Por cuestiones de planificación logística, se necesita un informe que indique el porcentaje de cada color que se tendrá en 1 hora. Dadas ciertas reglas de negocios o según las actuales. 
Desarrolle una función que calcule la distribución porcentual de cada color en períodos de 1 hora:
Especificación:
Salida: Porcentajes de tiempo para rojo, amarillo y verde
Propósito: Optimización de flujo vehicular y análisis de congestión

;; ========================================================
;; FUNCIÓN:  PorcentajePorColor
;; NATURALEZA: Pura
;; ESTRATEGIA: Algorítmica
;; IMPACTO: No destructiva
;; ========================================================
(defun PorcentajePorColor ()
  ; ciclo = 216 segundos (90 rojo + 6 amarillo + 120 verde)
  (list
    (list 'ROJO     (* (/ 90  216) 100))
    (list 'AMARILLO (* (/ 6   216) 100))
    (list 'VERDE    (* (/ 120 216) 100))
  ))
