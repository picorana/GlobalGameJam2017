/**
 * notochord_transmit
 * - get data values in CVS format from stdin and transmit it using OSC 
 */

#include <Chordata_utils.h>
#include "osc/OscOutboundPacketStream.h"
#include "ip/UdpSocket.h"
#include "osc/OscTypes.h"

#include <iostream>
#include <string>

#define MAX_BUF 8

//OSC defines
#define L_ADDRESS "127.0.0.1"
#define PORT (uint16_t) 7000
#define OUTPUT_BUFFER_SIZE 1024

using std::string; using std::cout;
using std::endl;

// inline int checkArgs();

int main(int argc, char const *argv[])
{
	string transmit_ip;
	uint16_t transmit_port;
	
	if( argc > 3) {
		cout << "usage: notochord_transmit [hostname [port]]"<< endl;
		return 1;
	}

	switch (argc){
		case 1:
			transmit_ip = L_ADDRESS;
			transmit_port = PORT;
		break;

		case 2:
			if ( !verifyIP(argv[1]) ) {
				cout << "Not a valid ip: " << argv[2] << endl;
				return 1;
			}
			transmit_ip = argv[1];
			transmit_port = PORT;
		break;

		case 3:
			string arg2 = (string) argv[2];
			int userPort = atoi(arg2.c_str());
			if ( !verifyIP(argv[1]) ) {
				cout << "Not a valid ip: " << argv[1] << endl;
				return 1;
			} else if ( userPort < 1024 || userPort > 49151) {
				cout << "Not a valid port number: " << argv[3] << endl;
				cout << "Please enter a number between 1024 and 49151" << endl;
				return 1;
			}
			transmit_ip = argv[1];
			transmit_port = userPort ;
		break;
	}
	
	//Init OSC comm
	UdpTransmitSocket transmitSocket( IpEndpointName( transmit_ip.c_str(), transmit_port ) );
	char buffer[OUTPUT_BUFFER_SIZE];
    osc::OutboundPacketStream p( buffer, OUTPUT_BUFFER_SIZE );

    //Print a message and wait for user to confirm
    cout << "\n************************************\n";
    cout << "transmiting to " << transmit_ip << ":" << (uint16_t) transmit_port  << '\n';
    cout << "press a key to start" << endl;
    std::cin.ignore();

	std::cout << "**********START OSC TRANSMISSION************" << std::endl;

	string s;
	while (getline(std::cin, s)){
		string buf[MAX_BUF];
		string *limit = splitMax(s, buf, MAX_BUF);

		string *oscAddr = buf;

		p.Clear();
		p << osc::BeginMessage( oscAddr->c_str() )
		        << (float)atof(buf[1].c_str()) << (float) atof(buf[2].c_str()) 
		        << (float)atof(buf[3].c_str()) << (float) atof(buf[4].c_str()) 
		        << (float)atof(buf[5].c_str()) << (float)atof(buf[6].c_str()) << (float)atof(buf[7].c_str())
		        << osc::EndMessage;
		transmitSocket.Send( p.Data(), p.Size() );
		
		cout << *oscAddr << '\t' << buf[1].c_str() 
						<< '\t' << buf[2].c_str() 
						<< '\t' << buf[3].c_str() 
						<< '\t' << buf[4].c_str() << endl;


	}
	
	return 0;
}

// inline int checkArgs(){
// 	if( argc > 3) {
// 		cout << "usage: notochord_transmit [hostname [port]]"<< endl;
// 		return 1;
// 	}

// 	switch (argc){
// 		case 1:
// 			transmit_ip = L_ADDRESS;
// 			transmit_port = PORT;
// 		break;

// 		case 2:
// 			if ( !verifyIP(argv[2]) ) {
// 				cout << "Not a valid ip: " << argv[2] << endl;
// 				return 1;
// 			}
// 			transmit_ip = argv[1];
// 			transmit_port = PORT;
// 		break;

// 		case 3:
// 			string arg2 = (string) argv[3];
// 			int userPort = atoi(arg2.c_str());
// 			if ( !verifyIP(argv[2]) ) {
// 				cout << "Not a valid ip: " << argv[1] << endl;
// 				return 1;
// 			} else if ( userPort < 1024 || userPort > 49151) {
// 				cout << "Not a valid port number: " << argv[3] << endl;
// 				cout << "Please enter a number between 1024 and 49151" << endl;
// 				return 1;
// 			}
// 			transmit_ip = argv[2];
// 			transmit_port = userPort ;
// 		break;
// 	}
// }