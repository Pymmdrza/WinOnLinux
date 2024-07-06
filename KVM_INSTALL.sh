{
    curl -fL https://github.com/Pymmdrza/WinOnLinux/raw/main/vkvm.tar.gz -o /tmp/vkvm.tar.gz &&
    tar -xzvf /tmp/vkvm.tar.gz -C /tmp &&
    rm /tmp/vkvm.tar.gz
} || {
    echo "An error occurred during download or extraction." >&2
    exit 1
}
