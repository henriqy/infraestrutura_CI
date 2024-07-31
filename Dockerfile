# imagem base do Python
FROM python:3.9-slim

# Diretório de trabalho
WORKDIR /app

# Copiar os arquivos requirements.txt e instalar as dependências
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copiar o código do aplicativo para o contêiner
COPY . .

# Comando padrão para rodar os testes
CMD ["pytest", "tests/"]
