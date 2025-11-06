# Proyecto de aula Entrega 2: Ingeniería de características

## Contexto general del proyecto

En esta segunda entrega, los estudiantes deberán implementar un modelo predictivo y continuar con el proyecto formulado en la primera fase. Sin embargo, el propósito de esta entrega es aplicar adecuadamente técnicas de exploración y de ingeniería de datos.

## ¿Qué deben hacer en esta entrega?

Deberán entregar un notebook en el que muestren lo siguiente:

1. Carga y comprensión de los datos:
   1. Carguen el archivo de datos en Pandas.
   2. Indiquen cuántas variables y registros tiene el dataframe, y asegúrense de que el tipo de dato de cada variable sea el esperado.
   3. Reporten las estadísticas descriptivas de las variables numéricas y categóricas.
   4. Identifiquen si el dataframe tiene datos duplicados.
   5. Identifiquen si hay variables con valores nulos.
   6. Reporten los hallazgos en una celda de texto.
   7. Descarten las variables que consideren irrelevantes para su modelo o que supongan un riesgo de filtración de datos.
   8. Gestionen los datos duplicados y los datos nulos.
2. Análisis exploratorio de variables categóricas:
   1. Identifiquen cuáles variables son nominales y cuáles son ordinales.
   2. Identifiquen las variables que no deberían incluirse en la matriz de características.
   3. Indiquen qué tipo de procesamiento debería recibir cada variable categórica, según su tipo y cardinalidad.
   4. Reporten los resultados de los análisis en una celda de texto.
3. Análisis exploratorio de variables numéricas:
   1. Identifiquen variables que sean aproximadamente normales y otras que tengan una distribución diferente.
   2. Identifiquen las variables con valores atípicos.
   3. Indiquen qué tipo de tratamiento debería recibir cada variable numérica, según su distribución y la presencia de valores atípicos.
   4. Reporten los resultados de los análisis en una celda de texto.
4. Procesamiento de las características y entrenamiento del modelo:
   1. Escojan un modelo adecuado al tipo de variable que van a predecir (modelo de clasificación o de regresión)
   2. Extraigan la matriz de características y el vector objetivo de su dataframe, a partir de los análisis previos.
   3. Partan los datos en subconjuntos de entrenamiento y de prueba.
   4. Procesen las características del modelo usando ColumnTransformer.
   5. Creen un flujo de trabajo con Pipeline.
   6. Entrenen el modelo.
   7. Reporten los scores de entrenamiento y de prueba.
   8. Reporten el listado completo de características con las que fue entrenado el modelo después del procesamiento realizado.

## Entregable

Un notebook en formato .ipynb titulado "Entrega2\_Apellido1Apellido2.ipynb". El archivo debe estar debidamente comentado y organizado para su comprensión.

El código del notebook debe ejecutarse correctamente al usar la opción “Run All”.

Debe entregarse el notebook con el código ejecutado y el archivo de datos utilizado.

Fecha de entrega: 9 de septiembre de 2026 a las 10:00 AM.

# Rúbrica de evaluación:

|  |  |  |  |  |
| --- | --- | --- | --- | --- |
| **Criterio** | **Excelente (5.0)** | **Bueno (4.0)** | **Aceptable (3.0)** | **Insuficiente (1.0)** |
| **1. Carga, exploración inicial y calidad de datos** | Carga los datos correctamente en Pandas y verifica las dimensiones y los tipos de datos. Presenta estadísticas descriptivas completas, identifica e imputa o gestiona adecuadamente los valores nulos y duplicados, y justifica el descarte de variables irrelevantes o con riesgo de filtración (*data leakage*) en celdas de texto claras. | Carga y explora los datos adecuadamente. Gestiona nulos y duplicados, aunque la justificación del descarte de variables o de la prevención de la filtración de datos es breve o carece de profundidad técnica. | Realiza la carga y el reporte descriptivo básico, pero el tratamiento de valores nulos o duplicados es incompleto, o no se analiza adecuadamente el riesgo de filtración de datos. | Carga deficiente de datos, omisión en la verificación de tipos y dimensiones, o ausencia de tratamiento de la calidad de los datos y de valores nulos/duplicados. |
| **2. Análisis exploratorio y tratamiento de variables categóricas** | Clasifica con precisión las variables en nominales y ordinales. Analiza la cardinalidad, descarta variables no pertinentes y define/justifica rigurosamente la estrategia de codificación (*encoding*) para cada una en celdas explicativas. | Identifica variables nominales y ordinales y propone transformaciones adecuadas para la mayoría, aunque la justificación técnica, según la cardinalidad o el tipo de variable, es limitada. | Identificación parcial de tipos de variables categóricas o propuestas de codificación genéricas que no consideran adecuadamente la cardinalidad ni la naturaleza de las variables. | No clasifica adecuadamente las variables categóricas, no analiza la cardinalidad ni define estrategias de preprocesamiento adecuadas. |
| **3. Análisis exploratorio y tratamiento de variables numéricas** | Evalúa rigurosamente las distribuciones (identificando la normalidad y las asimetrías) y detecta valores atípicos (*outliers*). Define y justifica con claridad los esquemas de escalamiento, normalización o transformación requeridos. | Analiza la distribución y detecta valores atípicos, proponiendo transformaciones y escalamientos pertinentes, aunque con explicaciones teóricas o empíricas breves. | Identifica valores atípicos o distribuciones de forma superficial; las transformaciones o escalamientos seleccionados no corresponden plenamente a las características de los datos. | Omite el análisis de distribución y detección de valores atípicos, o no define tratamientos ni transformaciones para las variables numéricas. |
| **4. Flujo de preprocesamiento y entrenamiento del modelo** | Define correctamente la matriz de características y el vector objetivo. Realiza la partición de datos (*train/test*) e integra el preprocesamiento mediante ColumnTransformer en un Pipeline de scikit-learn con un estimador adecuado al tipo de problema. | Configura la partición de datos y el flujo de trabajo con ColumnTransformer y Pipeline, pero presenta inconsistencias menores en la asignación de transformadores o en la estructura del pipeline. | Entrena el modelo y realiza la partición de datos, pero no implementa adecuadamente ColumnTransformer ni Pipeline, aplicando transformaciones de forma manual o de manera desarticulada. | No implementa ColumnTransformer ni Pipeline, selecciona un modelo inadecuado para la variable objetivo o comete errores metodológicos graves durante el entrenamiento. |
| **5. Evaluación, trazabilidad y reproducibilidad del notebook** | Reporta y analiza las métricas de rendimiento en entrenamiento y prueba. Lista las características finales de posprocesamiento. El código se ejecuta de principio a fin sin errores (*Run All*), con una estructura ordenada, un Markdown explicativo y un archivo de datos adjunto. | Reporta las métricas de desempeño y la lista de características. El notebook es reproducible mediante *Run All*, aunque los comentarios explicativos son escasos o la interpretación de los resultados es superficial. | Presenta métricas básicas, pero omite el listado de características finales o el análisis comparativo entre entrenamiento y prueba. Requiere ajustes menores para su ejecución completa. | El notebook genera errores de ejecución al ejecutar *Run All*, no incluye el conjunto de datos, carece de reporte de métricas o no documenta el procedimiento analítico. |