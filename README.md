# Pipeline de Dados das Olimpíadas 2024: Airbyte, dbt, PostgreSQL, Airflow e Power BI (Em Construção)

## Visão Geral

Este projeto cria um pipeline de dados para os Jogos Olímpicos de 2024. Utiliza o Airbyte para extrair dados de planilhas do Google Sheets, carrega essas informações em um banco de dados PostgreSQL hospedado no Render, e realiza a transformação dos dados utilizando dbt. O Apache Airflow será utilizado para orquestrar o pipeline, e o Power BI para visualização dos dados. O processo de transformação é dividido em camadas: raw, staging e mart, preparando os dados para análises detalhadas.

## Arquitetura

1. **Extração de Dados**:
   - **Ferramenta**: Airbyte
   - **Fonte**: Planilhas do Google Sheets contendo dados das Olimpíadas 2024
   - **Destino**: PostgreSQL no Render

2. **Transformação de Dados**:
   - **Ferramenta**: dbt
   - **Camadas**:
     - **Raw**: Camada inicial onde os dados são ingeridos diretamente.
     - **Staging**: Camada intermediária para limpeza e transformação dos dados.
     - **Mart**: Camada final organizada para relatórios e análises.

3. **Orquestração**:
   - **Ferramenta**: Apache Airflow
   - **Função**: Automatizar e gerenciar o fluxo do pipeline de dados.

4. **Visualização de Dados**:
   - **Ferramenta**: Power BI
   - **Função**: Criar visualizações e relatórios baseados nos dados transformados das Olimpíadas 2024.

## Estrutura do Projeto

- **/airbyte-config**: Arquivos de configuração do Airbyte para extração de dados.
- **/dbt**: Projeto dbt contendo modelos e macros para as camadas raw, staging e mart.
- **/sql**: Scripts SQL para a criação e gerenciamento do banco de dados PostgreSQL.
- **/airflow**: Configuração e DAGs do Apache Airflow para orquestração do pipeline.
- **/powerbi**: Arquivos e configurações para visualização dos dados no Power BI.

## Status Atual

### Concluído:
- Configuração do Airbyte para extrair dados das planilhas do Google Sheets relacionadas às Olimpíadas 2024.
- Configuração do banco de dados PostgreSQL no Render.
- Desenvolvimento inicial dos modelos dbt para transformação dos dados.

### Próximos Passos:
- Finalizar a configuração das camadas de staging e mart no dbt.
- Configurar o Apache Airflow para orquestrar o pipeline.
- Desenvolver dashboards e relatórios no Power BI para visualização dos dados das Olimpíadas 2024.