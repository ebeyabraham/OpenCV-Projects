cmake_minimum_required(VERSION 2.6)
cmake_policy(SET CMP0012 NEW)
PROJECT(project)

#Requires OpenCV
FIND_PACKAGE(OpenCV 3.0.0 REQUIRED)
MESSAGE("OpenCV version : ${OpenCV_VERSION}")

include_directories(${OpenCV_INCLUDE_DIRS})
link_directories(${OpenCV_LIB_DIR})
ADD_EXECUTABLE(stitch stitch.cpp)
TARGET_LINK_LIBRARIES(stitch ${OpenCV_LIBS})
