;;; =========================================================
;;; PROYECTO: Sistema de Semáforos Inteligentes
;;; MATERIA:  Paradigmas y Lenguajes
;;; GRUPO:    31
;;; ARCHIVO:  core.lisp
;;; =========================================================
;;; RESTRICCIONES ACTIVAS:
;;;   - Sin variables globales mutables (no defparameter/defvar para estado)
;;;   - Sin operadores destructivos (no setq/setf)
;;;   - Sin bucles imperativos (no loop/dolist/dotimes)
;;;   - Toda iteración via recursividad de cola o funciones de orden superior
;;; =========================================================


;; ---------------------------------------------------------
;; CONSTANTES DE CONFIGURACIÓN (no son estado, son configuración)
;; Tip: defconstant es la forma correcta — no viola la restricción de inmutabilidad
;; ---------------------------------------------------------
(defconstant +duracion-rojo+ 60)     ; TODO: valor en segundos según enunciado
(defconstant +duracion-amarillo+ 6) ; TODO
(defconstant +duracion-verde+ 30)    ; TODO
;; Tip: ¿podés calcular +duracion-ciclo-total+ a partir de las tres anteriores?


;; =========================================================
;; REQUERIMIENTO 1: Estados de Transición
;; =========================================================

;; --------------------------------------------------------
;; FUNCIÓN: transicion
;; NATURALEZA: Pura
;; ESTRATEGIA: Funcion Condicional (evalúa condiciones sobre los argumentos) 
;; IMPACTO:    No destructiva
;; --------------------------------------------------------
(defun transicion (color-actual cambiar-a)
  (cond 
    ((and(eq color-actual 'en-rojo) (eq cambiar-a 'verde)) 
        (list color-actual "cambiar-a-verde"))
    
    ((and(eq color-actual 'en-verde) (eq cambiar-a 'amarillo)) 
        (list color-actual "cambiar-a-amarillo"))

    ((and(eq color-actual 'en-amarillo) (eq cambiar-a 'rojo)) 
        (list color-actual "cambiar-a-rojo"))

     (t (list color-actual 'accion-por-defecto)) ; en caso de not-valid-argument
    )
)

  ;; "TODO: docstring — qué recibe, qué devuelve, qué pasa si la transición es inválida."
  ;; Pistas:
  ;;   - ¿Qué transiciones son válidas? rojo->verde, verde->amarillo, amarillo->rojo
  ;;   - cond o case pueden ayudar para los casos
  ;;   - Para construir el string "cambiar-a-verde" mirá: concatenate, string-downcase, symbol-name
  ;;   - Si es inválida: devolver (list color-actual 'accion-por-defecto)




;; =========================================================
;; REQUERIMIENTO 2: Temporizador Automático
;; =========================================================

;; --------------------------------------------------------
;; FUNCIÓN: timer
;; NATURALEZA: TODO
;; ESTRATEGIA: TODO
;; IMPACTO: TODO
;; --------------------------------------------------------
(defun timer (timestamp)
  "TODO: docstring."
  ;; Pistas:
  ;;   - El ciclo se repite cada +duracion-ciclo-total+ segundos
  ;;   - mod te da la posición dentro del ciclo actual
  ;;   - Con esa posición (offset) podés decidir el color con cond
  )


;; =========================================================
;; REQUERIMIENTO 3: Sistema de Auditoría
;; =========================================================

;; --------------------------------------------------------
;; FUNCIÓN: log-cambio-estado
;; NATURALEZA: TODO — ¿escribir en pantalla es un efecto secundario?
;; ESTRATEGIA: TODO
;; IMPACTO: TODO
;; --------------------------------------------------------
(defun log-cambio-estado (epoch color-anterior color-nuevo)
  "TODO: docstring."
  ;; Pistas:
  ;;   - format t imprime en stdout
  ;;   - El formato pedido: "Tiempo <epoch>: la luz ha cambiado de <anterior> a <nuevo>"
  ;;   - ~a en format es el placeholder, ~% es salto de línea
  )


;; =========================================================
;; REQUERIMIENTO 4a: Duración de Ciclo
;; =========================================================

;; --------------------------------------------------------
;; FUNCIÓN: duracion-ciclo
;; NATURALEZA: TODO
;; ESTRATEGIA: TODO
;; IMPACTO: TODO
;; --------------------------------------------------------
(defun duracion-ciclo (segundos)
  "TODO: docstring — ¿qué representa el argumento segundos acá?"
  ;; Lógica sería:
  ;;   - Un ciclo = rojo + amarillo + verde
  ;;   - floor hace división entera
  ;;   - ¿Qué tiene sentido devolver? ¿la duración del ciclo? ¿cuántos ciclos caben?
  )


;; =========================================================
;; REQUERIMIENTO 4b: Recomendación de Ciclo
;; =========================================================

;; --------------------------------------------------------
;; FUNCIÓN: recomendacion-ciclo
;; NATURALEZA: TODO
;; ESTRATEGIA: TODO
;; IMPACTO: TODO
;; --------------------------------------------------------
(defun recomendacion-ciclo (duracion)
  "TODO: docstring."
  ;; Pistas:
  ;;   - Rango óptimo según enunciado: 35 a 150 segundos
  ;;   - cond con tres casos: muy corto, muy largo, óptimo
  ;;   - Devolvé símbolos descriptivos
  )


;; =========================================================
;; REQUERIMIENTO 5: Planificación Temporal
;; =========================================================

;; --------------------------------------------------------
;; FUNCIÓN: ciclos-por-tiempo
;; NATURALEZA: TODO
;; ESTRATEGIA: TODO
;; IMPACTO: TODO
;; --------------------------------------------------------
(defun ciclos-por-tiempo (minutos)
  "TODO: docstring."
  ;; Pistas:
  ;;   - Convertí minutos a segundos primero
  ;;   - floor da la división entera
  )


;; =========================================================
;; REQUERIMIENTO 6: Distribución Temporal
;; =========================================================

;; --------------------------------------------------------
;; FUNCIÓN: distribucion-temporal
;; NATURALEZA: TODO
;; ESTRATEGIA: TODO — el enunciado pide usar funciones de orden superior acá
;; IMPACTO: TODO
;; --------------------------------------------------------
(defun distribucion-temporal ()
  "TODO: docstring — salida: porcentajes de rojo, amarillo y verde en 1 hora."
  ;; Pistas:
  ;;   - 1 hora = 3600 segundos
  ;;   - ¿Cuántos ciclos completos entran en 3600 segundos?
  ;;   - Para cada color: (duracion-color * ciclos-en-hora) / 3600 * 100
  ;;   - mapcar sobre una lista de pares (color . duracion) es la forma funcional
  )


;; =========================================================
;; REQUERIMIENTO 7: Ejemplos de uso / QA
;; =========================================================
;; Una vez que implementes cada función, agregá acá:
;;   - Un ejemplo del camino normal (funciona como se espera)
;;   - Un ejemplo del camino alternativo (transición inválida, borde de ciclo, etc.)
;;   - Un ejemplo que genera error o comportamiento inesperado
;; =========================================================

(defun run-ejemplos ()
  "Ejecuta todos los ejemplos de QA."
  ;; TODO: completar cuando cada función esté implementada
  )