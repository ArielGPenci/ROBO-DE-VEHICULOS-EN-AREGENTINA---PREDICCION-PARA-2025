

# Leer archivo
df_mapa <- read.csv("C:/Users/usuario/Desktop/cc/ROBOS_2025_MAPA.csv", encoding="UTF-8", sep=";")

# Cargar las librerías necesarias
library(leaflet)
library(dplyr)

# Tu tabla de datos
datos <- data.frame(
  provincia = c("BUENOS AIRES", "CABA", "CATAMARCA", "CHACO", "CHUBUT", "CORDOBA", "CORRIENTES", "ENTRE RIOS", "FORMOSA", "JUJUY", "LA PAMPA", "LA RIOJA", "MENDOZA", "MISIONES", "NEUQUEN", "RIO NEGRO", "SALTA", "SAN JUAN", "SAN LUIS", "SANTA CRUZ", "SANTA FE", "SANTIAGO DEL ESTERO", "TIERRA DEL FUEGO", "TUCUMAN"),
  robados_2025 = c(35613, 5671, 27, 59, 121, 4504, 134, 148, 30, 44, 26, 25, 2422, 47, 277, 183, 61, 30, 76, 45, 3110, 41, 26, 88),
  recuperados_2025 = c(457, 421, 0, 0, 13, 144, 0, 51, 0, 0, 0, 0, 69, 0, 18, 18, 0, 0, 0, 0, 44, 0, 0, 0)
)

# Coordenadas geográficas aproximadas
coordenadas <- data.frame(
  provincia = c("BUENOS AIRES", "CABA", "CATAMARCA", "CHACO", "CHUBUT", "CORDOBA", "CORRIENTES", "ENTRE RIOS", "FORMOSA", "JUJUY", "LA PAMPA", "LA RIOJA", "MENDOZA", "MISIONES", "NEUQUEN", "RIO NEGRO", "SALTA", "SAN JUAN", "SAN LUIS", "SANTA CRUZ", "SANTA FE", "SANTIAGO DEL ESTERO", "TIERRA DEL FUEGO", "TUCUMAN"),
  lat = c(-36.60, -34.60, -28.00, -27.00, -43.50, -31.40, -28.50, -32.00, -25.50, -23.50, -37.00, -29.50, -33.00, -27.00, -39.00, -40.80, -24.80, -31.50, -33.30, -49.50, -30.00, -28.00, -54.50, -26.80),
  lng = c(-60.50, -58.40, -67.00, -60.00, -68.00, -64.20, -57.50, -59.00, -60.00, -65.50, -65.00, -67.00, -68.80, -55.50, -70.00, -67.00, -65.00, -68.50, -66.30, -70.00, -61.00, -64.00, -68.00, -65.20)
)

# Unir los datos y calcular los porcentajes
datos_mapa <- datos %>%
  left_join(coordenadas, by = "provincia") %>%
  mutate(
    porcentaje_recuperado_provincia = ifelse(robados_2025 > 0, (recuperados_2025 / robados_2025) * 100, 0),
    porcentaje_robado_nacional = ifelse(sum(robados_2025) > 0, (robados_2025 / sum(robados_2025)) * 100, 0),
    porcentaje_recuperado_nacional = ifelse(sum(recuperados_2025) > 0, (recuperados_2025 / sum(recuperados_2025)) * 100, 0),
    # Formatear los porcentajes
    porcentaje_recuperado_provincia_formateado = paste0("<span style='color: green;'>", round(porcentaje_recuperado_provincia, 2), "%</span>"),
    porcentaje_robado_nacional_formateado = paste0("<span style='color: red;'>", round(porcentaje_robado_nacional, 2), "%</span>"),
    porcentaje_recuperado_nacional_formateado = paste0("<span style='color: green;'>", round(porcentaje_recuperado_nacional, 2), "%</span>")
  )

# Crear el mapa leaflet mostrando robados (con porcentaje) y recuperados (con porcentaje) en el popup
mapa <- leaflet(datos_mapa) %>%
  setView(lng = -64, lat = -34, zoom = 4) %>%
  addTiles() %>%
  addMarkers(
    lng = ~lng,
    lat = ~lat,
    popup = ~paste0(
      "<span style='color: red;'>Robados: ", robados_2025, " </span><br>",
      "<span style='color: green;'>Recuperados: ", recuperados_2025, "</span>"
    )
  )

# Imprimir el mapa
mapa


