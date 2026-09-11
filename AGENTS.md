# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Diseño de red segura en entorno de pagos**.

| | |
|---|---|
| Tema | topologia de red segura en la nube |
| Nivel | advanced-l2 |
| Chapter | Cloud Ops |
| Especialidad | AWS |
| Stack | HCL / Terraform |
| Patron arquitectonico | modular con capas de red, seguridad y servicios (VPC, subnets, route tables, security groups, IAM, servicios AWS) |
| Tiempo estimado | 8 horas |

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Corre `terraform init -backend=false && terraform validate && terraform fmt -check` y mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `terraform init -backend=false && terraform validate && terraform fmt -check` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Exploración del dominio y requisitos**: Documento que describe los requisitos de red y las restricciones del dominio.
- **Fase 2 — Diseño de la topología de red**: Diagrama de la topología de red que muestra las subredes, servicios y rutas de comunicación.
- **Fase 3 — Evaluación y optimización de la topología de red**: Documento que describe la evaluación y optimización de la topología de red, incluyendo propuestas de mejora y medidas de seguridad adicionales.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Lo que falta y tenes que completar

### 1. Boilerplate del stack (1)

Sin esto el proyecto no compila ni arranca. **Es tu trabajo crearlo**, y no toca nada de lo pedagogico: es andamiaje del stack.

- [ ] **providers.tf** — Sin providers.tf, terraform init no sabe que proveedor bajar y no puede inicializar.

### 2. Archivos que la arquitectura declara (2 de 22)

La propuesta arquitectonica del reto los lista y no llegaron al repo. Crealos con implementacion real, respetando la capa en la que viven:

- [ ] `providers.tf`
- [ ] `providers.tf`

### Presentes (23)

- `variables.tf`
- `main.tf`
- `outputs.tf`
- `backend.tf`
- `README.md`
- `modules/network/vpc.tf`
- `modules/network/subnets.tf`
- `modules/network/route_tables.tf`
- `modules/network/internet_gateway.tf`
- `modules/network/nat_gateway.tf`
- `modules/security/security_groups.tf`
- `modules/security/iam.tf`
- `modules/security/kms.tf`
- `modules/services/lambda.tf`
- `modules/services/rds.tf`
- `modules/services/alb.tf`
- `environments/dev/terraform.tfvars`
- `environments/qa/terraform.tfvars`
- `environments/prod/terraform.tfvars`
- `diagram/red_pagos.drawio`
- `modules/network/variables.tf`
- `modules/security/variables.tf`
- `modules/services/variables.tf`

### Capas del patron declarado

Cada una tiene que existir como directorio real con al menos un archivo. Codigo plano en la raiz no satisface el patron.

- `modules/network`
- `modules/security`
- `modules/services`
- `environments/dev`
- `environments/qa`
- `environments/prod`

## Verificacion

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- El patron es **modular con capas de red, seguridad y servicios (VPC, subnets, route tables, security groups, IAM, servicios AWS)**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Cloud Ops, Especialidad AWS, Tecnología Terraform AWS, Advanced
- Brecha que el reto ataca: Diseña segmentacion de red con subredes publicas y privadas aplicando el principio de menor privilegio en las identidades
- Mision: Definir la red del entorno de pagos

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
