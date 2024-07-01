TIMEOUT_US 		= 400000 #if you timeout you can try to increase this value

.DEFAULT_GOAL	:= m
SHELL			= bash

UTILS_PATH		= utils/
UTILS			= $(addprefix $(UTILS_PATH), sigsegv.cpp color.cpp check.cpp leaks.cpp)
UTILS_O			= $(UTILS:.cpp=.o)

TESTS_PATH		= tests/
MANDATORY		= c s p d i u x upperx percent mix

BONUS			= minus 0 dot sharp space +

CC				= clang++ -std=c11 -Wno-everything
CFLAGS			= -g3 -ldl -std=c++11 -I utils/ -I.. $(addprefix -I, $(shell find .. -regex ".*/.*\.h" | grep -oh ".*\/"))

TEST_NUMBER := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
$(eval $(TEST_NUMBER):;@:)

UNAME = $(shell uname -s)
ifeq ($(UNAME), Linux)
    VALGRIND = valgrind -q --leak-check=full --track-origins=yes
endif

utils/%.o: utils/%.cpp
	@$(CC) $(CFLAGS) -c $< -o $@

$(MANDATORY): %: mandatory_start $(UTILS_O)
	@$(CC) $(CFLAGS) -D TIMEOUT_US=$(TIMEOUT_US) $(UTILS_O) $(TESTS_PATH)$*_test.cpp -L.. -lftprintf -o $*_test && $(VALGRIND) ./$*_test $(TEST_NUMBER) && rm -f $*_test

$(BONUS): %: bonus_start $(UTILS_O)
	@$(CC) $(CFLAGS) -D TIMEOUT_US=$(TIMEOUT_US) $(UTILS_O) $(TESTS_PATH)$*_test.cpp -L.. -lftprintf -o $*_test && $(VALGRIND) ./$*_test $(TEST_NUMBER) && rm -f $*_test

mandatory_start: checkmakefile
	@tput setaf 6
	@make -s -C ..
	@tput setaf 4 && echo [Mandatory]

bonus_start: checkmakefile
	@tput setaf 6
	@make bonus -s -C ..
	@tput setaf 5 && echo [Bonus]

checkmakefile:
	@ls .. | grep Makefile > /dev/null 2>&1 || (tput setaf 1 && echo Makefile not found. && exit 1)

$(addprefix docker, $(MANDATORY)) $(addprefix docker, $(BONUS)) dockerm dockerb dockera: docker%:
	@docker rm -f mc > /dev/null 2>&1
	docker build -t mi .
	docker run -dti --name mc -v $(shell dirname $(shell pwd)):/project/ mi
	docker exec -ti mc make $* $(TEST_NUMBER) -C printfTester
	@docker rm -f mc > /dev/null 2>&1

m: $(MANDATORY)
b: $(BONUS)
a: m b

clean:
	make clean -C .. && rm -rf *_test && rm -rf *_test.dSYM && rm -rf *.o && rm -rf utils/*.o

fclean:
	make fclean -C .. && rm -rf *_test && rm -rf *_test.dSYM && rm -rf *.o && rm -rf utils/*.o

.PHONY:	mandatory_start m bonus_start b a clean fclean