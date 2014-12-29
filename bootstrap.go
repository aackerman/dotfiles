package main

import (
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"runtime"
)

func isOSX() bool {
	return runtime.GOOS == "darwin"
}

func cp(src, dst string) error {
	s, err := os.Open(src)
	if err != nil {
		return err
	}
	// no need to check errors on read only file, we already got everything
	// we need from the filesystem, so nothing can go wrong now.
	defer s.Close()
	d, err := os.Create(dst)
	if err != nil {
		return err
	}
	if _, err := io.Copy(d, s); err != nil {
		d.Close()
		return err
	}
	return d.Close()
}

func fileExists(filename string) bool {
	if _, err := os.Stat(filename); err == nil {
		return true
	}
	return false
}

func InstallFonts() {
	if isOSX() {
		files, err := filepath.Glob("fonts/*.otf")
		if err != nil {
			log.Fatalln(err)
		}
		if files == nil {
			log.Fatalln("Unable to find fonts")
		}
		for _, f := range files {
			err := cp(f, "/Library/"+f)
			if err != nil {
				log.Fatalln(err)
			}
		}
	}
}

func SymlinkDotfiles() {
	osxfiles := map[string]struct{}{
		".osx":     struct{}{},
		"Brewfile": struct{}{},
	}

	dotfiles, err := ioutil.ReadDir("home")
	if err != nil {
		log.Fatalln(err)
	}

	for _, fi := range dotfiles {
		if _, ok := osxfiles[fi.Name()]; !ok {
			repofile, _ := filepath.Abs(fi.Name())
			homefile := filepath.Join(os.Getenv("HOME"), fi.Name())

			// remove symlink
			if err := os.Remove(repofile); err != nil {
				log.Fatalln(err)
			}
			// re-symlink
			if err := os.Symlink(repofile, homefile); err != nil {
				log.Fatalln(err)
			}
		}
	}
}

func SymlinkItermPrefs() {
	prefs := "Preferences.sublime-settings"
	repofile := fmt.Sprintf("sublime/%s", prefs)
	hostfile := fmt.Sprintf("%s/Library/Application Support/Sublime Text 2/Packages/User/%s", os.Getenv("HOME"), prefs)
	if err := os.Remove(hostfile); err != nil {
		log.Println(err)
	}
	if err := os.Symlink(repofile, hostfile); err != nil {
		log.Fatalln(err)
	}
}

func SymlinkSublimeSettings() {
	prefs := "Preferences.sublime-settings"
	repofile := fmt.Sprintf("sublime/%s", prefs)
	homefile := fmt.Sprintf("%s/Library/Preferences/%s", os.Getenv("HOME"), prefs)
	if err := os.Remove(homefile); err != nil {
		log.Println(err)
	}
	cp(repofile, homefile)
}

func main() {
	SymlinkDotfiles()
	if isOSX() {
		InstallFonts()
		SymlinkSublimeSettings()
		SymlinkItermPrefs()
	}
}
