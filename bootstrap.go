package main

import (
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
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
		log.Fatalln(err)
	}

	for _, fi := range dotfiles {
		if v, ok := osxfiles[fi.Name()]; !ok {
			repofile := filepath.Abs(fi.Name())
			homefile := filepath.Join(os.Getenv("HOME"), fi.Name())

			// remove symlink
			if err := os.Remove(abspath); err != nil {
				log.Fatalln(err)
			}
			// re-symlink
			if err := os.Symlink(repofile, homefile); err != nil {
				log.Fatalln(err)
			}
		}
	}
}

func main() {
}
