package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"strings"

	"github.com/iris-contrib/middleware/logger"
	"github.com/kataras/iris"

	"github.com/at15/mk-fld/server/material"
)

func main() {
	fmt.Println("Starting server ....")
	iris.Use(logger.New(iris.Logger, logger.Config{
		EnableColors: true,
		IP:           true,
		Method:       true,
	}))
	iris.Get("/materials", listAllMaterials)
	iris.Get("/materials/:name", getMaterial)
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

func getMaterial(ctx *iris.Context) {
	materialName := ctx.Param("name")
	buf, err := ioutil.ReadFile("./data/materials/" + materialName + ".json")
	var errMsg string
	if err != nil {
		errMsg = "Can't read material data: " + err.Error()
		ctx.JSON(iris.StatusInternalServerError, map[string]string{"err_msg": errMsg})
	}
	// print the json for debug
	// TODO: add debug flag using viper
	fmt.Println(string(buf))
	var parsed material.Material
	err = json.Unmarshal(buf, &parsed)
	if err != nil {
		errMsg = "Cant't parse JSON: " + err.Error()
		ctx.JSON(iris.StatusInternalServerError, map[string]string{"err_msg": errMsg})
	}
	// print the parsed json for debug
	fmt.Println(parsed)
	// fmt.Println(parsed.R["0"])
	ctx.JSON(iris.StatusOK, parsed)
}

func testGetJSON(ctx *iris.Context) {
	ctx.JSON(iris.StatusOK, map[string]string{"hello": "json"})
}
