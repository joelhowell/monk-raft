############################################################

# Makefile for C projects

TARGET			:= myProg

# default flag(s)
FLAGS			?= -O2

# set src & bin directories, set gccopts
BIN_DIR			:= bin/
SRC_DIR			:= src/
INC_DIR			:= inc/

# set LDLIBS for OpenGL
LDLIBS			=  -ldl -lglfw -lGL -lGLU -lglut

############################################################

# Old usage -> SRCS = $(wildcard $(SRC_DIR)*.c)

SRCS			:= $(shell find $(SRC_DIR) -name '*.c')
HDRS			:= $(shell find $(INC_DIR) -name '*.h')

OBJ 			:= $(patsubst $(SRC_DIR)%.c,$(BIN_DIR)%.o,$(SRCS))

GCC 			:= gcc
GCCOPTS			:= -Wall -Wextra -ansi -std=c99 -I$(INC_DIR)
CCOPTS			:= $(GCCOPTS) $(CCFLAGS) $(FLAGS)

RM				:= rm -rf
MKDIR			:= mkdir -p

.PHONY: all clean vars

all:			$(TARGET)

# compile sources (.c) to objects (.o)
$(BIN_DIR)%.o:	$(SRC_DIR)%.c $(HDRS)
				@$(MKDIR) $(@D)
				@$(GCC) $(CCOPTS) -o $@ -c $<

# link executable
$(TARGET):		$(OBJ)
				@$(GCC) $(CCOPTS) -o $@ $^ $(LDLIBS)
				@echo "[INFO]: build successful: '$(TARGET)'"

# remove objects and executable
clean:			
				@$(RM) $(TARGET)
				@$(RM) $(BIN_DIR)
				@echo "[INFO]: clean successful"

# print variables
vars:
				@echo
				@echo "TARGET                 $(TARGET)"
				@echo "FLAGS                  $(FLAGS)"
				@echo
				@echo "GCC                    $(GCC)"
				@echo "GCCOPTS                $(GCCOPTS)"
				@echo "CCOPTS                 $(CCOPTS)"
				@echo "LDLIBS                 $(LDLIBS)"
				@echo
				@echo "BIN DIR                $(BIN_DIR)" 
				@echo "SOURCE DIR             $(SRC_DIR)"
				@echo "INCLUDE DIR            $(INC_DIR)" 
				@echo
				@echo "SOURCES                $(SRCS)"
				@echo "HEADERS                $(HDRS)"
				@echo
				@echo "TARGET                 $(TARGET)"
				@echo "OBJ                    $(OBJ)"
				@echo