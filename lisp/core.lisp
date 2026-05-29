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
; CONFIGURACION DE PACKAGE (Para entorno de desarrollo VS Code + Alive)
(defpackage :semaforo
  (:use :cl)
  (:export 
    #:transicion
    #:semaforo-timer
    #:log-cambio-estado
    #:duracion-ciclo
    #:recomendacion-ciclo
    #:ciclos-por-tiempo
    #:distribucion-temporal))



;; ---------------------------------------------------------
;; CONSTANTES DE CONFIGURACIÓN (no son estado, son configuración)
;; defconstant es la forma correcta — no viola la restricción de inmutabilidad
;; ---------------------------------------------------------
(defconstant +duracion-rojo+ 90)
(defconstant +duracion-amarillo+ 6)
(defconstant +duracion-verde+ 120)
(defconstant +duracion-ciclo-total+ 216)


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




;; =========================================================
;; REQUERIMIENTO 2: Temporizador Automático
;; =========================================================

;; --------------------------------------------------------
;; FUNCIÓN: timer
;; NATURALEZA: Pura                 (Dado un timestamp, siempre retorna un color symbol)
;; ESTRATEGIA: Funcion Condicional  (evalúa condiciones sobre los argumentos) 
;; IMPACTO: No destructiva          (solo retorna un symbol)
;; --------------------------------------------------------
(defun semaforo-timer (timestamp)
  (let ((offset (mod timestamp +duracion-ciclo-total+)))
    (cond
      ((<= 0 offset 89) 'en-rojo)
      ((<= 90 offset 95) 'en-amarillo)
      ((<= 96 offset 215) 'en-verde)
    )
  )
)


;; =========================================================
;; REQUERIMIENTO 3: Sistema de Auditoría
;; =========================================================

;; --------------------------------------------------------
;; FUNCIÓN: log-cambio-estado
;; NATURALEZA: No Pura     (Escribe por pantalla/terminal)
;; ESTRATEGIA: Funcion De Efecto Secundario
;; IMPACTO: No Destructiva
;; --------------------------------------------------------
(defun log-cambio-estado (epoch color-anterior color-nuevo)
  (format t "Tiempo ~a: la luz ha cambiado de ~a a ~a~%" 
          epoch color-anterior color-nuevo))


;; =========================================================
;; REQUERIMIENTO 4a: Duración de Ciclo
;; =========================================================

;; --------------------------------------------------------
;; FUNCIÓN: duracion-ciclo
;; NATURALEZA: Pura
;; ESTRATEGIA: Condicional
;; IMPACTO: No destructiva
;; --------------------------------------------------------
(defun duracion-ciclo (segundos)
    (list (nth-value 0 (floor segundos +duracion-ciclo-total+)) (recomendacion-ciclo +duracion-ciclo-total+))
  )


;; =========================================================
;; REQUERIMIENTO 4b: Recomendación de Ciclo
;; =========================================================

;; --------------------------------------------------------
;; FUNCIÓN: recomendacion-ciclo
;; NATURALEZA: Pura
;; ESTRATEGIA: Funcion Condicional
;; IMPACTO: No destructiva
;; --------------------------------------------------------
(defun recomendacion-ciclo (duracion)
    (cond
      ((< duracion 35) 'ciclo-corto)
      ((<= 35 duracion 150) 'ciclo-optimo)
      (t 'ciclo-largo)
    )
)

;; =========================================================
;; REQUERIMIENTO 5: Planificación Temporal
;; =========================================================

;; --------------------------------------------------------
;; FUNCIÓN: ciclos-por-tiempo
;; NATURALEZA: Pura
;; ESTRATEGIA: Funcion Simple
;; IMPACTO: No Destructiva
;; --------------------------------------------------------
(defun ciclos-por-tiempo (minutos)
    (nth-value 0 (floor (* minutos 60) +duracion-ciclo-total+))
)


;; =========================================================
;; REQUERIMIENTO 6: Distribución Temporal
;; =========================================================

;; --------------------------------------------------------
;; FUNCIÓN: distribucion-temporal
;; NATURALEZA: Pura
;; ESTRATEGIA: Función de orden superior
;; IMPACTO: No destructiva
;; --------------------------------------------------------
(defun distribucion-temporal ()
  (let ((ciclos-por-hora (ciclos-por-tiempo 60)))
    (mapcar
      #'(lambda (x)
          (cons (car x)
            (* (/ (* (cdr x) ciclos-por-hora) 3600.0) 100.0))
        )
      
      (list
        (cons 'rojo +duracion-rojo+)
        (cons 'amarillo +duracion-amarillo+)
        (cons 'verde +duracion-verde+)
      )
    )
  )
)
  ;; Pistas:
  ;;   - 1 hora = 3600 segundos
  ;;   - ¿Cuántos ciclos completos entran en 3600 segundos?
  ;;   - Para cada color: (duracion-color * ciclos-en-hora) / 3600 * 100
  ;;   - mapcar sobre una lista de pares (color . duracion) es la forma funcional
  ;; Devolver una lista? en una hora: porcentajes de: rojo, amarillo y verde


;; =========================================================
;; REQUERIMIENTO 7: Ejemplos de uso / QA
;; =========================================================
;; Una vez que implementes cada función, agregá acá:
;;   - Un ejemplo del camino normal (funciona como se espera)
;;   - Un ejemplo del camino alternativo (transición inválida, borde de ciclo, etc.)
;;   - Un ejemplo que genera error o comportamiento inesperado
;; =========================================================

(defun run-ejemplos ()
  ;; TODO: completar cuando cada función esté implementada


  )
