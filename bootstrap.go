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

func fileExists(fname string) bool {
	if _, err := os.Stat(filename); err == nil {
		return true
	}
	return false
}

func installFonts() {
	if isOSX() {
		files, err := filepath.Glob("fonts/*.otf")
		if err != nil {
			fmt.Fatalln(err)
		}
		if files == nil {
			fmt.Fatalln("Unable to find fonts")
		}
		for _, f := range files {
			err := cp(f, "/Library/" + f)
			if err != nil {
				fmt.Fatalln(err)
			}
		}
	}
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

func installFonts() {

}

func main() {
	symlinkDotfiles()
	if isOSX() {
		installFonts()
	}
}