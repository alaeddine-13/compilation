# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.19

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/alaeddine/Software/CLion-2021.1.1/clion-2021.1.1/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /home/alaeddine/Software/CLion-2021.1.1/clion-2021.1.1/bin/cmake/linux/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/alaeddine/Desktop/Projects/GL4/semestre2/Compilation/syntaxique

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/alaeddine/Desktop/Projects/GL4/semestre2/Compilation/syntaxique/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/syntaxique.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/syntaxique.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/syntaxique.dir/flags.make

CMakeFiles/syntaxique.dir/lex.yy.c.o: CMakeFiles/syntaxique.dir/flags.make
CMakeFiles/syntaxique.dir/lex.yy.c.o: ../lex.yy.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/alaeddine/Desktop/Projects/GL4/semestre2/Compilation/syntaxique/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/syntaxique.dir/lex.yy.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/syntaxique.dir/lex.yy.c.o -c /home/alaeddine/Desktop/Projects/GL4/semestre2/Compilation/syntaxique/lex.yy.c

CMakeFiles/syntaxique.dir/lex.yy.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/syntaxique.dir/lex.yy.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/alaeddine/Desktop/Projects/GL4/semestre2/Compilation/syntaxique/lex.yy.c > CMakeFiles/syntaxique.dir/lex.yy.c.i

CMakeFiles/syntaxique.dir/lex.yy.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/syntaxique.dir/lex.yy.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/alaeddine/Desktop/Projects/GL4/semestre2/Compilation/syntaxique/lex.yy.c -o CMakeFiles/syntaxique.dir/lex.yy.c.s

CMakeFiles/syntaxique.dir/syntaxique.tab.c.o: CMakeFiles/syntaxique.dir/flags.make
CMakeFiles/syntaxique.dir/syntaxique.tab.c.o: ../syntaxique.tab.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/alaeddine/Desktop/Projects/GL4/semestre2/Compilation/syntaxique/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/syntaxique.dir/syntaxique.tab.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/syntaxique.dir/syntaxique.tab.c.o -c /home/alaeddine/Desktop/Projects/GL4/semestre2/Compilation/syntaxique/syntaxique.tab.c

CMakeFiles/syntaxique.dir/syntaxique.tab.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/syntaxique.dir/syntaxique.tab.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/alaeddine/Desktop/Projects/GL4/semestre2/Compilation/syntaxique/syntaxique.tab.c > CMakeFiles/syntaxique.dir/syntaxique.tab.c.i

CMakeFiles/syntaxique.dir/syntaxique.tab.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/syntaxique.dir/syntaxique.tab.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/alaeddine/Desktop/Projects/GL4/semestre2/Compilation/syntaxique/syntaxique.tab.c -o CMakeFiles/syntaxique.dir/syntaxique.tab.c.s

# Object files for target syntaxique
syntaxique_OBJECTS = \
"CMakeFiles/syntaxique.dir/lex.yy.c.o" \
"CMakeFiles/syntaxique.dir/syntaxique.tab.c.o"

# External object files for target syntaxique
syntaxique_EXTERNAL_OBJECTS =

syntaxique: CMakeFiles/syntaxique.dir/lex.yy.c.o
syntaxique: CMakeFiles/syntaxique.dir/syntaxique.tab.c.o
syntaxique: CMakeFiles/syntaxique.dir/build.make
syntaxique: CMakeFiles/syntaxique.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/alaeddine/Desktop/Projects/GL4/semestre2/Compilation/syntaxique/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable syntaxique"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/syntaxique.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/syntaxique.dir/build: syntaxique

.PHONY : CMakeFiles/syntaxique.dir/build

CMakeFiles/syntaxique.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/syntaxique.dir/cmake_clean.cmake
.PHONY : CMakeFiles/syntaxique.dir/clean

CMakeFiles/syntaxique.dir/depend:
	cd /home/alaeddine/Desktop/Projects/GL4/semestre2/Compilation/syntaxique/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/alaeddine/Desktop/Projects/GL4/semestre2/Compilation/syntaxique /home/alaeddine/Desktop/Projects/GL4/semestre2/Compilation/syntaxique /home/alaeddine/Desktop/Projects/GL4/semestre2/Compilation/syntaxique/cmake-build-debug /home/alaeddine/Desktop/Projects/GL4/semestre2/Compilation/syntaxique/cmake-build-debug /home/alaeddine/Desktop/Projects/GL4/semestre2/Compilation/syntaxique/cmake-build-debug/CMakeFiles/syntaxique.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/syntaxique.dir/depend
