package main

import (
	"fmt"
	"io/ioutil"
	"strings"

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
	iris.Get("/materials", listAllMaterials)
	// used to test if returning json is working
	iris.Get("/json", testGetJSON)
	iris.Listen(":8000")
}

func listAllMaterials(ctx *iris.Context) {
	// TODO: specify app data folder
	files, err := ioutil.ReadDir("./data/materials")
	if err != nil {
		ctx.JSON(iris.StatusInternalServerError, map[string]string{"err_msg": "Can't read materials data"})
	}
	var materials []string
	for _, file := range files {
		// skip subfolders
		if file.IsDir() {
			continue
		}
		fileName := file.Name()
		// fmt.Println(file.Name())
		// fmt.Println(fileName[:len(fileName)-5])
		materials = append(materials, strings.ToUpper(fileName[:len(fileName)-5]))
	}
	// fmt.Println(materials)
	ctx.JSON(iris.StatusOK, materials)
}

func testGetJSON(ctx *iris.Context) {
	ctx.JSON(iris.StatusOK, map[string]string{"hello": "json"})
}
