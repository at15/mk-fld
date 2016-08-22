package cmd

import (
	"fmt"
	"os"

	"github.com/fatih/color"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"

	"github.com/at15/mk-fld/server/util"
)

var (
	cfgFile string
	version bool
	verbose bool
	dryRun  bool
)

var log = util.Logger

// RootCmd represents the base command when called without any subcommands
var RootCmd = &cobra.Command{
	Use:   "mk",
	Short: "MK-FLD server",
	Long:  `MK-FLD server start solver and track jobs`,
	Run: func(cmd *cobra.Command, args []string) {
		if version {
			fmt.Println("0.0.1")
		} else {
			color.Green("Use 'mk help' to see all commands")
		}
	},
}

// Execute adds all child commands to the root command sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	if err := RootCmd.Execute(); err != nil {
		// TODO: use logger
		// https://github.com/spf13/cobra/issues/304
		// error message is printed twice for command not found
		// fmt.Println(err)
		os.Exit(-1)
	}
}

func loadDefaultSettings() {
	viper.SetDefault("Verbose", false)
	viper.SetDefault("DryRun", false)
}

func bindRootCmdFlagsToViper() {
	viper.BindPFlag("Verbose", RootCmd.PersistentFlags().Lookup("verbose"))
	viper.BindPFlag("DryRun", RootCmd.PersistentFlags().Lookup("dry-run"))
}

func init() {
	cobra.OnInitialize(initConfig)

	// Here you will define your flags and configuration settings.
	// Cobra supports Persistent Flags, which, if defined here,
	// will be global for your application.

	RootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is $HOME/.ayi.yaml)")
	RootCmd.PersistentFlags().BoolVarP(&verbose, "verbose", "v", false, "verbose output")
	RootCmd.PersistentFlags().BoolVarP(&dryRun, "dry-run", "n", false, "show commands to execute")
	// Cobra also supports local flags, which will only run
	// when this action is called directly.
	RootCmd.Flags().BoolVar(&version, "version", false, "show current version")

	// https://github.com/spf13/viper#working-with-flags
	bindRootCmdFlagsToViper()
}

// initConfig reads in config file and ENV variables if set.
func initConfig() {
	if verbose {
		util.UseVerboseLog()
	}

	viper.AutomaticEnv() // read in environment variables that match

	// Set default value for viper
	loadDefaultSettings()
}
