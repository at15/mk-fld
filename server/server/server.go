package server

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"strings"

	"github.com/at15/mk-fld/server/material"
	"github.com/at15/mk-fld/server/util"
	"github.com/gocraft/web"
	"github.com/pkg/errors"
)

var log = util.Logger

type Server struct {
	Port   int
	Router *web.Router
}

type MkContext struct {
}

func (c *MkContext) test(rw web.ResponseWriter, req *web.Request) {
	data := make(map[string]string)
	data["foo"] = "bar"
	renderJSON(rw, data, nil)
}

func (c *MkContext) listAllMaterials(rw web.ResponseWriter, req *web.Request) {
	log.Debug("list all materials")
	files, err := ioutil.ReadDir("./data/materials")
	if err != nil {
		renderJSONError(rw, StatusInternalServerError, err)
		return
	}
	var materials []string
	for _, file := range files {
		// skip subfolders
		if file.IsDir() {
			continue
		}
		fileName := file.Name()
		// FIXME: this won't work on linux since only windows filesytem is case insensitive
		materials = append(materials, strings.ToUpper(fileName[:len(fileName)-5]))
	}
	renderJSON(rw, materials, nil)
}

func (c *MkContext) getMaterial(rw web.ResponseWriter, req *web.Request) {
	materialName := req.PathParams["name"]
	buf, err := ioutil.ReadFile("./data/materials/" + materialName + ".json")
	if err != nil {
		renderJSONError(rw, StatusNotFound, errors.Wrap(err, "Can't read material data"))
	}
	log.Debug(string(buf))
	var parsed material.Material
	err = json.Unmarshal(buf, &parsed)
	if err != nil {
		renderJSONError(rw, StatusNotFound, errors.Wrap(err, "Can't parse JSON"))
	}
	log.Debug(parsed)
	renderJSON(rw, parsed, nil)
}

func NewServer(port int) *Server {
	s := Server{}
	s.Port = port
	s.Router = web.New(MkContext{})
	s.Router.Get("/test", (*MkContext).test)
	s.Router.Get("/materials", (*MkContext).listAllMaterials)
	s.Router.Get("/materials/:name", (*MkContext).getMaterial)

	return &s
}

func (server *Server) Run() {
	log.Info("Start server on " + fmt.Sprintf("localhost:%d", server.Port))
	http.ListenAndServe(fmt.Sprintf("localhost:%d", server.Port), server.Router)
}
