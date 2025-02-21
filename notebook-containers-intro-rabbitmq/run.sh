#!/bin/bash
# Construire l'image
docker build -t rabbitmq-client .

# creer le reseau
docker network rm mq-net
docker network create mq-net

# Lancer le serveur
docker run -d --rm \
    --network mq-net \
    --hostname rabbitmq \
    --name rabbitmq rabbitmq:3

sleep 5

# Lancer le producteur
$(docker run --rm --network mq-net \
    rabbitmq-client 'import pika; connection = pika.BlockingConnection(pika.ConnectionParameters("amqp://guest:guest@rabbitmq")); channel = connection.channel(); channel.queue_declare(queue="hello"); channel.basic_publish(exchange="", routing_key="hello", body="Hello World!")'
)
# Lancer le consommateur
$(docker run --rm --network mq-net \
    rabbitmq-client 'import pika; connection = pika.BlockingConnection(pika.ConnectionParameters("amqp://guest:guest@rabbitmq")); channel = connection.channel(); channel.queue_declare(queue="hello"); channel.basic_consume(queue="hello", on_message_callback=lambda ch, method, properties, body: print(body), auto_ack=True); channel.start_consuming()'
    )

sleep 5
docker stop rabbitmq