from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

# Definindo os argumentos padrão da DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Criando a DAG
dag = DAG(
    'bash_operator_dag',
    default_args=default_args,
    description='A simple DAG using BashOperator',
    schedule_interval=timedelta(days=1),
    start_date=datetime(2024, 1, 1),
    catchup=False,
)

# Definindo uma tarefa que usa BashOperator
task1 = BashOperator(
    task_id='print_hello_world',
    bash_command='echo "Hello World from BashOperator!"',
    dag=dag,
)

# Definindo outra tarefa que usa BashOperator
task2 = BashOperator(
    task_id='list_files',
    bash_command='ls -la',
    dag=dag,
)

# Definindo a sequência de execução das tarefas
task1 >> task2
