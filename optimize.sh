# Command example : ./optimize hello.mp4 world
# set -x 

echo "Optimization begins"

# The command must be executed as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root (sudo ./optimize)"
   exit 1
fi

# Check if ffmpeg and zip command are installed
if [ -z "$(which ffmpeg)" ]; then
  echo "ffmpeg is not installed"
  echo "Trying to install it..."

  # Install ffmpeg
  # Check for linux distro and mac
  if [ -f /etc/os-release ]; then
    # linux
    apt-get install ffmpeg -y
  elif [ -f /usr/bin/brew ]; then
    # mac
    brew install ffmpeg -y
  else
    echo "Please install ffmpeg manually"
    exit 1
  fi
fi

if [ -z "$(which zip)" ]; then
  echo "zip is not installed"
  echo "Trying to install it..."

  # Install zip
  # Check for linux distro and mac
  if [ -f /etc/os-release ]; then
    # linux
    apt-get install zip -y
  elif [ -f /usr/bin/brew ]; then
    # mac
    brew install zip -y
  else
    echo "Please install zip manually"
    exit 1
  fi
fi

# use env variable input and name
# $1 is mp4 input file
# $2 is output file name
# Check if input file exists
if [ -f $1 ]; then
    # Check if output file exists
    # Delete output file
    mkdir ./$2
    # Convert input file to output file
    # ffmpeg -i $1 -preset veryslow -r 30 -crf 20 -f image2 ./$2/%d.jpg
    ffmpeg -i "$1" -preset veryslow -r 30 -crf 20 -f image2 "./$2/%d.jpg" </dev/null
    zip -9 ./$2.zip ./$2/*
    rm -R ./$2
else
    echo "Input file does not exist"  
    exit 1
fi

echo "Done"