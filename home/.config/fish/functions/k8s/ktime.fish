function ktime --description 'Prefix each line of output with a timestamp'
    while read line
        echo -e (gdate +"%Y-%m-%d %H:%M:%S.%3N")"\t $line"
    end
end
