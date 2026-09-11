# Diseño de red segura en entorno de pagos

Debes diseñar una topología de red segura en la nube para un entorno de pagos. La red debe segmentarse en subredes públicas y privadas, aplicando el principio de menor privilegio en las identidades. Los servicios de pago se hospedarán en las subredes privadas, mientras que los servicios de monitoreo y auditoría se ubicarán en las subredes públicas. La red debe garantizar la confidencialidad, integridad y disponibilidad de los datos de pago. Los actores involucrados son el originador de pagos, el motor antifraude, el buró de riesgos y el sistema de liquidación. La red debe soportar un throughput de 10 000 transacciones por segundo con un SLA de 99.9%.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | topologia de red segura en la nube |
| **Nivel** | advanced-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Exploración del dominio y requisitos

**Objetivo:** Identificar los requisitos de red y las restricciones del dominio de pagos

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Enumera los actores y servicios involucrados en el dominio de pagos.
- Identifica las propiedades operativas clave de la red (throughput, latencia, disponibilidad).
- Establece los umbrales numéricos del dominio (transacciones por segundo, SLA).
- Describe las restricciones y dependencias del sistema.

**Entregable:** Documento que describe los requisitos de red y las restricciones del dominio.

<details>
<summary>Pistas de conocimiento</summary>

- Considera las implicaciones de seguridad y rendimiento al definir las subredes.
- Evalúa las dependencias entre los servicios y su impacto en la topología de red.

</details>

### Fase 2: Diseño de la topología de red

**Objetivo:** Diseñar una topología de red segura con subredes públicas y privadas

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Define las subredes públicas y privadas y sus propósitos.
- Aplica el principio de menor privilegio en las identidades de los servicios.
- Establece las rutas de comunicación entre las subredes y los servicios.
- Identifica los puntos de entrada y salida de la red y sus medidas de seguridad.

**Entregable:** Diagrama de la topología de red que muestra las subredes, servicios y rutas de comunicación.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el balance entre seguridad y rendimiento al definir las rutas de comunicación.
- Evalúa las medidas de seguridad para los puntos de entrada y salida de la red.

</details>

### Fase 3: Evaluación y optimización de la topología de red

**Objetivo:** Evaluar y optimizar la topología de red para cumplir con los requisitos de rendimiento y seguridad

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Evalúa el throughput y la latencia de la red en diferentes escenarios de carga.
- Identifica los cuellos de botella y propone soluciones de optimización.
- Verifica que la topología de red cumpla con el SLA de 99.9%.
- Propone medidas adicionales de seguridad para mitigar riesgos identificados.

**Entregable:** Documento que describe la evaluación y optimización de la topología de red, incluyendo propuestas de mejora y medidas de seguridad adicionales.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el impacto de las optimizaciones en la seguridad y el rendimiento.
- Evalúa la efectividad de las medidas de seguridad propuestas.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es una topología de red segura y cómo se aplica en el dominio de pagos?
- **paraQueSirve**: ¿Para qué sirve segmentar la red en subredes públicas y privadas en el contexto de pagos?
- **comoSeUsa**: ¿Cómo se aplica el principio de menor privilegio en las identidades de los servicios de la red?
- **erroresComunes**: ¿Cuáles son los errores comunes al diseñar una topología de red segura y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones implica el diseño de una topología de red segura en términos de rendimiento y seguridad?

## Criterios de Evaluacion

- Identificar correctamente los actores y servicios del dominio de pagos.
- Definir adecuadamente las subredes públicas y privadas y sus propósitos.
- Aplicar el principio de menor privilegio en las identidades de los servicios.
- Establecer rutas de comunicación seguras y eficientes entre las subredes y los servicios.
- Evaluar y optimizar la topología de red para cumplir con los requisitos de rendimiento y seguridad.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
