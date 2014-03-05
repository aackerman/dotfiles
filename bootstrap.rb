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
        dotfile = path.gsub('home/', '')
        homefile = "#{Dir.home}/#{dotfile}"

        # remove the current file if it exists
        if file_exists? homefile
          FileUtils.rm_f homefile
        end

        # symlink the file checked in git to the home path
        FileUtils.ln_sf File.absolute_path(path), File.absolute_path(homefile)
        puts "linked #{File.basename(path)} -> #{File.absolute_path(homefile)}"
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
      puts "linked #{File.absolute_path('.vim')} -> #{vim_home}"
      FileUtils.ln_sf File.absolute_path('.vim'), vim_home
    end

    def run!
      symlink_dotfiles!
      symlink_vim_directory!
      install_fonts!
    end
  end
end

Bootstrap.run!
