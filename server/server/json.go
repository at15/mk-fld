package server

import (
	"encoding/json"
	"fmt"

	"github.com/gocraft/web"
)

// Deal with json post and return as json

// https://github.com/gocraft/work/blob/master/webui/webui.go
func renderJSON(rw web.ResponseWriter, data interface{}, err error) error {
	// TODO: deal with error
	// TODO: allow config pretty indent
	str, err := json.Marshal(data)
	if err != nil {
		renderJSONError(rw, StatusInternalServerError, err)
		return err
	}
	rw.Write(str)
	return nil
}

func renderJSONError(rw web.ResponseWriter, status int, err error) {
	rw.WriteHeader(status)
	fmt.Fprintf(rw, `{error_msg: "%s"}`, err.Error())
}
