package main

import (
	"io/ioutil"
	"log"
	"os"
	"runtime"
)

func isOSX() bool {
	return runtime.GOOS == "darwin"
}

func fileExists(fname string) bool {
	if _, err := os.Stat(filename); err == nil {
		return true
	}
	return false
}

func symlinkDotfiles() {
	osxfiles := []map[string]struct{}{
		".osx":     struct{}{},
		"Brewfile": struct{}{},
	}

	dotfiles, err := ioutil.ReadDir("home")
	if err != nil {
		log.Println(err)
	}
	for _, fi := range dotfiles {
		if v, ok := osxfiles[fi.Name()]; !ok {

		}
	}
}

func main() {
}
