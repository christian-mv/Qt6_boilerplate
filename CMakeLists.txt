cmake_minimum_required(VERSION 3.16) # moved from 3.5 to 3.16

# Check if the VULKAN_SDK environment variable is not defined
if(NOT DEFINED ENV{VULKAN_SDK})
    # If not defined, then manually set the Vulkan SDK path for CMake
    set(ENV{VULKAN_SDK} "C:/VulkanSDK/1.3.268.0") # Manually specify Vulkan sdk.
endif()

project(MyApp VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
# set(CMAKE_CXX_EXTENSIONS OFF) # THIS NEEDS TO BE TESTED

find_package(Qt6 COMPONENTS Widgets Core Quick WebEngineWidgets Xml REQUIRED)

# Define the sources and resources
set(MY_SOURCES
    main.cpp
)

# Define the resource files
set(MY_RESOURCES
    resources.qrc
)

# Process resources with Qt6 function
qt6_add_resources(RESOURCE_ADDED_SRCS ${MY_RESOURCES}) # needed

## hide console in Windows build
if (WIN32)
    # needed to avoid having a console window in the background
    add_executable(MyApp WIN32 ${MY_SOURCES} ${RESOURCE_ADDED_SRCS})
else()
    # this 'else' is not tested in Linux and Mac yet:
    add_executable(MyApp ${MY_SOURCES} ${RESOURCE_ADDED_SRCS})
endif()

target_link_libraries(MyApp
    PRIVATE
    Qt::Core
    Qt::Quick
    Qt::Widgets
    Qt::Xml
    Qt::WebEngineWidgets
)

## QCreator boilerplate:
target_compile_definitions(MyApp PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
