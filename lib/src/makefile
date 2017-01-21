CC=g++

CFLAGS= -std=c++11 -I $(LIB_PATH)

LIB_PATH=../lib
BIN_PATH=../bin


UTILS = $(LIB_PATH)/Chordata_utils
AHRS = $(LIB_PATH)/MadgwickAHRS/MadgwickAHRS
OSC_PATH= $(LIB_PATH)/oscpack_1_1_0
OSC_UDP = $(OSC_PATH)/ip/posix/UdpSocket.cpp 
OSC_PS = $(OSC_PATH)/osc/OscOutboundPacketStream.cpp
OSC_IPEN = $(OSC_PATH)/ip/IpEndpointName.cpp 
OSC_NET = $(OSC_PATH)/ip/posix/NetworkingUtils.cpp 
OSC_TYPES = $(OSC_PATH)/osc/OscTypes.cpp
OSC = $(OSC_UDP) $(OSC_PS) $(OSC_IPEN) $(OSC_NET) $(OSC_TYPES)
OSC_OBJ = $(patsubst %.cpp, %.o, $(OSC))

RECIBE = udp/udp-recv
FUSION = fusion
TRANSMIT = transmit

all: $(RECIBE) $(FUSION) $(TRANSMIT)
	@echo 'All the notochord stack has been compiled'

utils: $(UTILS).o

ahrs: $(AHRS).o

osc: $(OSC_OBJ)

##########################
##NotoChords

$(RECIBE): $(RECIBE).cpp  $(UTILS).o 
	$(CC) $(CFLAGS) $(RECIBE).cpp $(UTILS).o -o $(BIN_PATH)/udp-recv

$(FUSION): $(FUSION).cpp $(UTILS).o $(AHRS).o 
	$(CC) $(CFLAGS) $(FUSION).cpp $(UTILS).o \
 	$(AHRS).o -o $(BIN_PATH)/$(FUSION)

$(TRANSMIT): $(TRANSMIT).cpp $(UTILS).o $(OSC_OBJ)
	$(CC) $(CFLAGS) -I $(OSC_PATH) $(TRANSMIT).cpp $(UTILS).o $(OSC_OBJ) -o $(BIN_PATH)/$(TRANSMIT)	


##########################
##DEPENDENCIES

$(UTILS).o: $(UTILS).cpp 
	$(CC) $(CFLAGS)  -c $(UTILS).cpp -o $(UTILS).o 

$(AHRS).o: $(AHRS).cpp
	$(CC) $(CFLAGS)  -c $(AHRS).cpp -o $(AHRS).o 

$(OSC_OBJ): $(OSC)
	$(CC) $(CFLAGS) -I $(OSC_PATH) -c $(OSC_UDP) -o $(patsubst %.cpp, %.o, $(OSC_UDP))
	$(CC) $(CFLAGS) -I $(OSC_PATH) -c $(OSC_PS) -o $(patsubst %.cpp, %.o, $(OSC_PS))
	$(CC) $(CFLAGS) -I $(OSC_PATH) -c $(OSC_IPEN) -o $(patsubst %.cpp, %.o, $(OSC_IPEN))
	$(CC) $(CFLAGS) -I $(OSC_PATH) -c $(OSC_NET) -o $(patsubst %.cpp, %.o, $(OSC_NET))
	$(CC) $(CFLAGS) -I $(OSC_PATH) -c $(OSC_TYPES) -o $(patsubst %.cpp, %.o, $(OSC_TYPES))
	
$(XML).o: $(XML).cpp
	$(CC) $(CFLAGS) -c $(XML).cpp -o $(XML).o 



##########################
##CLEANING

clean:
	@echo "\n'make clean_all' to delete all objects and execs\n"
	
	@echo "	'make clean_exec' to delete the programs\n"

	@echo "	'make clean_lib' to delete the dependecies objects"
	@echo "		'make clean_utils' to delete Chordata_utils.o"
	@echo "		'make clean_imu' to delete SFE_LSM9DS0.o\n"
	@echo "		'make clean_osc' to delete all the osc.o files\n"



clean_all: clean_exec clean_lib

clean_exec:
	rm $(BIN_PATH)/* 2>/dev/null

clean_lib: clean_utils clean_ahrs clean_imu clean_osc

clean_utils:
	rm	$(UTILS).o 2>/dev/null

clean_ahrs:
	rm $(AHRS).o 2>/dev/null

clean_imu:
	rm  $(IMU).o 2>/dev/null

clean_osc:
	rm	$(OSC_OBJ) 2>/dev/null

