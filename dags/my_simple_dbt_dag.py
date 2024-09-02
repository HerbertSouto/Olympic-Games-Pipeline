import os
import logging
from datetime import datetime
from pathlib import Path

from airflow.decorators import dag

from cosmos.profiles import PostgresUserPasswordProfileMapping
from cosmos import (
    DbtTaskGroup,
    ProfileConfig,
    ProjectConfig
)

logger = logging.getLogger(__name__)
doc_md = """
"""

default_args = {
    "owner": "owshq",
    "retries": 3,
    "retry_delay": 1
}

default_dbt_root_path = Path(__file__).parent / "dbt"
dbt_root_path = Path(os.getenv("DBT_ROOT_PATH", default_dbt_root_path))


@dag(
    dag_id="postgres-dbt-sql-transform",
    default_args=default_args,
    max_active_runs=1,
    schedule_interval=None,
    start_date=datetime(2024, 3, 19),
    catchup=False,
    tags=['dbt-core', 'postgres', 'cosmos']
)
def dag_sql_transform():
    """
    """

    profile_config = ProfileConfig(
        profile_name="airflow_db",
        target_name="dev",
        profile_mapping=PostgresUserPasswordProfileMapping(
            conn_id="db_conn",
            profile_args={
                "schema": "raw"
            }
        )
    )

    dbt_postgres = DbtTaskGroup(
        project_config=ProjectConfig(default_dbt_root_path / "pipeline_olympics"),
        profile_config=profile_config,
        operator_args={
            "install_deps": True
        }
    )

    dbt_postgres

dag_sql_transform()