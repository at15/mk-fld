package cmd

import (
	"os"

	"github.com/spf13/cobra"

	"github.com/at15/mk-fld/server/matlab"
	"github.com/at15/mk-fld/server/util"
)

// start new job, list existing jobs
var pid int

var jobCmd = &cobra.Command{
	Use:   "job",
	Short: "start or monitor jobs",
	Long:  "start a new job from command line or monitor jobs submitted from gui",
	Run: func(cmd *cobra.Command, args []string) {

	},
}

var jobNewCmd = &cobra.Command{
	Use:   "new",
	Short: "create a new job",
	Long:  "assign new job id and start a headless matlab process to handle the job",
	Run: func(cmd *cobra.Command, args []string) {
		job, err := matlab.NewJob(matlab.JobOption{
			MFile:     "E:\\workspace\\src\\github.com\\at15\\mk-fld\\src\\solver\\fld_solver_main.m",
			LogFile:   "b.log",
			InputFile: "a.fldin",
		})
		if err != nil {
			log.Error(err.Error())
			os.Exit(1)
		} else {
			job.Run()
			log.Info("Job finished")
		}
	},
}

var jobPIDCmd = &cobra.Command{
	Use:   "pid",
	Short: "monitor process via pid",
	Long:  "get process status via pid",
	Run: func(cmd *cobra.Command, args []string) {
		log.Infof("PID %d", pid)
		if pid == 0 {
			log.Error("Invalid PID")
			return
		}
		_, err := os.FindProcess(pid)
		if err != nil {
			log.Errorf("Can't find process: %s", err.Error())
			return
		}

		util.GetProcessInfo(pid)
	},
}

func init() {
	jobCmd.AddCommand(jobNewCmd)
	jobCmd.AddCommand(jobPIDCmd)
	RootCmd.AddCommand(jobCmd)

	jobPIDCmd.Flags().IntVar(&pid, "pid", 0, "pid for the process you want to monitor")
}
