FROM python:3.9-alpine

# Installation de pika
RUN pip install --no-cache-dir pika==1.3.2

# Répertoire de travail
WORKDIR /app

# Définir l'interpréteur Python comme point d'entrée
ENTRYPOINT ["python", "-c"]

# Commande par défaut (peut être surchargée)
CMD ["print('Ready to handle RabbitMQ messages')"]