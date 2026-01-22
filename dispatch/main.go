package main

import (
	"encoding/json"
	"log"
	"math/rand"
	"os"
	"time"

	"github.com/streadway/amqp"
)

var (
	amqpUri string
	dataCenters = []string{
		"asia-northeast2",
		"asia-south1",
		"europe-west3",
		"us-east1",
		"us-west1",
	}
)

func main() {
	amqpUri = os.Getenv("AMQP_HOST")
	if amqpUri == "" {
		amqpUri = "amqp://guest:guest@rabbitmq:5672/"
	}

	log.Printf("Dispatch service starting...")
	log.Printf("AMQP URI: %s", amqpUri)

	var conn *amqp.Connection
	var err error

	// Retry loop for connection (30 attempts)
	for i := 0; i < 30; i++ {
		conn, err = amqp.Dial(amqpUri)
		if err == nil {
			break
		}
		log.Printf("Failed to connect to RabbitMQ, retrying in 5 seconds... (%d/30)", i+1)
		time.Sleep(5 * time.Second)
	}

	if err != nil {
		log.Fatal("Failed to connect to RabbitMQ:", err)
	}
	defer conn.Close()

	ch, err := conn.Channel()
	if err != nil {
		log.Fatal("Failed to open channel:", err)
	}
	defer ch.Close()

	q, err := ch.QueueDeclare(
		"orders",
		true,
		false,
		false,
		false,
		nil,
	)
	if err != nil {
		log.Fatal("Failed to declare queue:", err)
	}

	msgs, err := ch.Consume(
		q.Name,
		"",
		true,
		false,
		false,
		false,
		nil,
	)
	if err != nil {
		log.Fatal("Failed to register consumer:", err)
	}

	log.Printf("Connected to RabbitMQ, waiting for messages...")

	forever := make(chan bool)

	go func() {
		for msg := range msgs {
			processOrder(msg.Body)
		}
	}()

	<-forever
}

func processOrder(body []byte) {
	var order map[string]interface{}
	err := json.Unmarshal(body, &order)
	if err != nil {
		log.Printf("Error parsing order: %v", err)
		return
	}

	datacenter := dataCenters[rand.Intn(len(dataCenters))]
	log.Printf("Order dispatched to datacenter: %s - %v", datacenter, order)
}
