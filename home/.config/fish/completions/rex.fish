# Generate completions from the installed Rex version.
if type -q rex
    command rex completion fish | source
end
