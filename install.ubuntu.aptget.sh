echo "Ubuntu apt-get update...";
sudo apt-get update -y;  

echo "Ubuntu apt-get install...";
sudo apt-get install  -y \
  --fix-missing \
  git \
  g++ \
  unzip \
  vim \
  make \
  mysql-client \
  openjdk-8-jdk \
  ant \
  gradle \
  maven \
  # build-essential \
  # python \
  # python-dev \
  # python-software-properties \
  # software-properties-common \
  # supervisor \
  # automake \
  # gnuplot \
  curl \
  tmux;
