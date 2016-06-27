package main

import (
	"fmt"

	"github.com/iris-contrib/middleware/logger"
	"github.com/kataras/iris"
)

func main() {
	fmt.Println("Starting server ....")
	iris.Use(logger.New(iris.Logger, logger.Config{
		EnableColors: true,
		IP:           true,
		Method:       true,
	}))
	iris.Get("/json", func(ctx *iris.Context) {
		ctx.JSON(iris.StatusOK, map[string]string{"hello": "json"})
	})
	iris.Listen(":8000")
}
