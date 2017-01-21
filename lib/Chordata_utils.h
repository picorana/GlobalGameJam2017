#ifndef __CHORDATA_UTILS__
#define __CHORDATA_UTILS__

#include <string>
#include <math.h>
#include <chrono>
#include <iostream>
#include <vector>
#include <errno.h>
#include <stdio.h>
#include <cstdint>

/////////////////////////////////
///COMUNICATOR
/////////////////////////////////

namespace Chordata {
	class Comunicator {
	public:
		static void log(std::string);
		static void error(std::string);
		static void debug(std::string);

		// static void set_verbose_mode(bool verbose){
		// 	verbose_mode = verbose;
		// };

	private:
		// static bool verbose_mode;

	};

	
};

//////////////////////////////////
/// SPLIT A STRING on whitespaces, and discard the excess 
//////////////////////////////////

std::string* splitMax(const std::string& s, std::string* buf, std::size_t max);

bool we_dont_want_it(char c);
bool we_want_it(char c);

/////////////////////////////////
///TIME STUFF
/////////////////////////////////


//TODO: erase
// #define micros std::chrono::microseconds
#define thread_sleep std::this_thread::sleep_for

// inline unsigned long int ellapsedMicros(const time_point t){
// 	return std::chrono::duration_cast<std::chrono::microseconds>(
// 		std::chrono::high_resolution_clock::now() - t).count();
// }

namespace Chordata{
	typedef std::chrono::time_point<std::chrono::high_resolution_clock> time_point;
	typedef std::chrono::high_resolution_clock clock;
	typedef std::chrono::microseconds micros;
	typedef std::chrono::milliseconds millis;

	class Timekeeper{
	public:	
		Timekeeper(): start(clock::now() ) {};

		void reset(){ start = clock::now(); };

		inline uint64_t ellapsedMicros(){
			return std::chrono::duration_cast<micros>(clock::now() - start ).count();
		}

		inline uint64_t ellapsedMillis(){
			return std::chrono::duration_cast<millis>(clock::now() - start ).count();
		}

	private:
		time_point start;

	};
}

/////////////////////////////////
///HELPERS
/////////////////////////////////

// A helper function to output vectors.
template<class T>
std::ostream& operator<<(std::ostream&, const std::vector<T>&);

//Degrees to radians
inline float degToRads(float in){
	return in * M_PI / 180;
}

//Check if the string contains a valid IP address
bool verifyIP(const std::string& s);

#endif

