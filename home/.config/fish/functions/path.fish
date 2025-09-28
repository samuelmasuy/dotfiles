function path --description 'Display neatly formatted path of the system'
    echo $PATH | tr ":" "\n" | awk '{ sub("/usr",   "\033[32m/usr\033[0m"); \
               sub("/bin",   "\033[34m/bin\033[0m"); \
               sub("/opt",   "\033[36m/opt\033[0m"); \
               sub("/sbin",  "\033[35m/sbin\033[0m"); \
               sub("/local", "\033[33m/local\033[0m"); \
               print }'
end
