package matlab

import (
	"fmt"
	"os/exec"
	"path/filepath"
)

type Command struct {
	MFile     string
	InputFile string
	LogFile   string
}

func NewCommand(m string, fldin string, log string) *Command {
	m, _ = filepath.Abs(m)
	fldin, _ = filepath.Abs(fldin)
	log, _ = filepath.Abs(log)
	return &Command{MFile: m, InputFile: fldin, LogFile: log}
}

func (c *Command) Run() {
	script := fmt.Sprintf("inputFile='%s';logFile='%s';cd('%s');run('%s');exit;",
		c.InputFile, c.LogFile, filepath.Dir(c.MFile), c.MFile)
	fmt.Println(script)
	cmd := exec.Command("matlab", "-nosplash", "-nodesktop", "-nojvm", "-noFigureWindows", "-minimize",
		"-r", script)
	cmd.Run()
}
