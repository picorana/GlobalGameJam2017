""" 
Transform incoming osc messages to an object rotation

To be run from the spacebar menu, with the name of "Recive OSC"
To stop the reception and go back to normal blender use, press ESC or RMB
It expect to be an scene called 'Scene' with an object called 'Cube' (the default scene works fine)

Creates an UDP server at 127.0.0.1:7000 and attach a handler to the OSC address /quats

"""

import math
import time, threading

from pythonosc import dispatcher
from pythonosc import osc_server

import bpy
D = bpy.data



class OscOperator(bpy.types.Operator):
	"""Recibe Osc messages and rotate an object"""
	#Required properties of a Blender operator
	bl_idname = "wm.receive_osc"
	bl_label = "Receive OSC"

	#Some vars to store stuff
	_timer = None
	rotatingCube = 'Cube'
	positionElem = 'Icosphere'
	lastQuad = None 
	lastPos = None

	gravity = bpy.props.FloatVectorProperty(subtype='XYZ', name="lapos")

	#Add a blender prop to the Scene class
	bpy.types.Scene.customQuat = bpy.props.FloatVectorProperty(subtype='QUATERNION', name="elquat", size=4)
	bpy.types.Scene.customPos = bpy.props.FloatVectorProperty(subtype='XYZ', name="lapos")
	#Store the default scene's custom property inside a class member
	quat = D.scenes['Scene'].customQuat
	pos = D.scenes['Scene'].customPos

	###########################################
	### DEFINING bpy,types.Operator METHODS ###
	###########################################
	def invoke(self, context, event):
		"""
		The invoke() function is called when the operator is invoked by the user, for example from the spacebar menu
		Right now we use it just to call execute()
		"""
		self.execute(context)
		return {'RUNNING_MODAL'}
	
	def execute(self, context):
		"""
		Execute() is called when the operator is executed from python
		Here we create the timer, and append the modal handler
		Then setup the object, and start the OSC server
		"""
		#Add the timer and modal handler to the window manager
		wm = context.window_manager
		self._timer = wm.event_timer_add(0.05, context.window)
		wm.modal_handler_add(self)

		#Set the object to quaternion rotate mode, and the initial rotation to the default
		D.objects[self.rotatingCube].rotation_mode = 'QUATERNION'
		D.objects['Cube'].rotation_quaternion = (1,0,0,0)

		#Start the server
		print("************INIT SERVER***************")
		self.startServer()
		return {'RUNNING_MODAL'}

	def modal(self, context, event):
		"""
		The modal function will be runned on every blender event (like a keyboard press, mousemove, click, etc).
		In order to make it run at regular intervarls a timer is created inside invoke() which triggers a "TIMER" with a user defined delay.
		To keep the modal running it should return {'RUNNING_MODAL'}, otherwise {'FINISHED'} or {'CANCELLED'}.

		"""
		# print("Event-type: ", event.type)
		if event.type in {'RIGHTMOUSE', 'ESC'}:
			self.cancel(context)
			return {'CANCELLED'}

		if event.type == 'TIMER':
			# print(self.quat)
			if self.lastQuad != self.quat:
				self.lastQuad = self.quat.copy()
				# D.objects[self.rotatingCube].rotation_quaternion.rotate( self.quat )
				D.objects[self.rotatingCube].rotation_quaternion = self.quat

			if self.lastPos != self.pos:
				print(self.pos )
				self.lastPos = self.pos.copy()
				D.objects[self.positionElem].location = self.pos
				
				# acelVector =( 0,0, self.pos[2]-1)

		return {'RUNNING_MODAL'}

	def cancel(self, context):
		"""
		cancel() get's called when the operator is about to exit
		Here we remove the timer and stop the server
		"""
		wm = context.window_manager
		wm.event_timer_remove(self._timer)
		
		print ("\nClosing OSCServer.")
		self.server.shutdown()
		print ("Waiting for Server-thread to finish")
		self.st.join() ##!!!
		print ("Done")


	###########################################
	###     DEFINING CUSTOM METHODS         ###
	###########################################

	def startServer(self):
		"""
		Start the OSC server on different thread and attach a handler to the OSC address "/quats"
		"""

		#create the dispatcher
		self.dispatcher = dispatcher.Dispatcher()
		#register a handler to set the recived values on the address /quats
		#to a blender property somewhere
		self.dispatcher.map("/Chordata", osc_to_prop_quat, self.quat, self.pos)

		#Start evetything
		self.server = osc_server.OSCUDPServer(("192.168.142.126", 5555), self.dispatcher)
		self.st = threading.Thread( target = self.server.serve_forever)
		print("Serving on {}".format(self.server.server_address))
		self.st.start()

###########################################
###             OSC HANDLERS            ###
###########################################

def osc_to_prop_quat(addr, obj, *val):
	"""
	OSC HANDLER get a tuple of 4 OSC values and set them the passed obj
	"""
	# print("RECEIVED ", val)
	if 7 == len(val):
		for i in range(4):
			obj[0][i] = float(val[i])
		
		obj[1][0] = -val[4]
		obj[1][1] = -val[1+4]
		obj[1][2] = -val[2+4]

		# obj[1][2] = -obj[1][2]



bpy.utils.register_class(OscOperator)
