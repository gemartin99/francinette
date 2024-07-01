# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    compil_lib.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fsoares- <fsoares-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2017/01/23 18:26:36 by jtoty             #+#    #+#              #
#    Updated: 2022/01/31 16:28:26 by fsoares-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

func_compil_lib()
{
	text="COMPILING LIBFT"
	printf "${COLOR_TITLE}"
	printf "%.s${CHAR_LENGTH}" $(seq 1 ${TITLE_LENGTH})
	printf "\n${CHAR_WIDTH}\033[$(( (${TITLE_LENGTH} - ${#text}) / 2 ))G${text}\033[${TITLE_LENGTH}G${CHAR_WIDTH}\n"
	printf "%.s${CHAR_LENGTH}" $(seq 1 ${TITLE_LENGTH})
	printf "\n${DEFAULT}rules:\n"
	if [ -e "${PATH_LIBFT}"/libft.a ]
	then
		rm -f "${PATH_LIBFT}"/libft.a
	fi

	text="= Compiling libft "
	printf "\n${text}" >> "${PATH_DEEPTHOUGHT}"/deepthought
	printf "%.s=" $(seq 1 $(( 80 - ${#text} ))) >> "${PATH_DEEPTHOUGHT}"/deepthought

	if [ "${MAKEFILE_VAR}" == "missing_makefile" ]
	then
		text="Missing Makefile, can't compil library."
		printf "\033[$(( (${TITLE_LENGTH} - ${#text}) / 2 ))G${COLOR_FAIL}${text}${DEFAULT}\n\n"
		printf "\n${text}\n" >> "${PATH_DEEPTHOUGHT}"/deepthought
	else
		# if [ ${OPT_FULL_MAKEFILE} -eq 1 ]
		# then
		# 	printf "all"
		# 	printf "\033[11G\$(NAME)"
		# 	printf "\033[22Gfclean"
		# 	printf "\033[33Gre"
		# 	printf "\033[44Gbonus"
		# 	printf "\033[55Gclean"
		# 	printf "\033[66Glibft.a\n"
		# else
			printf "all"
			printf "\033[12G\$(NAME)"
			printf "\033[26Gfclean"
			printf "\033[39Gre"
			printf "\033[52Gclean"
			printf "\033[64Gbonus"
			printf "\033[74Glibft.a\n"
		# fi

			rm -f "${PATH_LIBFT}"/ft_*.o
			printf "\n$> make all\n" >> "${PATH_DEEPTHOUGHT}"/deepthought
			make --no-print-directory -C "${PATH_LIBFT}" all>>"${PATH_DEEPTHOUGHT}"/deepthought 2>&1
			if [ -z "$(grep -w all "${PATH_LIBFT}"/${MAKEFILE_VAR} | tr -d ' ' | tr -d '\t' | cut -d ':' -f 1 | grep -w all)" ]
			then
				printf "${COLOR_FAIL}missing rule${DEFAULT}"
			else
				if [ -e "${PATH_LIBFT}"/libft.a ]
				then
					printf "${COLOR_OK}ok${DEFAULT}"
					rm -f "${PATH_LIBFT}"/libft.a
				else
					printf "${COLOR_FAIL}fail${DEFAULT}"
				fi
			fi

			rm -f "${PATH_LIBFT}"/ft_*.o
			printf "\n$> make $(grep -w NAME "${PATH_LIBFT}"/Makefile | grep = | cut -d '=' -f 2 | tr -d ' ' | tr -d '\t')\n" >> "${PATH_DEEPTHOUGHT}"/deepthought
			make --no-print-directory -C "${PATH_LIBFT}" $(grep NAME "${PATH_LIBFT}"/${MAKEFILE_VAR} | grep = | cut -d '=' -f 2 | tr -d ' ' | tr -d '\t' | tr -d '\r') >>"${PATH_DEEPTHOUGHT}"/deepthought 2>&1
			if [[ -z "$(grep -w '$(NAME)' "${PATH_LIBFT}"/${MAKEFILE_VAR} | grep ':' | tr -d ' ' | tr -d '\t' | cut -d ':' -f 1 | grep -w '$(NAME)')" && -z "$(grep -w '${NAME}' "${PATH_LIBFT}"/${MAKEFILE_VAR} | grep ':' | tr -d ' ' | tr -d '\t' | cut -d ':' -f 1 | grep -w '${NAME}')" ]]
			then
				printf "\033[12G${COLOR_FAIL}missing${DEFAULT}"
			else
				if [ -e "${PATH_LIBFT}"/libft.a ]
				then
					printf "\033[12G${COLOR_OK}ok${DEFAULT}"
				else
					printf "\033[12G${COLOR_FAIL}fail${DEFAULT}"
					touch "${PATH_LIBFT}"/libft.a
				fi
			fi

			printf "\n$> make fclean\n" >> "${PATH_DEEPTHOUGHT}"/deepthought
			make --no-print-directory -C "${PATH_LIBFT}" fclean >> "${PATH_DEEPTHOUGHT}"/deepthought 2>&1
			if [ -z "$(grep -w fclean "${PATH_LIBFT}"/${MAKEFILE_VAR} | tr -d ' ' | tr -d '\t' | cut -d ':' -f 1 | grep -w fclean)" ]
			then
				printf "\033[26G${COLOR_FAIL}missing${DEFAULT}"
			else
				if [ ! -e "${PATH_LIBFT}"/libft.a ] && [ ! -e "${PATH_LIBFT}"/ft_*.o ]
				then
					printf "\033[26G${COLOR_OK}ok${DEFAULT}"
					touch "${PATH_LIBFT}"/libft.a
				else
					printf "\033[26G${COLOR_FAIL}fail${DEFAULT}"
					rm -f "${PATH_LIBFT}"/ft_*.o
					rm -f "${PATH_LIBFT}"/libft.a
				fi
			fi


		printf "\n$> make re\n" >> "${PATH_DEEPTHOUGHT}"/deepthought

			make --no-print-directory -C "${PATH_LIBFT}" re >> "${PATH_DEEPTHOUGHT}"/deepthought 2>&1
			if [ -z "$(grep -w re "${PATH_LIBFT}"/${MAKEFILE_VAR} | tr -d ' ' | tr -d '\t' | cut -d ':' -f 1 | grep -w re)" ]
			then
				printf "\033[39G${COLOR_FAIL}missing${DEFAULT}"
			else
				if [ -e "${PATH_LIBFT}"/libft.a ]
				then
					printf "\033[39G${COLOR_OK}ok${DEFAULT}"
				else
					printf "\033[39G${COLOR_FAIL}fail${DEFAULT}"
				fi
			fi

			printf "\n$> make clean\n" >> "${PATH_DEEPTHOUGHT}"/deepthought
			make --no-print-directory -C "${PATH_LIBFT}" clean >> "${PATH_DEEPTHOUGHT}"/deepthought 2>&1
			if [ -z "$(grep -w clean "${PATH_LIBFT}"/${MAKEFILE_VAR} | tr -d ' ' | tr -d '\t' | cut -d ':' -f 1 | grep -w clean)" ]
			then
				printf "\033[52G${COLOR_FAIL}missing${DEFAULT}"
			else
				if [ ! -e "${PATH_LIBFT}"/ft_*.o ]
				then
					printf "\033[52G${COLOR_OK}ok${DEFAULT}"
				else
					printf "\033[52G${COLOR_FAIL}fail${DEFAULT}"
				fi
			fi

		rm -f "${PATH_LIBFT}"/ft_*.o
		rm -f "${PATH_LIBFT}"/libft.a
		printf "\n$> make bonus\n" >> "${PATH_DEEPTHOUGHT}"/deepthought
		make --no-print-directory -C "${PATH_LIBFT}" bonus>>"${PATH_DEEPTHOUGHT}"/deepthought 2>&1
		result_bonus=1
		if [ -z "$(grep -w bonus "${PATH_LIBFT}"/${MAKEFILE_VAR} | tr -d ' ' | tr -d '\t' | cut -d ':' -f 1 | grep -w bonus)" ]
			then
				printf "\033[64G${COLOR_FAIL}missing${DEFAULT}"
				result_bonus=0
			else
				if [ -e "${PATH_LIBFT}"/libft.a ]
				then
					printf "\033[64G${COLOR_OK}ok${DEFAULT}"
				else
					printf "\033[64G${COLOR_FAIL}fail${DEFAULT}"
					result_bonus=0
				fi
			fi
		if [ $result_bonus -eq 0 ]; then
			make --no-print-directory -C "${PATH_LIBFT}" all>>"${PATH_DEEPTHOUGHT}"/deepthought 2>&1
		fi
		printf "\n$> ls -la libft.a\n" >> "${PATH_DEEPTHOUGHT}"/deepthought
		ls -la "${PATH_LIBFT}"/libft.a >> "${PATH_DEEPTHOUGHT}"/deepthought
		if [ -e "${PATH_LIBFT}"/libft.a ]
		then
			printf "\033[74G${COLOR_OK}found\n${DEFAULT}"
		else
			printf "\033[74G${COLOR_FAIL}not found\n${DEFAULT}"
		fi
	fi
}
