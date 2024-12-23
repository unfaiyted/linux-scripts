for dirPath in ./*/; do
#  mv -- "$file" "${file%.mkv}"
#echo "${file%.mkv}"
# create directory
# mkdir "${file%.mkv}"
#mv "$file" "./${file%.mkv}"
echo "[DIR]: ${dirPath}"

#src="/path/to/foo.cpp"


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
        #echo "----- [file] test: ${file/*./$cleanFilename.}"
        # newfile=${file/*.$cleanFilename.}
        #  echo "----- [file]: ${file
        #  %.mkv}
        # echo "----- [file-new] ${dir}${cleanFilename}.${ext}"
        # Delete sample files.
        newPath=./${cleanFilename}.${ext}
        echo "----- [FILE/new]: ${newPath}"

        mv "$file" "$newPath"

  done;

done;
