PATH_TEST="$(cd "$(dirname "$0")" && pwd -P)"

exec 2> errors.log

source "${PATH_TEST}"/srcs/variables.sh

OPT_FULL_MAKEFILE=1
TIMEOUT=$4

if [[ $4 == "-l" ]]
then
	OPT_NO_LIBRARY=1
	TIMEOUT=$5
fi

source "${PATH_TEST}"/srcs/colors.sh
source "${PATH_TEST}"/srcs/check_compilation.sh
source "${PATH_TEST}"/srcs/check_file.sh
source "${PATH_TEST}"/srcs/compil_lib.sh
source "${PATH_TEST}"/srcs/diff_test.sh

cd "${PATH_TEST}"
source "${PATH_TEST}"/my_config.sh

mkdir "${PATH_TEST}"/dirlibft
orig_path="$(python -c "import os,sys; print(os.path.abspath(sys.argv[1]))" "..")"
cp -r "${PATH_LIBFT}" "${PATH_TEST}"/dirlibft
PATH_LIBFT="${PATH_TEST}"/dirlibft

init_deepthought()
{
	if [ -e "${PATH_DEEPTHOUGHT}"/deepthought ]
	then
		rm -f "${PATH_DEEPTHOUGHT}"/deepthought
	fi
	text="= Host-specific information "
	printf "${text}" >> "${PATH_DEEPTHOUGHT}"/deepthought
	printf "%.s=" $(seq 1 $(( 80 - ${#text} ))) >> "${PATH_DEEPTHOUGHT}"/deepthought
	printf "\n$> hostname; uname -msr\n" >> "${PATH_DEEPTHOUGHT}"/deepthought
	hostname >> "${PATH_DEEPTHOUGHT}"/deepthought
	uname -msr >> "${PATH_DEEPTHOUGHT}"/deepthought
	printf "$> date\n" >> "${PATH_DEEPTHOUGHT}"/deepthought
	date >> "${PATH_DEEPTHOUGHT}"/deepthought
	printf "$> gcc --version\n" >> "${PATH_DEEPTHOUGHT}"/deepthought
	gcc --version >> "${PATH_DEEPTHOUGHT}"/deepthought
	printf "$> clang --version\n" >> "${PATH_DEEPTHOUGHT}"/deepthought
	clang --version >> "${PATH_DEEPTHOUGHT}"/deepthought
}

init_deepthought

if [ -e "${PATH_LIBFT}/Makefile" ]
then
	MAKEFILE_VAR="Makefile"
elif [ -e "${PATH_LIBFT}/makefile" ]
then
	MAKEFILE_VAR="makefile"
else
	MAKEFILE_VAR="missing_makefile"
fi

if [ ${OPT_NO_LIBRARY} -eq 0 ]
then
	func_compil_lib
fi

if [ -e "${PATH_LIBFT}/${HEADER_DIR}/libft.h" ]
then
	cp "${PATH_LIBFT}/${HEADER_DIR}/libft.h" "${PATH_TEST}"
fi

cp "$orig_path/libft.a" "${PATH_TEST}"/dirlibft

execute_test() {
	function=$1
	printf "${COLOR_FUNC}"
	func_name=$(echo "$function" | cut -d . -f 1 | sed 's/_bonus//g')
	printf "${func_name}"
	result=1
	compilation $function
	check_compilation
	check=$?
	if [ $check -eq 1 ]
	then
		diff_test $function
	else
		printf "\033[${TEST_COL}G"
		printf "${COLOR_FAIL}compil. failed${DEFAULT}"
		result=0
	fi
	check=$?
	if [ $check -eq 0 ]
	then
		result=0
	fi
	printf "\033[${RESULT_COL}G"
	if [ $result -eq 0 ]
	then
		printf "${COLOR_FAIL}KO\n${DEFAULT}"
	else
		printf "${COLOR_OK}OK\n${DEFAULT}"
		let "success += 1"
	fi
	if [ -e "${PATH_TEST}"/user_exe ]
	then
		rm -f "${PATH_TEST}"/user_exe
	fi
}

printf "\n${COLOR_TITLE}"
printf "FUNCTION"
printf "\033[${TEST_COL}GTESTS"
printf "\033[${RESULT_COL}GRESULT\n${DEFAULT}"

part=Part1_func
for value in $1
do
	execute_test "ft_$value.c"
done

part=Part2_func
for value in $2
do
	execute_test "ft_$value.c"
done

part=Bonus_func
for value in $3
do
	execute_test "ft_$value.c"
done
