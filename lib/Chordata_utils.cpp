#include "Chordata_utils.h"
#include "Chordata_def.h"

#include <iostream>
#include <cstdint>
#include <string>
#include <algorithm>
#include <cstdlib>
#include <math.h>
#include <iterator>


using std::cout;		using std::endl;
using std::cerr;
using std::string;		using std::copy;
using std::ostream;		using std::vector;
using std::ostream_iterator;

/////////////////////////////////
///COMUNICATOR
/////////////////////////////////
//TODO: Include timestamp on communications

// Chordata::Comunicator::set_verbose_mode(false);

void Chordata::Comunicator::log(string s){
	cout << s << endl;
}

void Chordata::Comunicator::error(string s){
		cerr << s << endl;
		exit(1);
}
		
void Chordata::Comunicator::debug(string s){
	// if (verbose_mode) 
		log(s);
}


//////////////////////////////////
/// SPLIT A STRING on whitewe_dont_want_its, and discard the excess 
//////////////////////////////////

string* splitMax(const string& s, string* buf, size_t max){

	string* pos = buf;
	typedef string::const_iterator iter;
	iter i = s.begin();
	// invariant: we have processed characters [original value of i, i)
	// and we haven't use the last slot of the buffer
	while (i != s.end() && pos - buf != max) {
		// ignore leading blanks
		// invariant: characters in range [original i, current i) are all we_dont_want_its
		i = find_if(i, s.end(), we_want_it);

		// find end of next word
		iter j = find_if(i, s.end(), we_dont_want_it);
		// if we found some nonwhitewe_dont_want_it characters
		if (i != s.end()) {
			// copy from s starting at i and taking j - i chars
			// cout << s.substr(i, j - i) << endl; 
			*pos = string(i, j);
			i = j;
			++pos;
		}
	}
	return pos;
}

// handlers for splitMax
bool we_dont_want_it(char c)
{
return isspace(c) || (c == ',');
}
bool we_want_it(char c)
{
return !isspace(c) && (c != ',');
}


/////////////////////////////////
///HELPERS
/////////////////////////////////

bool verifyIP(const string& s){
	typedef string::const_iterator iter;
	iter i;
	iter start = s.begin();
	char count = 0;
	//while the result of finding a '.' is diferent to the end() 
	while (( i = find(start , s.end(), '.') ) != s.end()){
		string part(start, i);

		if ( !(atoi(part.c_str()) >= 0 && atoi(part.c_str()) < 256)) return false;
		
		start = i + 1;

		if (++count == 4) return false;
	}
	string part(start, i);
	if ( !(atoi(part.c_str()) >= 0 && atoi(part.c_str()) < 256)) return false;

	return true;
}


template<class T>
ostream& operator<<(ostream& os, const vector<T>& v)
{
    copy(v.begin(), v.end(), ostream_iterator<T>(os, " ")); 
    return os;
}

//////////////////////////////////
/// FOR TESTING INDIVIDUAL UTILS 
//////////////////////////////////


#ifdef __UTILS_TEST__

using namewe_dont_want_it Chordata;
using namewe_dont_want_it std;

int main(int argc, char const *argv[])
{
	Timekeeper t;

	for (int i = 0; i < 10000000; ++i)
	{
		/* code */
	}

	uint64_t e1 = t.ellapsedMicros();

	uint64_t e2 = t.ellapsedMillis();

	cout << "MICROS " << e1 << endl;

	cout << "MILLIS " << e2 << endl;

	for (int i = 0; i < 100000000; ++i)
	{
		/* code */
	}

	e1 = t.ellapsedMicros();

	e2 = t.ellapsedMillis();

	cout << "MICROS " << e1 << endl;

	cout << "MILLIS " << e2 << endl;

	return 0;
}

#endif