
sumar :: Int -> Int -> Int
sumar x y = x + y

data Color = EnRojo | EnAmarillo | EnVerde deriving (Show)



-- --------------------------------------------------------
-- FUNCIÓN: transicion
-- NATURALEZA: Pura
-- ESTRATEGIA: Pattern Matching
-- IMPACTO: No destructiva
-- --------------------------------------------------------
transicion :: Color -> String -> (Color, String)
transicion EnRojo "verde" = (EnRojo, "cambiar-a-verde")
transicion EnVerde "amarillo" = (EnVerde, "cambiar-a-amarillo")
transicion EnAmarillo "rojo" = (EnAmarillo, "cambiar-a-rojo")
transicion color _ = (color, "accion-por-defecto")



-- --------------------------------------------------------
-- FUNCIÓN: semaforo-timer
-- NATURALEZA: Pura
-- ESTRATEGIA: Guardas (Guard Expressions)
--               evaluación condicional sobre el argumento
-- IMPACTO: No destructiva
-- -------------------------------------------------------- 
semaforoTimer :: Int -> Color
semaforoTimer timestamp
  | offset <= 89             = EnRojo
  | offset <= 95             = EnAmarillo
  | otherwise                = EnVerde
  where offset = mod timestamp 216



main :: IO ()
main = do
  --data Color =EnRojo | EnVerde | EnAmarillo deriving (Show)
  print(transicion EnRojo "verde")
  print(transicion EnVerde "amarillo")
  print(transicion EnAmarillo "rojo")
  print(transicion EnVerde "rojo") -- este no va a funcionar!
  print(semaforoTimer 92393293344353)
  print(semaforoTimer 9323756394897)
  print(semaforoTimer 2364784225744)
  print(mod 200000 216)
  print (semaforoTimer 200000)
  print(sumar 90 10)