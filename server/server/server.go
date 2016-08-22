package server

import (
	"fmt"
	"net/http"

	"github.com/at15/mk-fld/server/util"
	"github.com/gocraft/web"
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

func NewServer(port int) *Server {
	s := Server{}
	s.Port = port
	s.Router = web.New(MkContext{})
	s.Router.Get("/test", (*MkContext).test)

	return &s
}

func (server *Server) Run() {
	log.Info("Start server on " + fmt.Sprintf("localhost:%d", server.Port))
	http.ListenAndServe(fmt.Sprintf("localhost:%d", server.Port), server.Router)
}
