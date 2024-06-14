#! /bin/bash

# get current direction
curDir=`pwd`
# get shell direction
workDir=$(cd "$(dirname "$0")";pwd)

cd $workDir
bash ./_sync.sh
cd ..
python -m mkdocs gh-deploy

cd $curDir
