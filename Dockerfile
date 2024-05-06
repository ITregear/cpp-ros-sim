# Use the official ROS base image
FROM ros:noetic

# Update packages and install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    vim \
    nano

# Initialize rosdep to install any necessary dependencies
RUN rosdep update

# Set the working directory for the ROS workspace
WORKDIR /root/cpp-ros-sim

# Copy your ROS workspace src directory
COPY src /root/cpp-ros-sim/src

# Build the ROS workspace using catkin_make (for C++ projects)
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; cd /root/cpp-ros-sim; catkin_make'

# Set up environment variables to source ROS setup on container start
ENV ROS_WS /root/cpp-ros-sim
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc \
    && echo "source ${ROS_WS}/devel/setup.bash" >> ~/.bashrc

# Command to run when starting the container
CMD ["bash"]
