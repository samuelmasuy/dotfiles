function my_ip --description 'Display ip address'
    ifconfig | grep broadcast | awk '{print $6}'
end
