# If on linux, apt update

if [ -f /etc/os-release ]; then
  apt update && apt install curl -y
fi

# Execute https://raw.githubusercontent.com/techtastet/video-2-zip/main/optimize.sh with the arguments passed to this script
curl -sL https://raw.githubusercontent.com/techtastet/video-2-zip/main/optimize.sh | bash -s "$@"