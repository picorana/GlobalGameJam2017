/*
    Based on:  demo-udp-03: udp-recv: a simple udp server
	receive udp messages

        usage:  udp-recv

        Paul Krzyzanowski
*/

#include <Chordata_utils.h>
#include <iostream>
#include <chrono>
#include <thread>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <netdb.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include "port.h"

#define BUFSIZE 2048
#define MAX_SPLIT_PARTS 15

#define DEF_OSC_ADDR "/Player1"

using namespace std;

inline void printSixFloats(	const float& rx, const float& ry, const float& rz,
							const float& ax, const float& ay ,const float& az,
							const float& mx, const float& my, const float& mz ) {
	cout 	<< rx << " " << ry << " " << rz << " "
			<< ax << " " << ay << " " << az << " "
			<< mx << " " << my << " " << mz << " " << endl;
}


int
main(int argc, char **argv)
{
	const char *oscDir = (argc == 2)? argv[1] : DEF_OSC_ADDR;

	struct sockaddr_in myaddr;	/* our address */
	struct sockaddr_in remaddr;	/* remote address */
	socklen_t addrlen = sizeof(remaddr);		/* length of addresses */
	int recvlen;			/* # bytes received */
	int fd;				/* our socket */
	char input[BUFSIZE];	/* receive buffer */


	/* create a UDP socket */

	if ((fd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
		perror("cannot create socket\n");
		return 0;
	}

	/* bind the socket to any valid IP address and a specific port */

	memset((char *)&myaddr, 0, sizeof(myaddr));
	myaddr.sin_family = AF_INET;
	myaddr.sin_addr.s_addr = htonl(INADDR_ANY);
	myaddr.sin_port = htons(SERVICE_PORT);

	if (bind(fd, (struct sockaddr *)&myaddr, sizeof(myaddr)) < 0) {
		perror("bind failed");
		return 0;
	}

	Chordata::Timekeeper timer;
	/* now loop, receiving data and printing what we received */
	for (;;) {
		double delta_time =( (double) timer.ellapsedMillis());
		timer.reset();
		// printf("waiting on port %d\n", SERVICE_PORT);
		recvlen = recvfrom(fd, input, BUFSIZE, 0, (struct sockaddr *)&remaddr, &addrlen);
		// printf("received %d bytes\n", recvlen);
		if (recvlen > 0) {
			input[recvlen] = 0;
			// printf("received message: \"%s\"\n", buf);
			
			string buf[MAX_SPLIT_PARTS];
			try{
				string *limit = splitMax(string(input), buf, MAX_SPLIT_PARTS);

				// 2,3,4  ACCEL
				// 6,7,8  GYRO
				// 10,11,12  MAG

			} catch (std::exception &e){
				cout << "TO FEW ARGUMENTS IN UDP MESSAGE" << endl;
				exit(1);

			}

			cout << oscDir << " " << delta_time << " ";
			printSixFloats	(atof(buf[6].c_str()), 		atof(buf[7].c_str()), 		atof(buf[8].c_str()), 
							atof(buf[2].c_str()), 		atof(buf[3].c_str()), 		atof(buf[4].c_str()), 
							atof(buf[10].c_str()), 		atof(buf[11].c_str()), 		-atof(buf[12].c_str()));
		}

		
	}
	/* never exits */
}
