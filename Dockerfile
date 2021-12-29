# syntax=docker/dockerfile:1
FROM python:3.9.7-slim

RUN apt update && apt install -y --no-install-recommends gcc

RUN useradd -ms /bin/bash python

ENV MY_PYTHON_PACKAGES=/home/python/app/__pypackages__/3.9
ENV PATH $PATH:${MY_PYTHON_PACKAGES}/bin

# serve para mostrar os logs de erros
ENV PYTHONUNBUFFERED=1

# não criar arquivos .pyc
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONFAULTHANDLER=1

RUN pip install pdm

USER python

RUN mkdir /home/python/app

# trabalhando com o diretório dentro da pasta do usuário
WORKDIR /home/python/app

RUN /bin/bash -c "pdm --pep582 >> ~/.bashrc"