#!/bin/bash
# Does not use gradle at the moment
# Made explicitely in bash and not in the playbook in order to be usable during>

echo "Checking java installation..."
# Check if Java is installed
if command -v java &>/dev/null; then # checks if java is in the PATH
    echo "Java is installed."
    java -version
else
    echo "Java is not installed."
fi
