// +build windows

package util

import (
	"fmt"
	"os/exec"
	"strings"
)

type ProcessInfo struct {
	PID    int
	Memory int
	// FIXME: should parse the string and use number instead
	CPUTime string
	Running bool
	Status  string
}

func GetProcessInfo(pid int) (ProcessInfo, error) {
	p := ProcessInfo{PID: pid}
	// use tasklist
	//  TASKLIST /FI "USERNAME ne NT AUTHORITY\SYSTEM" /FI "STATUS eq running"
	// command := exec.Command("tasklist", "/FI", fmt.Sprintf("PID eq %d", pid), "/FO", "CSV", "/V", "/NH")
	command := exec.Command("tasklist", "/FI", fmt.Sprintf("PID eq %d", pid), "/FO", "TABLE", "/V", "/NH")

	// "映像名称","PID","会话名      ","会话#   ","内存使用 ","状态  ","用户名   ","CPU 时间","窗口标题    "
	// "MATLAB.exe","1272","Console","3","172,564 K","Running","DESKTOP-GAC9MH5\tmp","0:00:40","MATLAB R2016a"
	// Redirect to console
	// command.Stdout = os.Stdout
	// command.Stderr = os.Stderr
	// Get output in bytes form
	output, err := command.CombinedOutput()
	if err != nil {
		log.Warn(err)
		return p, err
	}
	log.Info(string(output))
	// cols := strings.Split(string(output), ",")
	cols := strings.Split(string(output), " ")
	data := make([]string, len(cols))
	for i, v := range cols {
		// FIXME: the last elements's " is not trimed
		// data[i] = strings.Trim(v, "\"")
		data[i] = strings.Trim(v, " ")

	}
	log.Info(cols)
	log.Info(data)
	// if data[5] == "Running" {
	// 	p.Running = true
	// } else {
	// 	p.Running = false
	// }
	// TODO: mem and cpu time
	return p, nil
}
