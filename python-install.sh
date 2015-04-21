# pip install
# sudo apt-get install -y python-pip
sudo easy_install -U pip

# upgrade ipython
sudo pip install --upgrade ipython
sudo apt-get install python3.4-dev

# required for scipy
sudo apt-get install gfortran libopenblas-dev liblapack-dev g++ -y

# required for matplotlib
sudo apt-get install build-essential python3-tk tk-dev libpng12-dev -y

#
sudo pip install -U mahotas
sudo pip install -U pandas
sudo pip install -U scikit-learn
sudo pip install -U numpy
sudo pip install -U scipy
sudo pip install -U see
sudo pip install -U pyflakes
sudo pip install -U requests
sudo pip install -U virtualenv

sudo easy_install -U nose
sudo easy_install -U guppy

# install opencv
sudo apt-get build-dep -y python-opencv
sudo pip install -U pyopencv

# if you have an error
# echo "/usr/lib/atlas-base" | sudo tee /etc/ld.so.conf.d/atlas-lib.conf
# sudo ldconfig
