// +build windows

package util

import (
	"encoding/csv"
	"fmt"
	"os/exec"
	"strings"
)

type ProcessInfo struct {
	PID int
	// FIXME: should pare string
	Memory string
	// FIXME: should parse string and use number instead
	CPUTime string
	Running bool
	Status  string
}

func GetProcessInfo(pid int) (ProcessInfo, error) {
	p := ProcessInfo{PID: pid}
	// Use tasklist to get process information
	//  TASKLIST /FI "USERNAME ne NT AUTHORITY\SYSTEM" /FI "STATUS eq running"
	// "映像名称","PID","会话名      ","会话#   ","内存使用 ","状态  ","用户名   ","CPU 时间","窗口标题    "
	// "MATLAB.exe","1272","Console","3","172,564 K","Running","DESKTOP-GAC9MH5\tmp","0:00:40","MATLAB R2016a"
	command := exec.Command("tasklist", "/FI", fmt.Sprintf("PID eq %d", pid), "/FO", "CSV", "/V", "/NH")

	// Get output in bytes form
	output, err := command.CombinedOutput()
	if err != nil {
		log.Warn(err)
		return p, err
	}
	// log.Debug(string(output))
	r := csv.NewReader(strings.NewReader(string(output)))
	records, err := r.ReadAll()
	if err != nil {
		log.Error(err)
		return p, err
	}
	log.Debug(records)
	record := records[0]
	log.Debug(record)
	// log.Info(len(record))
	// for _, v := range record {
	// 	log.Info(v)
	// }
	p.Status = record[5]
	if record[5] == "Running" {
		p.Running = true
	} else {
		p.Running = false
	}
	log.Info(p.Running)
	p.Memory = record[4]
	p.CPUTime = record[7]
	log.Info(p)
	return p, nil
}
