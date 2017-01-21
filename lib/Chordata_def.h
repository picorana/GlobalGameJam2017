#ifndef __CHORDATA_DEF__
#define __CHORDATA_DEF__

/////////////////////////////////
///Naming Definition
/////////////////////////////////
// #define _CH_NMSPC Chordata
// The client name
#define _CHORDATA_CLIENT "Chordata Client"

/////////////////////////////////
///Globals
/////////////////////////////////
#define	_CHORDATA_VER_MA 1
#define	_CHORDATA_VER_MI 0

/////////////////////////////////
///CONFIGURATION
/////////////////////////////////
#define _CHORDATA_CONF "Chordata.xml"
#define _CHORDATA_XML_BASE "Chordata"

/////////////////////////////////
///OSC
/////////////////////////////////
#define DEF_OSC_ADDR "/Chordata"
#define DEF_ERROR_SADDR "/error"
#define DEF_COM_SADDR "/com"



/////////////////////////////////
///IMU SENSOR
/////////////////////////////////
// SDO_XM and SDO_G are both grounded, so our addresses are:
#define LSM9DS0_XM  0x1D // Would be 0x1E if SDO_XM is LOW
#define LSM9DS0_G   0x6B // Would be 0x6A if SDO_G is LOW

// The delay between IMU reads.
// #define WAIT_MILLIS 10 //not used anymore

//The default output data rate (for each sensor)
#define _CHORDATA_ODR 50


//////////////////////////////////
/// MULTIPLEXER 
//////////////////////////////////
///The maximun number of ports allowed by default on a Multiplexer
#define _CHORDATA_MUX_MAX 8


namespace Chordata {

	/////////////////////////////////
	///ERRORS DEF
	/////////////////////////////////

	enum Parsing_stage{
		ARMATURE_PARSING,
		CONFIG_PARSING
	};

	enum Parser_type{
		XML_PARSER,
		CMD_LINE_PARSER
	};

}



#endif
