/**
 * notochord_read
 * -reads the data from a LSM9DS0 IMU and prints it on stdout
 */

#include <SFE_LSM9DS0.h>
#include <Chordata_utils.h>

#include <iostream>
#include <chrono>
#include <thread>

using std::cout;		using std::endl;

// SDO_XM and SDO_G are both grounded, so our addresses are:
#define LSM9DS0_XM  0x1D // Would be 0x1E if SDO_XM is LOW
#define LSM9DS0_G   0x6B // Would be 0x6A if SDO_G is LOW
// The delay between IMU reads.
#define WAIT_MILLIS 10
#define DEF_OSC_ADDR "/Chordata"

// Create an instance of the LSM9DS0 library called `dof` the parameters are
// LSM9DS0(interface_mode interface, int adapter, uint8_t gAddr, uint8_t xmAddr);
LSM9DS0 dof(MODE_I2C, 1, LSM9DS0_G, LSM9DS0_XM);

inline void printSixFloats(	const float& rx, const float& ry, const float& rz,
							const float& ax, const float& ay ,const float& az,
							const float& mx, const float& my, const float& mz ) {
	cout 	<< rx << " " << ry << " " << rz << " "
			<< ax << " " << ay << " " << az << " "
			<< mx << " " << my << " " << mz << " " << endl;
}

int main(int argc, char const *argv[])
{
	const char *oscDir = (argc == 2)? argv[1] : DEF_OSC_ADDR;
	
	//Init i2c and check IMU
	uint16_t status = dof.begin();
	cout <<  status << endl;

	while (1){
		//Read the registers from the IMU
		dof.readGyro();
		dof.readAccel();
		dof.readMag();

	cout << oscDir << " ";

	printSixFloats	(degToRads(dof.calcGyro(dof.gx)), 	degToRads(dof.calcGyro(dof.gy)), 	degToRads(dof.calcGyro(dof.gz)), 
					dof.calcAccel(dof.ax), 				dof.calcAccel(dof.ay), 				dof.calcAccel(dof.az), 
					dof.calcMag(dof.mx), 				dof.calcMag(dof.my), 				-dof.calcMag(dof.mz));

	std::this_thread::sleep_for(std::chrono::milliseconds( WAIT_MILLIS ));
	}

	return 0;
}