SELECT TOP (300000) [ID]
      ,[tramite_tipo]
      ,[tramite_fecha]
      ,[registro_seccional_provincia]
      ,[automotor_origen]
      ,[automotor_anio_modelo]
      ,[automotor_tipo_descripcion]
      ,[automotor_marca_descripcion]
      ,[automotor_modelo_descripcion]
  FROM [ROBOS_MEJORADO].[dbo].[ROBOS_MEJORADO]

  -- CONTROLAR QUE NO HAYA MARCAS REPETIDAS --
  SELECT DISTINCT automotor_marca_descripcion 
  FROM ROBOS_MEJORADO
  ORDER BY automotor_marca_descripcion;

  -- CONTROLAR TIPO DE VEHICULOS --
  SELECT DISTINCT automotor_tipo_descripcion 
  FROM ROBOS_MEJORADO
  ORDER BY automotor_tipo_descripcion;

   -- CONTROLAR QUE NO HAYA PROVINCIAS REPETIDAS --
  SELECT DISTINCT registro_seccional_provincia
  FROM ROBOS_MEJORADO
  ORDER BY registro_seccional_provincia;

  -- CAMBIAR ALGUNOS REGISTROS -- 
 UPDATE ROBOS_MEJORADO 
SET automotor_tipo_descripcion = 
    CASE automotor_tipo_descripcion
        WHEN 'furg vidr con asient' THEN 'FURG VIDR CON ASIENT'
        WHEN 'FIESTA CLX D' THEN 'AUTO'
        WHEN 'FORD' THEN 'AUTO'
        ELSE automotor_tipo_descripcion
    END
WHERE automotor_tipo_descripcion IN ('FURG VIDR CON ASIENT', 'FIESTA CLX D', 'FORD');

 -- BORRAR PRIMEROS 2 DIGITOS DE LOS REGISTROS --
UPDATE ROBOS_MEJORADO
SET automotor_tipo_descripcion = LTRIM(SUBSTRING(automotor_tipo_descripcion, 6, LEN(automotor_tipo_descripcion)))
WHERE automotor_tipo_descripcion LIKE '[0-9][0-9]%';

  -- SELECCIONAR TODOS LOS REGISTROS PARA EXPORTARLOS EN CSV -- 
SELECT TOP (300000) [ID]
      ,[tramite_tipo]
      ,[tramite_fecha]
      ,[registro_seccional_provincia]
      ,[automotor_origen]
      ,[automotor_anio_modelo]
      ,[automotor_tipo_descripcion]
      ,[automotor_marca_descripcion]
      ,[automotor_modelo_descripcion]
  FROM [ROBOS_MEJORADO].[dbo].[ROBOS_MEJORADO]