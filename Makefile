# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: knaumov <knaumov@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/12/05 22:08:06 by knaumov           #+#    #+#              #
#    Updated: 2019/05/01 15:42:57 by knaumov          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

INCLUDES = -I includes -I libft

SRCS_COREWAR = 	srcs/corewar/main.c

SRCS_ASM = 	srcs/assembler/main.c

SRCS_UTILS = 

LIBFT = -L ./libft -lft

OBJ_COREWAR	=	$(SRCS_COREWAR:.c=.o)
OBJ_ASM	= 		$(SRCS_ASM:.c=.o)
OBJ_UTILS = 	$(SRCS_UTILS:.c=.o)

EXEC_COREWAR = corewar
EXEC_ASM = asm

RESET = \033[0m
RED = \033[0;31m
GREEN = \033[0;32m
BLUE = \033[0;36m
RED_EXTRA = \033[1;31m
GREEN_EXTRA = \033[1;32m
BLUE_EXTRA = \033[1;36m

%.o:%.c
			@echo "$(GREEN) - Creating $(GREEN_EXTRA)$<...$(RESET)"
			@gcc -Wall -Wextra -Werror -c $< -o $@ $(INCLUDES) -g 

all: $(EXEC_COREWAR) $(EXEC_ASM)

$(EXEC_COREWAR): $(OBJ_UTILS) $(OBJ_COREWAR)
	@make -C libft
	@echo "$(GREEN)Compiling executable $(GREEN_EXTRA)$(EXEC_COREWAR)$(RESET)"
	@gcc -Wall -Wextra -Werror -o $(EXEC_COREWAR) $(OBJ_COREWAR) $(OBJ_UTILS) $(INCLUDE) $(LIBFT) -g
	@echo "$(BLUE_EXTRA)$(EXEC_COREWAR)$(BLUE): Complete$(RESET)"

$(EXEC_ASM): $(OBJ_UTILS) $(OBJ_ASM)
	@make -C libft
	@echo "$(GREEN)Compiling executable $(GREEN_EXTRA)$(EXEC_ASM)$(RESET)"
	@gcc -Wall -Wextra -Werror -o $(EXEC_ASM) $(OBJ_ASM) $(OBJ_UTILS) $(INCLUDE) $(LIBFT) -g
	@echo "$(BLUE_EXTRA)$(EXEC_ASM)$(BLUE): Complete$(RESET)"

clean:
	@if [ -a "srcs/corewar/main.o" ]; then \
	echo "$(RED)Deleting objects for $(RED_EXTRA)$(EXEC_COREWAR)$(RESET)"; \
	/bin/rm -rf $(OBJ_COREWAR); \
	fi
	@if [ -a "srcs/assembler/main.o" ]; then \
	echo "$(RED)Deleting objects for $(RED_EXTRA)$(EXEC_ASM)$(RESET)"; \
	/bin/rm -rf $(OBJ_ASM); \
	fi
	@make -C libft clean
	@echo "$(BLUE_EXTRA)clean$(BLUE): Complete$(RESET)"

fclean: clean
	@if [ -a "$(EXEC_COREWAR)" ]; then \
	echo "$(RED)Deleting executable $(RED_EXTRA)$(EXEC_COREWAR)$(RESET)"; \
	/bin/rm -f $(EXEC_COREWAR); \
	fi
	@if [ -a "$(EXEC_ASM)" ]; then \
	echo "$(RED)Deleting executable $(RED_EXTRA)$(EXEC_ASM)$(RESET)"; \
	/bin/rm -f $(EXEC_ASM); \
	fi
	@make -C libft fclean
	@echo "$(BLUE_EXTRA)fclean$(BLUE): Complete$(RESET)"

re: fclean all

.PHONY: clean fclean re
