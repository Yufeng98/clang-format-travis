#! bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

content=$(pwd)
echo $content

cd ..
cp -r $content copy

cd copy
find . -name "*.hpp" -or -name "*.cpp" -or -name "*.h" -or -name "*.c" | xargs clang-format -i

cd ..
compare_result=$(diff -urNa $content copy)

if [ -z $compare_result ]; then
    echo -e "${GREEN}All source code in commit are properly formatted.${NC}"
    rm -rf copy
    exit 0
else
    echo -e "${RED}Found formatting errors!${NC}"
    echo $compare_result
    rm -rf copy
    exit 1
fi