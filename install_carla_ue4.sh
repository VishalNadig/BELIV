#! bin/bash

# ROS2 Galactic Installation
sudo apt install software-properties-common
sudo add-apt-repository universe
sudo apt update && sudo apt install curl gnupg lsb-release
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update # update your apt repo caches
sudo apt install ros-galactic-desktop
source /opt/ros/galactic/setup.bash
echo "source /opt/ros/galactic/setup.bash" >> ~/.bashrc
source ~/.bashrc

# UnrealEngine 4 setup
cd ~/
git clone https://github.com/VishalNadig/BELIV.git
cd ~/
git clone https://github.com/CarlaUnreal/UnrealEngine
cd UnrealEngine
./Setup.sh && ./GenerateProjectFiles.sh && make
mv ~/UnrealEngine ~/UnrealEngine-4.26

echo "export UE4_ROOT=~/UnrealEngine-4.26" >> ~/.bashrc

# Install and Build CARLA

sudo apt-get install aria2
sudo apt install ninja-build
sudo apt install clang-8
pip install --user setuptools && pip3 install --user -Iv setuptools==67.8.0 && pip install --user distro && pip3 install --user distro && pip install --user wheel && pip3 install --user wheel auditwheel
sudo apt install clang
cd ~/
git clone https://github.com/carla-simulator/carla.git
cd ~/carla
git checkout 0.9.13
./Update.sh

make PythonAPI 
cp ~/BELIV/carla-0.9.13-py3.7-linux-x86_64.egg ~/carla/PythonAPI/ 
echo "export PYTHONPATH=$PYTHONPATH:~/carla/PythonAPI/carla-0.9.13-py3.7-linux-x86_64.egg" >> ~/.bashrc
make launch