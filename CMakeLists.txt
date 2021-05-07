cmake_minimum_required(VERSION 3.19)
project(syntaxique C)

set(CMAKE_C_STANDARD 11)

include_directories(.)

add_executable(syntaxique
        lex.yy.c
        syntaxique.tab.c)
