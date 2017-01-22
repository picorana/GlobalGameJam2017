/**
 * notochord_fusion
 * -reads raw IMU data from stdin, converts it to a quaternion rotation and prints it on stdout
 */

#include <MadgwickAHRS/MadgwickAHRS.h>
#include <Chordata_utils.h>
#include <Eigen/Geometry>


#include <iostream>
#include <string>
#include <cstdlib>


#define MAX_BUF 12
#define	XML_FILE "../chord_callib.xml"

#define DOT_PROD_TRESHOLD 0.5f
#define MILLIS_TRESHOLD 300


using std::string; using std::cout;
using std::endl;

//from MadgwickAHRS.h
float sampleFreq;

int main(int argc, char const *argv[])
{	

	float bottathreshold = 1; 
	if (argc == 2){
		bottathreshold = atoi(argv[1]);
	}

	enum class DIRINDEX{
		DIR_UP=0,
		DIR_FRONT,
		DIR_BACK,
		DIR_LEFT,
		DIR_RIGHT
	};

	//////////////////////////////////
	/// Vel & Accell 
	//////////////////////////////////
	
	Eigen::Vector3f true_pos(0,0,0);
	Eigen::Vector3f true_vel(0,0,0);
	Eigen::Vector3f prev_vel(0,0,0);

	Eigen::Vector3f DIR_UP(0,0,1);
	Eigen::Vector3f DIR_FRONT(0,1,0);
	Eigen::Vector3f DIR_BACK(0,-1,0);
	Eigen::Vector3f DIR_LEFT(-1,0,0);
	Eigen::Vector3f DIR_RIGHT(1,0,0);

	Eigen::Vector3f* dirs[] = {&DIR_UP, &DIR_FRONT, &DIR_BACK, &DIR_LEFT, &DIR_RIGHT};

	Chordata::Timekeeper timer;
	///Begin the conversion
	string s;
	while (getline(std::cin, s)){

		long t = timer.ellapsedMillis();

		string buf[MAX_BUF];
		string *limit = splitMax(s, buf, MAX_BUF);

		string *oscAddr = buf;
		float delta_time = 20;


		delta_time = atof(buf[1].c_str())/1000;
	
		// cout << "DELTA T: " << delta_time << endl;
		//FLOAT ERROR	
		if (delta_time != 0){
			sampleFreq = 1/( delta_time/1000 );
			
		} else {
			sampleFreq = 100;
		}

		Eigen::Vector3f vecRot(atof(buf[2].c_str()), atof(buf[3].c_str()),atof(buf[4].c_str()));
		Eigen::Vector3f vecAccel((float)atof(buf[5].c_str()), (float)atof(buf[6].c_str()), (float)atof(buf[7].c_str()));
		Eigen::Vector3f vecMag(atof(buf[8].c_str()), atof(buf[9].c_str()), atof(buf[10].c_str()));
		vecAccel.normalize();
		vecMag.normalize();

		MadgwickAHRSupdate(	vecRot.x(), vecRot.y(), vecRot.z(), 
							vecAccel.x(), vecAccel.y(), vecAccel.z(), 
							vecMag.x(), vecMag.y(), vecMag.z());

		//////////////////////////////////
		/// EIGEN 
		//////////////////////////////////

		//Create an Eigen::Quaternionf from the Madgwick quaterion scalars 
		Eigen::Quaternionf ImuQuat((float)q0, (float)q1, (float)q2, (float)q3);
		ImuQuat.normalize();

		//Create an Eigen::Vector from the raw acelerometer reads.
		//Then rotate it by the Quaternion
		Eigen::Quaternionf p;
		p.w() = 0;
		p.vec() = vecAccel;
		Eigen::Quaternionf rotatedP = ImuQuat * p * ImuQuat.inverse(); 
		Eigen::Vector3f rotatedV = rotatedP.vec();

		cout << ImuQuat.w() << "\t" <<  ImuQuat.x() << "\t" <<  ImuQuat.y() << "\t" << ImuQuat.z() << "\t"; 

		for (int i = 0; i < 5; ++i) //Loop on each direction and rotate it to the IMU frame
		{	
			Eigen::Quaternionf torot;
			ImuQuat = ImuQuat.conjugate();
			torot.w() = 0;
			torot.vec() = *dirs[i];
			Eigen::Quaternionf rotatedDirQ = ImuQuat * torot * ImuQuat.inverse(); 
			*dirs[i] = rotatedDirQ.vec();
		}


		// Create the gravity vector
		Eigen::Vector3f g(0,0,-1);
		Eigen::Vector3f cleanAccel = rotatedV + g;	

		cout << cleanAccel.x() << "\t" << cleanAccel.y() << "\t" << cleanAccel.z() << endl;

		if (cleanAccel.norm() > bottathreshold && t > MILLIS_TRESHOLD)
		{
				// cout << (*dirs[ (int) DIRINDEX::DIR_UP]).x() << " | "
				// << (*dirs[ (int) DIRINDEX::DIR_UP]).y() << " | "
				// << (*dirs[ (int) DIRINDEX::DIR_UP]).z()<< endl;

			// cout << " *" << endl;

			if (cleanAccel.dot(*dirs[ (int) DIRINDEX::DIR_UP]) > DOT_PROD_TRESHOLD)
			{
				cout << "UP" << endl;
			} else {
				if (cleanAccel.dot(*dirs[ (int) DIRINDEX::DIR_LEFT]) > DOT_PROD_TRESHOLD){
					cout << "LEFT" << endl;
				} else if (cleanAccel.dot(*dirs[ (int) DIRINDEX::DIR_RIGHT]) > DOT_PROD_TRESHOLD){
					cout << "RIGHT" << endl;
				} else if (cleanAccel.dot(*dirs[ (int) DIRINDEX::DIR_FRONT]) > DOT_PROD_TRESHOLD){
					cout << "FRONT" << endl;
				} else if(cleanAccel.dot(*dirs[ (int) DIRINDEX::DIR_BACK]) > DOT_PROD_TRESHOLD){
					cout << "BACK" << endl;
				} 
			}
			timer.reset();
		}

	}
	
	return 0;
}