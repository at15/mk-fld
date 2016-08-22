package server

import (
	"io/ioutil"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/stretchr/testify/assert"
)

// https://golang.org/pkg/net/http/httptest/

func TestGetJSON(t *testing.T) {
	assert := assert.New(t)
	ts := httptest.NewServer(NewServer(8000).Router)
	defer ts.Close()

	res, err := http.Get(ts.URL + "/test")
	defer res.Body.Close()
	assert.Nil(err)
	assert.Equal(200, res.StatusCode)
	content, err := ioutil.ReadAll(res.Body)
	assert.Equal(`{"foo":"bar"}`, string(content[:]))

}
