require 'fileutils'

def home
	Dir.home + '/'
end

def is_mac?
	RUBY_PLATFORM.downcase.include?("darwin")
end

def exists_or_link? (file)
	File.exists?(file) || File.symlink?(file)
end

# create symlinks to dotfiles in $HOME
[
	'.aliases',
	'.bash_profile',
	'.profile',
	'.vimrc',
	'.bash_prompt',
	'.gitconfig'
].each do | file |
	homefile = home + file
	if exists_or_link? homefile
		FileUtils.rm_f homefile
	end
	FileUtils.symlink File.absolute_path(file), homefile
end

# install fonts
if is_mac?
	Dir.glob 'fonts/*.otf' do | file |
		libraryfile = '/Library/' + file
		unless exists_or_link? libraryfile
			FileUtils.cp file, libraryfile
		end
	end
end

unless exists_or_link? home + '.vim'
	FileUtils.cp_r '.vim', home + '.vim'
end

unless exists_or_link? home + 'bin'
	FileUtils.cp_r 'bin', home + 'bin'
end
