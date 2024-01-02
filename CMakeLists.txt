cmake_minimum_required(VERSION 3.16) # Feel free to change the minimum required cmake version.

# Check if the VULKAN_SDK environment variable is not defined
if(NOT DEFINED ENV{VULKAN_SDK})
    # If not defined, then manually set the Vulkan SDK path for CMake
    set(ENV{VULKAN_SDK} "YOUR_SDK_VULKAN_FOLDER") # Manually specify Vulkan sdk path.
endif()

project(MyApp VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20) # This assumes your compiler is C++20 otherwise change the version here
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
# set(CMAKE_CXX_EXTENSIONS OFF) # enable this if needed.

find_package(Qt6 COMPONENTS Widgets Core Quick REQUIRED) # add/remove your modules here

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

# link libraries (modules). Make sure the same modules are listed within find_package() above.
target_link_libraries(MyApp
    PRIVATE
    Qt::Core
    Qt::Quick
    Qt::Widgets
)

## QCreator boilerplate:
target_compile_definitions(MyApp PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
