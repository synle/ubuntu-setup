@echo off
doskey ls=dir $*
doskey clear=cls
doskey npm=bash -c "npm $*"
doskey node=bash -c "node $*"
