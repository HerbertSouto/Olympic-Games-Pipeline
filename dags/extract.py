import gspread
import pandas as pd
from oauth2client.service_account import ServiceAccountCredentials
from dotenv import load_dotenv
import os
import psycopg2
from psycopg2.extras import execute_values
from pathlib import Path


load_dotenv()

# Caminho para o arquivo credentials.json
json_extract_root_path = Path(__file__).parent / "config/credentials.json"

# Verifique se o arquivo credentials.json existe no caminho especificado
if not os.path.exists(json_extract_root_path):
    raise FileNotFoundError(f"Arquivo credentials.json não encontrado no caminho: {json_extract_root_path}")

# Configura a conexão com o Google Sheets
scope = ["https://spreadsheets.google.com/feeds", "https://www.googleapis.com/auth/drive"]
credentials = ServiceAccountCredentials.from_json_keyfile_name(json_extract_root_path, scope)
client = gspread.authorize(credentials)

# Nome das planilhas, tabelas de destino e coluna de ID
planilhas_e_tabelas = {
    'Olympics_teams': {
        'nome_aba': 'teams',
        'tabela': 'sheets_teams',
        'coluna_id': 'code'  
    },
    'olympicgames_athletes': {
        'nome_aba': 'athletes',
        'tabela': 'sheets_athletes',
        'coluna_id': 'code'  
    },
    'olympics_medals': {
        'nome_aba': 'medals',
        'tabela': 'sheets_medals',
        'coluna_id': 'id' 
    }
}

# Configurar a conexão com o Postgres
DB_USER = os.getenv('USER_NAME')
DB_PASS = os.getenv('PASSWORD')
DB_HOST = os.getenv('HOST_NAME')
DB_PORT = os.getenv('DB_PORT')
DB_NAME = os.getenv('DATABASE_NAME')

# String de conexão
conn_params = {
    'dbname': DB_NAME,
    'user': DB_USER,
    'password': DB_PASS,
    'host': DB_HOST,
    'port': DB_PORT
}

# Função para criar a conexão
def get_postgres_connection():
    return psycopg2.connect(**conn_params)

# Inserir dados de cada planilha no Postgres
for planilha, info in planilhas_e_tabelas.items():
    print(f"Iniciando a importação da planilha '{planilha}' para a tabela '{info['tabela']}'...")

    sheet = client.open(planilha).worksheet(info['nome_aba'])
    data = sheet.get_all_records()

    df = pd.DataFrame(data)

    # Inserir os dados no PostgreSQL no schema especificado, adicionando apenas novos registros
    if not df.empty:
        with get_postgres_connection() as conn:
            with conn.cursor() as cursor:
                # Verificar IDs existentes na tabela do banco de dados
                cursor.execute(f"SELECT {info['coluna_id']} FROM raw.{info['tabela']}")
                existing_ids = [row[0] for row in cursor.fetchall()]

                # Filtra os dados do DataFrame para adicionar apenas novos IDs
                df = df[~df[info['coluna_id']].isin(existing_ids)]

                if not df.empty:  # Verifica se há novos dados para adicionar
                    columns = df.columns.tolist()
                    values = df.values.tolist()
                    
                    # Cria a string de consulta SQL para inserir os dados
                    insert_query = f"INSERT INTO raw.{info['tabela']} ({', '.join(columns)}) VALUES %s"
                    
                    # Usa execute_values para inserção em massa
                    execute_values(cursor, insert_query, values)
                    conn.commit()
                    print(f"Dados da planilha '{planilha}' inseridos com sucesso na tabela '{info['tabela']}' do PostgreSQL!")
                else:
                    print(f"Nenhum novo dado para inserir para a planilha '{planilha}'.")

print("Importação concluída com sucesso!")