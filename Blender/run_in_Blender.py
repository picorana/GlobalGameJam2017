"""Just for running another script inside the Blender GUI.
	(it allows you to use a en external editor, and avoid reloading the script every time) 
"""
import bpy
import os

theScript = 'OscToRot_modal.py'

filename = os.path.join(os.path.dirname(bpy.data.filepath), theScript)
exec(compile(open(filename).read(), filename, 'exec'))