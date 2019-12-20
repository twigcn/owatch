SRC=rtp.cpp collector.cpp connection.cpp
OBJS = $(SRC:%.cpp=%.o)
TEST_SRC=test/connection_test.cpp test/file_test.cpp test/un_server_test.cpp  test/un_client_test.cpp
TEST = $(TEST_SRC:%.cpp=%)

CC=/usr/bin/g++
CPPFLAGS=-g -O3 -Wall
INC=
LIB=-ljrtp -lpthread -lrt

.PHONY: owatch clean test

default: owatch

$(OBJS): %.o: %.cpp
	$(CC) $(CPPFLAGS) $(INC) -c -o $@ $<

owatch: owatch.cpp $(OBJS)
	$(CC) $(CPPFLAGS) $(INC) -o $@ $< $(OBJS) $(LIB)
	@echo "\nDone!"

$(TEST): %: %.cpp $(OBJS)
	$(CC) $(CPPFLAGS) $(INC) -o $@ $< $(OBJS) $(LIB)

test: $(TEST)
	@echo "\nDone! See source file to find how to test."

clean:
	@rm -f *.o owatch
	@rm -f $(TEST)