for dirPath in ./*/; do

echo "[DIR]: ${dirPath}"


FOLDER="${dirPath}"
# rename files in folder
  for file in "$FOLDER"*; do
    echo "[FILE/Original] ${file}"
    base=${file##*/}  #=> "foo.cpp" (basepath)
    dir=${file%$base}  #=> "/path/to/" (dirpath)
    ext=${file##*.} #=> .cpp

        cleanFilename=${dir#*/}
        cleanFilename=${cleanFilename%*/}

        echo "----- [file]: b: ${base} d: ${dir} e: ${ext}"

        echo "----  [file] clean: ${cleanFilename}"
        newPath=${dirPath}${cleanFilename}.${ext}
        echo "----- [FILE/new]: ${newPath}"

        #mv "$file" "$newPath"

  done;

done;
