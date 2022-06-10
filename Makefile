CC=g++
CFLAGS=-g -Wall
OBJS=main.o foo.o bar.o
TARGET=main.out

SRC_DIR = ./src
OBJ_DIR = ./objs

#Make 할 소스 파일들
#wildcard 로 SRC_DIR 에서 *.cpp 로 된 파일들 목록을 뽑아낸 뒤에
#notdir 로 파일 이름만 뽑아낸다.
# SRC 는 foo.cpp bar.cpp main.cpp가 됨.
SRCS = $(notdir $(wildcard $(SRC_DIR)/*.cpp))
OBJS = $(SRCS:.cpp=.o)

#OBJS 안의 object 파일들 이름 앞에 $(OBJ_DIR)/ 을 붙인다.
OBJECTS = $(patsubst %.o, $(OBJ_DIR)/%.o, $(OBJS))

all: main.out

#main.o: include/foo.h include/bar.h src/main.cpp
#foo.o: include/foo.h src/foo.cpp
#bar.o: include/bar.h src/bar.cpp
$(OBJ_DIR)/%.o : $(SRC_DIR)/%.cpp
	$(CC) $(CXXFLAGS) -c $< -o $@ $(LDFLAGS)

$(TARGET) : $(OBJECTS)
	$(CC) $(CXXFLAGS) $(OBJECTS) -o $(TARGET) $(LDFLAGS)

.PHONY: clean all
clean:
	rm -f *.o
	rm -f $(TARGET)