cmake_minimum_required(VERSION 2.8.12)

project(abstract)

find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})

add_executable(abstract abstract.cpp)
target_link_libraries(abstract ${OpenCV_LIBS})
