package cmd

import (
	"github.com/spf13/cobra"

	"github.com/at15/mk-fld/server/server"
)

var serverCmd = &cobra.Command{
	Use:   "server",
	Short: "start MK-FLD server",
	Long:  "MK-FLD server provide material data and spawn solver for submitted jobs",
	Run: func(cmd *cobra.Command, args []string) {
		s := server.NewServer(8000)
		s.Run()
	},
}

func init() {
	RootCmd.AddCommand(serverCmd)

}
