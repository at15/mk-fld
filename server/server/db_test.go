package server

import (
	"os"
	"testing"

	"github.com/HouzuoGuo/tiedot/db"

	"github.com/stretchr/testify/assert"
)

func TestTieDot(t *testing.T) {
	assert := assert.New(t)
	tmpDir := "tmp"
	os.RemoveAll(tmpDir)
	defer os.RemoveAll(tmpDir)

	DB, err := db.OpenDB("tmp")
	assert.Nil(err)
	err = DB.Create("jobs")
	assert.Nil(err)
	err = DB.Close()
	assert.Nil(err)
}
