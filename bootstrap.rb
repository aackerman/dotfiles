require 'fileutils'

def is_mac?
	RUBY_PLATFORM.downcase.include?("darwin")
end

def exists? (file)
	File.exists?(file) || File.symlink?(file)
end

# create symlinks to dotfiles in $HOME
Dir.glob('home/*', File::FNM_DOTMATCH).tap { |a|
	a.shift(2)
}.each do | path |
	dotfile = path.gsub('home/', '')
	homefile = "#{Dir.home}/#{dotfile}"
	if exists? homefile
		FileUtils.rm_f homefile
		puts "#{homefile} deleted"
	end
	FileUtils.ln_sf File.absolute_path(path), File.absolute_path(homefile)
	puts "linked #{File.absolute_path(path)} -> #{File.absolute_path(homefile)}"
end

# install fonts
if is_mac?
	Dir.glob 'fonts/*.otf' do | file |
		libraryfile = "/Library/#{file}"
		unless exists? libraryfile
			FileUtils.cp file, libraryfile
		end
	end
end

# Copy vim directory
FileUtils.rm_f "#{Dir.home}/.vim" if exists? "#{Dir.home}/.vim"
FileUtils.cp_r '.vim', "#{Dir.home}/.vim"
