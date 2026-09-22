# People Analytics | Análise de Turnover

Projeto desenvolvido para analisar fatores associados ao turnover
de colaboradores utilizando SQL e Python.

## Objetivo

Identificar padrões relacionados aos desligamentos e transformar
os resultados em informações úteis para apoiar decisões de
People Analytics e retenção de pessoas.

## Tecnologias utilizadas

- PostgreSQL
- SQL
- Python
- Pandas
- Matplotlib
- Statsmodels
- Jupyter Notebook
- DBeaver

## Etapas da análise

### SQL

- validação da base
- análise de duplicidades e valores nulos
- cálculo do turnover geral
- análise por departamento e cargo
- análise por tempo de empresa, renda, idade e distância
- cruzamentos entre diferentes fatores

### Python

- análise exploratória dos dados
- criação de tabelas e gráficos
- cruzamento de variáveis
- regressão logística
- interpretação dos resultados
- elaboração de plano de ação

## Principais resultados

O turnover geral identificado foi de aproximadamente **16,12%**.

As maiores taxas de desligamento apareceram principalmente entre
profissionais com pouco tempo de empresa, maior exposição a horas
extras, viagens frequentes e menores níveis de satisfação.

A regressão logística permitiu avaliar quais fatores permaneceram
relevantes quando analisados simultaneamente.

## Arquivos do projeto

- `eda_turnover.ipynb`: análise realizada em Python.
- `people_turnover.sql`: consultas realizadas em SQL.

## Observação

Projeto desenvolvido para fins de estudo e portfólio em
People Analytics e análise de dados.