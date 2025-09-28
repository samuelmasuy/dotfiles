function e --description 'Open the program passed as an argument in nvim'
    nvim (/usr/bin/which $argv[1])
end
