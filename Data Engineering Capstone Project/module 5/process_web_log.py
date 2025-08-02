from datetime import timedelta
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.utils.dates import days_ago

default_args = {
    'owner':'u115',
    'start_date':days_ago(0),
    'email': ['115010087@link.cuhk.edu.cn'],
    'email_on_failure':True,
    'email_on_retry':True,
    'retries':1,
    'retry_delay':timedelta(minutes = 5)
}

dag = DAG(
    dag_id='process_web_log',
    default_args=default_args,
    description='A daily dag about processing web log',
    schedule_interval=timedelta(days=1)
)

def extract_data():
    input_file = "/home/project/airflow/dags/capstone/accesslog.txt"
    output_file = "/home/project/airflow/dags/capstone/extracted_data.txt"
    with open(input_file, "r") as infile, open(output_file, "w") as outfile:
        for line in infile:
            ip = line.split()[0]
            outfile.write(ip + "\n")

extract_task = PythonOperator(
    task_id='extract_data',
    python_callable=extract_data,
    dag=dag,
)

def transform_data():
    input_file = "/home/project/airflow/dags/capstone/extracted_data.txt"
    output_file = "/home/project/airflow/dags/capstone/transformed_data.txt"
    with open(input_file, "r") as infile, open(output_file, "w") as outfile:
        for line in infile:
            if line.strip() != "198.46.149.143":
                outfile.write(line)

transform_task = PythonOperator(
    task_id='transform_data',
    python_callable=transform_data,
    dag=dag,
)
