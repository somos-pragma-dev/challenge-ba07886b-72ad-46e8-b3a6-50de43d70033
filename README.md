# Diseño de Red Segura para Entorno de Pagos

El entorno de pagos de una institución financiera requiere una red segura y segmentada en la nube. Debes diseñar una topología de red que incluya subredes públicas y privadas, aplicando el principio de menor privilegio en las identidades. Los componentes clave son el gateway de pagos, el sistema de liquidación y el motor antifraude. La red debe soportar un throughput de 10 000 transacciones por segundo con un SLA del 99.99%.

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

### Fase 1: Definición de Requisitos de Red

**Objetivo:** Identificar y documentar los requisitos de red para el entorno de pagos.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Enumera los componentes del sistema y sus interacciones.
- Define las subredes públicas y privadas necesarias.
- Especifica los umbrales de rendimiento y disponibilidad.

**Entregable:** Documento de requisitos de red.

<details>
<summary>Pistas de conocimiento</summary>

- Considera la segmentación de la red para minimizar la superficie de ataque.
- Aplica el principio de menor privilegio en las identidades de los componentes.

</details>

### Fase 2: Diseño de la Topología de Red

**Objetivo:** Crear un diseño detallado de la topología de red que cumpla con los requisitos definidos.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Dibuja la topología de red incluyendo subredes públicas y privadas.
- Define las rutas de tráfico entre componentes.
- Aplica políticas de seguridad en las fronteras de las subredes.

**Entregable:** Diagrama de la topología de red.

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza herramientas de diagramación para crear un diseño claro y comprensible.
- Aplica políticas de seguridad para proteger las subredes privadas.

</details>

### Fase 3: Implementación y Validación

**Objetivo:** Implementar el diseño de la topología de red y validar su funcionamiento.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Implementa el diseño de la topología de red en la nube.
- Realiza pruebas de rendimiento y seguridad.
- Documenta cualquier ajuste realizado y justifica las decisiones tomadas.

**Entregable:** Documento de implementación y validación de la topología de red.

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza herramientas de nube para implementar el diseño.
- Realiza pruebas exhaustivas para validar el funcionamiento de la red.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es una topología de red segura y cómo se aplica en el entorno de pagos?
- **paraQueSirve**: ¿Para qué sirve segmentar la red en subredes públicas y privadas en el contexto del entorno de pagos?
- **comoSeUsa**: ¿Cómo se usa el principio de menor privilegio en las identidades de los componentes de la red?
- **erroresComunes**: ¿Cuáles son los errores comunes al diseñar una topología de red segura y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones implica el diseño de una topología de red segura para el entorno de pagos?

## Criterios de Evaluacion

- Definir correctamente los requisitos de red para el entorno de pagos.
- Crear un diseño detallado de la topología de red que incluya subredes públicas y privadas.
- Implementar y validar el diseño de la topología de red en la nube.
- Aplicar el principio de menor privilegio en las identidades de los componentes.
- Documentar y justificar las decisiones tomadas durante el proceso.

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
