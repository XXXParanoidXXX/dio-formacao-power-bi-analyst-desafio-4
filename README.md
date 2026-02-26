# 📊 Star Schema – Universidade (Fato Professor)

## 📌 Descrição Geral
Este projeto apresenta a **modelagem dimensional (Star Schema)** de um **Data Warehouse acadêmico**, centrado no **Professor**, a partir de um ambiente **OLTP universitário**.  

O modelo foi projetado para suportar **análises analíticas e históricas** sobre carga docente, disciplinas ministradas e quantidade de alunos ao longo do tempo, seguindo boas práticas de Data Warehouse.

---

## 🎯 Grão da Tabela Fato
**Uma linha na tabela fato representa um Professor ministrando uma Disciplina em um determinado Período.**

Esse grão garante:
- Métricas aditivas
- Consistência analítica
- Correta integração entre dimensões

---

## ⭐ Tabela Fato

### `fato_professor`
Tabela central do Star Schema, responsável por armazenar as métricas do modelo.

**Principais medidas:**
- `carga_horaria`
- `qtd_alunos`
- `qtd_disciplinas`

**Chaves estrangeiras:**
- Professor
- Pessoa
- Disciplina
- Departamento
- Universidade
- Período

---

## 📐 Dimensões

| Dimensão | Descrição |
|--------|-----------|
| `dim_professor` | Identificação funcional do docente |
| `dim_pessoa` | Dados pessoais do professor (SCD Tipo 2) |
| `dim_disciplina` | Informações acadêmicas da disciplina |
| `dim_departamento` | Unidade organizacional |
| `dim_universidade` | Instituição de ensino |
| `dim_periodo` | Contexto temporal acadêmico (Ano/Semestre) |

**Observações técnicas:**
- Todas as dimensões utilizam **chaves substitutas (SK)**.
- As **chaves naturais (NK)** do OLTP são preservadas para rastreabilidade.
- As dimensões `professor` e `pessoa` mantêm histórico (**SCD Tipo 2**).

---

## 🧱 Arquitetura do Modelo
- Star Schema puro (sem snowflake)
- Dimensões desnormalizadas
- Relacionamentos 1:N entre dimensões e fato
- Modelo compatível com **MySQL**

---

## 🗂️ Arquivos do Projeto

| Arquivo | Descrição |
|-------|-----------|
| `star_schema_professor.png` | Diagrama dimensional do Star Schema |
| `star_schema_professor.sql` | Script DDL completo (MySQL) |
| `README.md` | Documentação do projeto |

---

## ⚙️ Tecnologias e Padrões
- **SGBD:** MySQL
- **Chaves:** Surrogate Keys (`INT AUTO_INCREMENT`)
- **Integridade referencial:** Foreign Keys
- **Ambiente:** OLAP / Data Warehouse

---

## 📈 Casos de Uso Analíticos
- Análise da carga horária docente por período
- Comparação de professores por departamento
- Identificação de disciplinas com maior número de alunos
- Avaliação histórica da atuação docente

---

## 🧠 Observações Finais
Este modelo dimensional não replica o ambiente OLTP, mas consolida e organiza os dados para fins analíticos.  
A estrutura está preparada para processos de **ETL incremental** e pode ser estendida com novas dimensões, como uma **Dimensão Tempo diária**, caso necessário.
