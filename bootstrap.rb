require 'fileutils'

class Bootstrap
  class << self
    def osx?
      RUBY_PLATFORM.downcase.include?("darwin")
    end

    def file_exists? (file)
      File.exists?(file) || File.symlink?(file)
    end

    def dotfiles
      Dir.glob('home/*', File::FNM_DOTMATCH).tap { |a| a.shift(2) }
    end

    def symlink_dotfiles!
      dotfiles.each do | path |
        dotfile = File.basename(path)
        homefile = "#{Dir.home}/#{dotfile}"

        # remove the current file if it exists
        FileUtils.rm_f homefile if file_exists? homefile

        # symlink the file checked in git to the home path
        FileUtils.ln_sf File.absolute_path(path), File.absolute_path(homefile)
        print_link File.basename(path), File.absolute_path(homefile)
      end
    end

    def install_fonts!
      if osx?
        Dir.glob 'fonts/*.otf' do | file |
          libraryfile = "/Library/#{file}"
          unless file_exists? libraryfile
            FileUtils.cp file, libraryfile
          end
        end
      end
    end

    def symlink_vim_directory!
      vim_home = "#{Dir.home}/.vim"
      FileUtils.rm_f vim_home if file_exists? vim_home
      FileUtils.ln_sf File.absolute_path('.vim'), vim_home
      print_link '.vim', vim_home
    end

    def print_link(src, dest)
      printf "%27s -> %s\n", src, dest.gsub!('/Users/aackerman', '~')
    end

    def copy_iterm_profile!
      iterm_prefs = "com.googlecode.iterm2.plist"
      home_path = "#{Dir.home}/Library/Preferences/#{iterm_prefs}"
      local_path = "terminal/#{iterm_prefs}"

      FileUtils.rm_f home_path
      FileUtils.cp local_path, home_path
      print_link iterm_prefs, home_path
    end

    def run!
      symlink_dotfiles!
      symlink_vim_directory!
      copy_iterm_profile!
      install_fonts!
    end
  end
end

Bootstrap.run!
