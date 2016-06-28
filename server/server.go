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
	// used to test if returning json is working
	iris.Get("/json", testGetJSON)
	iris.Listen(":8000")
}

func testGetJSON(ctx *iris.Context) {
	ctx.JSON(iris.StatusOK, map[string]string{"hello": "json"})
}
