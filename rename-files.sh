for file in *.avi; do
#  mv -- "$file" "${file%.avi}"
echo "${file%.avi}"

# Fist Letter UpperCase

# Move year to end

# remove garbage

# create directory
mkdir "${file%.avi}"
mv "$file" "./${file%.avi}"

done;

for file in *.mp4; do
#  mv -- "$file" "${file%.mp4}"
echo "${file%.mp4}"
# create directory
mkdir "${file%.mp4}"
mv "$file" "./${file%.mp4}"

done;

for file in *.mkv; do
#  mv -- "$file" "${file%.mkv}"
echo "${file%.mkv}"
# create directory
mkdir "${file%.mkv}"
mv "$file" "./${file%.mkv}"

done;


for file in *.flv; do
#  mv -- "$file" "${file%.mp4}"
echo "${file%.flv}"
# create directory
mkdir "${file%.flv}"
mv "$file" "./${file%.flv}"

done;
# (.*)([0-9]{4})(.*)(1080p)(.*\.)(...?.) -> matches some naming convention for movie name.
# sub: $1 $4 ($2).$6
for file in *.m4v; do
#  mv -- "$file" "${file%.mp4}"
echo "${file%.m4v}"
# create directory
mkdir "${file%.m4v}"
mv "$file" "./${file%.m4v}"

done;

for file in *.mpg; do
#  mv -- "$file" "${file%.mp4}"
echo "${file%.mpg}"
# create directory
mkdir "${file%.mpg}"
mv "$file" "./${file%.mpg}"

done;

for file in *.m4b; do
#  mv -- "$file" "${file%.mp4}"
echo "${file%.m4b}"
# create directory
mkdir "${file%.m4b}"
mv "$file" "./${file%.m4b}"

done;
