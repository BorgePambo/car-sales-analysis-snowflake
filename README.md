# Car Sales Analysis – Snowflake

## Descrição
Projeto de análise de vendas de carros para o ano de 2025, usando Snowflake como data warehouse.  
Objetivo: criar pipelines ETL (Bronze → Silver → Gold) e gerar dashboards no Power BI.

## Fonte de Dados
- Arquivo CSV: `car_sales_2025.csv`  
- Localização: **Google Cloud Storage (GCS)**  
- Carregado no Snowflake através do **STAGE `stg_dealership`** usando a **Storage Integration `gcs_car_sales`**


## Estrutura do Projeto
- **data/** → arquivos CSV com dados de vendas (`car_sales_2025.csv`)  
- **sql-scripts/** → scripts SQL por camada:
  - `bronze.sql` → dados crus  
  - `silver.sql` → dados limpos/tratados  
  - `gold.sql` → agregados para análise  
  - `governance.sql` → roles, permissões e políticas de segurança  
- **dashboard/** → relatórios e dashboards exportados  

## Principais Tabelas GOLD
- `gold.car_sales_monthly` → vendas por mês  
- `gold.car_sales_by_channel` → desempenho por canal  
- `gold.car_sales_by_model` → desempenho por modelo de carro  
- `gold.seller_ranking` → ranking de vendedores  
- `gold.monthly_revenue_variation` → variação de receita por mês  

## Tecnologias
- Snowflake (data warehouse)  
- Power BI (visualização)  
- GitHub (versionamento de código)

## Dashboard
O dashboard desenvolvido em Power BI está na pasta **`dashboard/relatorio.pdf`**.  
Visualiza:  
- Total de vendas e faturamento por mês  
- Desempenho por canal e modelo de carro  
- Desempenho por canal de venda  
- Desempenho por Cidade  
<img width="1331" height="757" alt="dashboard-relat" src="https://github.com/user-attachments/assets/18f61a2c-09ae-4095-9d42-dd1993818f7b" />


## Como usar
1. Executar scripts SQL na ordem: `bronze.sql` → `silver.sql` → `gold.sql`  
2. Conectar Power BI ao Snowflake usando as tabelas GOLD  
3. Gerar dashboards de vendas, receita e ranking de vendedores
