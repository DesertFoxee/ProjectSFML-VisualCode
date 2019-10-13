#-----------setup 

FOLDRE_SRC 		:=src
FOLDRE_INC 		:=include
FOLDER_OBJECT	:=obj
FOLDER_DEBUG	:=debug


PATH_ROOT 		:= ${CURDIR}
FOLDER_NAME 	:= $(notdir ${PATH_ROOT})

SRC_FILE		:= $(wildcard $(FOLDRE_SRC)/*.cpp)\
					$(wildcard *.cpp)			
SRC_FILE_NOTDIR	:= $(notdir $(SRC_FILE))


INC_FILE		:= $(wildcard $(FOLDRE_INC)/*.h)
INC_FILE_ROOT	:= $(wildcard *.h)


OBJ_FILE		:= $(addprefix $(FOLDER_OBJECT)/, $(SRC_FILE_NOTDIR:.cpp=.o))

#-----------define

CC 			:= g++
TARGET 		:= $(FOLDER_NAME).exe
CFLAGS 		:= -Wall -g -std=c++11
LDLIBS 		:= -lsfml-graphics -lsfml-audio -lsfml-window -lsfml-system
INC_PATH 	:= -I./include -IE:/SUPPORT/SFML-2.5.1.32.gcc/include
LIB_PATH	:= -LE:/SUPPORT/SFML-2.5.1.32.gcc/lib


#-----------helper

print-%  : ; @echo $* = $($*)

#-----------execute

.PHONY: all clean

$(TARGET) : $(OBJ_FILE)
	$(CC) $(CFLAGS) -o $(FOLDER_DEBUG)/$@ $(LIB_PATH) $^ $(LDLIBS)

$(FOLDER_OBJECT)/%.o : $(FOLDRE_SRC)/%.cpp
	$(CC) $(CFLAGS) -o  $@ $(INC_PATH)  -c $<

$(FOLDER_OBJECT)/main.o : main.cpp
	$(CC) $(CFLAGS) -o  $@ $(INC_PATH)  -c $<

run :$(TARGET)
	debug/$(TARGET)

all: run


clean:
	rm -r debug/$(TARGET)

cleanall:
	rm -r debug/$(TARGET) obj/*


	
