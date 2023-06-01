Installation
----

ROS2 Galactic Installation
""""

To use the software, first install ROS2 Galactic on your Ubuntu 20.04 desktop environment.

.. code-block:: console

   sudo apt install software-properties-common
   sudo add-apt-repository universe
   sudo apt update && sudo apt install curl gnupg lsb-release
   sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
   sudo apt update # update your apt repo caches
   sudo apt install ros-galactic-desktop

Then source the setup of ROS2 on bash by running the following commands:

.. code-block:: console

   source /opt/ros/galactic/setup.bash
   echo "source /opt/ros/galactic/setup.bash" >> ~/.bashrc
   source ~/.bashrc


Run Some Examples
""""
To verify that ROS2 Galactic has been installed properly run the following commands:

.. code-block:: console

   ros2 run demo_nodes_cpp talker

The output should confirm that the talker is successfully publishing messages:

.. code-block:: console

   [INFO] [1652382860.246687611] [talker]: Publishing: 'Hello World: 1'
   [INFO] [1652382861.250208871] [talker]: Publishing: 'Hello World: 2'
   [INFO] [1652382862.246508551] [talker]: Publishing: 'Hello World: 3'
   ...

In another terminal window, run the example Python listener

.. code-block:: console

   ros2 run demo_nodes_py listener
   
The output should confirm that the listener is hearing the published messages:

.. code-block:: console

   [INFO] [1652382936.495044030] [listener]: I heard: [Hello World: 1]
   [INFO] [1652382937.478216343] [listener]: I heard: [Hello World: 2]
   [INFO] [1652382938.487370309] [listener]: I heard: [Hello World: 3]
   ...

If all the above steps worked and the listener node is printing messages to your console in sync with the talker node publishing them, ROS2 has been successfully installed.


.. note:: 
   
   Clone this repository before proceeding with next steps:

   .. code-block:: console

      cd ~/
      git clone https://github.com/VishalNadig/BELIV.git


UnrealEngine Setup
""""

1) Please visit: `Unreal Engine <https://www.unrealengine.com/en-US/ue-on-github>`_ for steps to get access to the UnrealEngine repository.
2) Clone the `Unreal Engine For CARLA GitHub <https://github.com/CarlaUnreal/UnrealEngine>`_ and check if you can see the UnrealEngine Repository.

.. code-block:: console
   
   cd ~/
   git clone https://github.com/CarlaUnreal/UnrealEngine

3) Then setup the UnrealEngine using the following commands:

.. code-block:: console

   ./Setup.sh && ./GenerateProjectFiles.sh && make
   mv ~/UnrealEngine ~/UnrealEngine-4.26

The installation takes over an hour or two to finish. Might be slower if your laptop has lower end specs.

4) Add UnrealEngine to environment variables

.. code-block:: console

   gedit ~/.bashrc

5) In the last line of the .bashrc file, write

.. code-block:: console

   export UE4_ROOT=~/UnrealEngine-4.26

Install and Build CARLA
""""

1) Downloading aria2 will speed up the following commands.

.. code-block:: console

   sudo apt-get install aria2

2) Install Ninja tool and clang-8 required to build the PythonAPI and the important python libraries using:

.. code-block:: console

   sudo apt install ninja-build
   sudo apt install clang-8
   pip install --user setuptools && pip3 install --user -Iv setuptools==67.8.0 && pip install --user distro && pip3 install --user distro && pip install --user wheel && pip3 install --user wheel auditwheel
   sudo apt install clang

3) Clone the CARLA repository found here: `CARLA GitHub <https://github.com/carla-simulator/carla.git>`_ into your home directory.
Then go into the carla repository that was just cloned and get the latest assets.

.. code-block:: console
   
   cd ~/
   git clone https://github.com/carla-simulator/carla.git
   cd ~/carla
   ./Update.sh

4) Compile the Python API client:

The Python API client grants control over the simulation. Compilation of the Python API client is required the first time you build CARLA and again after you perform any updates. After the client is compiled, you will be able to run scripts to interact with the simulation.

The following command compiles the Python API client:

.. code-block:: console

    make PythonAPI
 
If xerces-c3.2.3 cannot be downloaded from  cannot be downloaded because of a 404 not found error then comment line 

.. code-block:: console

   "XERCESC_REPO=https://ftp.cixug.es/apache//xerces/c/3/sources/xerces-c-${XERCESC_VERSION}.tar.gz"

in line 432 in Setup.sh and add the following line below it and run make PythonAPI from command above again

.. code-block:: console

   "XERCESC_REPO=https://archive.apache.org/dist/xerces/c/3/sources/xerces-c-${XERCESC_VERSION}.tar.gz"


5) Copy the carla-0.9.13-py3.7-linux-x86_64.egg file from BELIV/ to carla/PythonAPI/ folder.

.. code-block:: console

   cp ~/BELIV/carla-0.9.13-py3.7-linux-x86_64.egg ~/carla/PythonAPI/

6) Edit the .bashrc file to export the above .egg file to the PYTHONPATH variable:

.. code-block:: console

    echo "export PYTHONPATH=$PYTHONPATH:~/carla/PythonAPI/carla-0.9.13-py3.7-linux-x86_64.egg" >> ~/.bashrc

7) Compile the server:

The following command compiles and launches Unreal Engine. Run this command each time you want to launch the server or use the Unreal Engine editor:

.. code-block:: console

    make launch
    
The project may ask to build other instances such as UE4Editor-Carla.dll the first time. Agree in order to open the project. During the first launch, the editor may show warnings regarding shaders and mesh distance fields. These take some time to be loaded and the map will not show properly until then.
