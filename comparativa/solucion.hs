
-- sumar :: Int -> Int -> Int
-- sumar x y = x + y

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



main :: IO ()
main = do
  --data Color =EnRojo | EnVerde | EnAmarillo deriving (Show)
  print(transicion EnRojo "verde")
  print(transicion EnVerde "amarillo")
  print(transicion EnAmarillo "rojo")
  print(transicion EnVerde "rojo") -- este no va a funcionar!
  print(sumar 90 10)