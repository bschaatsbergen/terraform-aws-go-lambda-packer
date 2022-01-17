package main

import (
	"context"
	"my-lambda/printer"

	"github.com/aws/aws-lambda-go/lambda"
)

func HandleRequest(ctx context.Context, event map[string]interface{}) {
	printer.Print()
}

func main() {
	lambda.Start(HandleRequest)
}
