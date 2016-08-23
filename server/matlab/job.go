package matlab

import (
	"fmt"
	"os/exec"
	"path/filepath"

	"github.com/pkg/errors"
	"github.com/satori/go.uuid"

	"github.com/at15/mk-fld/server/util"
)

var log = util.Logger

type Job struct {
	JobOption
	JobID string
}

type JobOption struct {
	MFile     string
	InputFile string
	LogFile   string
}

func NewJob(opt JobOption) (*Job, error) {
	if opt.MFile != "" {
		opt.MFile, _ = filepath.Abs(opt.MFile)
	} else {
		return &Job{}, errors.New("m file must be set")
	}
	if opt.InputFile != "" {
		opt.InputFile, _ = filepath.Abs(opt.InputFile)
	} else {
		return &Job{}, errors.New("input file must be set")
	}
	if opt.LogFile != "" {
		opt.LogFile, _ = filepath.Abs(opt.LogFile)
	} else {
		return &Job{}, errors.New("log file must be set")
	}

	// NOTE: uuid = char(java.util.UUID.randomUUID); can be used in matlab to generate uuid as well
	return &Job{
		JobOption: opt,
		JobID:     uuid.NewV4().String(),
	}, nil
}

func (j *Job) Run() {
	script := fmt.Sprintf("jobId='%s';inputFile='%s';logFile='%s';cd('%s');run('%s');exit;",
		j.JobID, j.InputFile, j.LogFile, filepath.Dir(j.MFile), j.MFile)
	log.Info(script)
	cmd := exec.Command("matlab", "-nosplash", "-nodesktop", "-nojvm", "-noFigureWindows", "-minimize",
		"-r", script)
	cmd.Run()
}
