# --------------------Análise Academia RedFit --------------------
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# -------------------- Extração --------------------
try:
    df = pd.read_csv("redfit_clientes.csv")
    print(" Dados da RedFit carregados!")
except FileNotFoundError:
    print(" CSV não encontrado, criando base de exemplo...")

    df = pd.DataFrame({
        "id_cliente": [1, 2, 3, 4, 5, 6],
        "idade": [25, 32, 40, 28, 50, 22],
        "sexo": ["M", "F", "M", "F", "M", "F"],
        "frequencia_treino": [3, 1, 5, 2, 6, 4],   # vezes por semana
        "tipo_atividade": ["Musculação", "Yoga", "Crossfit", "Pilates", "Musculação", "Funcional"],
        "tempo_exercicio": [45, 30, 60, 40, 70, 55],  # minutos
        "PGC_inicial": [25, 32, 28, 30, 35, 27],
        "PGC_atual": [20, 31, 22, 28, 30, 24],
        "plano": ["Mensal", "Trimestral", "Anual", "Mensal", "Anual", "Trimestral"],
        "estado": ["Ativa", "Sedentária", "Atleta", "Ativa", "Sedentária", "Ativa"],
        "altura_m": [1.75, 1.62, 1.80, 1.68, 1.85, 1.60],
        "peso_kg": [72, 70, 85, 65, 95, 55],
        "data_matricula": ["2022-01-10", "2021-11-05", "2022-02-15", "2021-12-01", "2022-03-01", "2022-01-20"]
    })

# -------------------- Transformação --------------------
print("\n Tratando os dados...")

# Padronizar categorias
df['sexo'] = df['sexo'].str.upper().replace({"M": "Masculino", "F": "Feminino"})
df['estado'] = df['estado'].str.capitalize()
df['tipo_atividade'] = df['tipo_atividade'].str.capitalize()

# Converter data
df['data_matricula'] = pd.to_datetime(df['data_matricula'], errors="coerce")

# Criar novas métricas
df['IMC'] = df['peso_kg'] / (df['altura_m'] ** 2)
df['evolucao_PGC'] = df['PGC_inicial'] - df['PGC_atual']

# -------------------- Carga --------------------
df.to_csv("redfit_clientes_tratado.csv", index=False)
print(" Dados tratados salvos em 'redfit_clientes_tratado.csv'")

print("\n Prévia dos dados tratados:")
print(df.head())

# -------------------- Análise Exploratória --------------------
print("\n Análise gráfica...")

# Gráfico de barras - Estado
plt.figure(figsize=(6,4))
df['estado'].value_counts().plot(kind='bar', color=['#1f77b4', '#ff7f0e', '#2ca02c'])
plt.title("Distribuição de Clientes por Estado Físico")
plt.xlabel("Estado")
plt.ylabel("Número de Clientes")
plt.xticks(rotation=0)
plt.show()

# Gráfico de Pizza - Planos
plt.figure(figsize=(6,6))
df['plano'].value_counts().plot(kind='pie', autopct='%1.1f%%', colors=['#66b3ff','#99ff99','#ff9999'])
plt.title("Distribuição dos Planos da Academia")
plt.ylabel("")
plt.show()

# -------------------- Machine Learning --------------------
print("\n Construindo modelo de classificação...")

from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report, confusion_matrix

# Features
X = df[['idade', 'frequencia_treino', 'tempo_exercicio', 'PGC_atual', 'IMC', 'evolucao_PGC']]
y = df['estado']

# Dividir treino/teste
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# Modelo
modelo = RandomForestClassifier(random_state=42, n_estimators=100)
modelo

