#!/bin/bash

# Script to insert tag files in the file heirarchy of your workspace
# *must called in the root of the workspace

find * -type d -exec ~/.ctags/dirtags.bash {} \;
ctags --file-scope=no -R --exclude=.git --exclude=build --exclude=devel --exclude=install --exclude=.tags -f .tags
