package cmd

import (
	"os"

	"github.com/spf13/cobra"

	"github.com/at15/mk-fld/server/matlab"
)

// start new job, list existing jobs

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
		}
	},
}

func init() {
	jobCmd.AddCommand(jobNewCmd)
	RootCmd.AddCommand(jobCmd)

}
