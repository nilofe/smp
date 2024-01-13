package main

import (
	"go.uber.org/zap"
	"log"
)

func main() {
    logger, err := zap.NewProduction()
    if err != nil {
        log.Fatal(err)
    }

    gdp := logger.Sugar()

    gdp.Info("Hello World!")
}
