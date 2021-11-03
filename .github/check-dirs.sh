#!/bin/bash
git diff --name-only HEAD^ HEAD |grep -v \.github > files.txt
tf_config=''

while IFS= read -r file
do
  echo "file = $file"
  parent_dir=$(dirname -- "$file")
  echo "parent_dir = $parent_dir"
  
  if [[ -z $tf_config ]]; then
    tf_config="{\"tf_config\":\"$parent_dir\"}"
  else
    tf_config="$tf_config, {\"tf_config\":\"$parent_dir\"}"
  fi
done < files.txt

echo "{\"include\":[$tf_config]}"

