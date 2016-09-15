COMPILE.C = gcc

all: hello while

hello: hello.o
	${COMPILE.C} -o hello hello.o
hello.o: hello.s
	${COMPILE.C} -g -c -o hello.o hello.s

while: while.o
	${COMPILE.C} -o while while.o
while.o: while.s
	${COMPILE.C} -g -c -o while.o while.s

clean:
	rm *.o while hello loop
