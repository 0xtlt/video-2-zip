# If on linux and curl not detected, apt update and install curl
if [ -f /etc/os-release ]; then
    if [ -z "$(which curl)" ]; then
        echo 'curl not detected, installing...'
        apt update && apt upgrade -y && apt install curl -y
    fi
fi

echo 'Downloading script...'

curl -sL https://raw.githubusercontent.com/techtastet/video-2-zip/main/optimize.sh | bash -s $1 $2