# cd in the previous directory.
alias cdp="cd ~-"
# Display all files and directories including the hidden ones, with precision.
alias la='ls -lA'
alias ls='ls -G'
# Make the terminal say all the files and directories.
alias lt="ls | say -vz"
# Open the given directory in finder.
alias f='open -a Finder ./'
# Clear the terminal
alias c='clear'
# Beautiful Cat
alias cat='colorize'
# Correct mistyping.
alias pyhton='python'
alias ipyhton='ipython'
# Prevent the system from sleeping for one hour.
alias cafe='caffeinate -t 3600 &'
# Convert markdown to html
alias toHtml='markdown_py'
# Display a clock on the upper right hand side of the terminal.
alias clock='while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &'
# Open mac vim
alias mvim='open -a macvim'
alias subl="/opt/homebrew-cask/Caskroom/sublime-text3/Build\ 3059/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias xamp='cd /Applications/XAMPP/xamppfiles/'

