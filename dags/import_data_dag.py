from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.utils.dates import days_ago
from pathlib import Path
from datetime import datetime, timedelta


# Configurar o caminho do script usando pathlib
default_extract_root_path = Path(__file__).parent / "extract.py"

# Definir DAG
default_args = {
    'owner': 'HerbertSouto',
    'depends_on_past': False,
    'start_date': datetime.now() - timedelta(minutes=10), 
    'retries': 1,
}

dag = DAG(
    'import_sheets_to_postgres',
    default_args=default_args,
    description='Importa dados do Google Sheets para o PostgreSQL',
    schedule_interval='*/10 * * * *',  # Define a frequência de execução
    tags=['Extract','Google Sheets', 'Google API']
)

# Define a tarefa BashOperator para importação de dados
import_data_task = BashOperator(
    task_id='import_data_task',
    bash_command=f'python {default_extract_root_path}',  # Caminho gerado dinamicamente
    dag=dag,
)

# Define a tarefa para rodar o dbt
trigger_dbt_task = TriggerDagRunOperator(
    task_id='trigger_dbt_task',
    trigger_dag_id='postgres-dbt-sql-transform',  # ID da DAG do dbt
    dag=dag,
)

# Define a ordem das tarefas
import_data_task >> trigger_dbt_task
