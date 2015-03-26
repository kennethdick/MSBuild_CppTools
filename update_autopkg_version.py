import re
import os
import os.path
import sys

# parse arguments

if len( sys.argv ) != 3:
    print ("Usage:  update_version.py [file withoutextension] [version]")
    print ("e.g.    To increment the version of nuget package FileName.autopkg")
    print (" >>>    update_version.py FileName increment")
    sys.exit( "usage" )

argument_file    = sys.argv[1]
argument_version = sys.argv[2]

# process autopkg file
if argument_file.find(".autopkg") >0:
	extIndex=argument_file.find(".autopkg");
	print(".autopkg extension found in filename" );
	argument_file=argument_file[:-extIndex];

if os.path.exists( argument_file+'.autopkg' ):
	version_regex = re.compile('version\s:\s(\d).(\d).(\d).(\d);.*' )
	print("Regex ready" )
	versionfile_old = open( argument_file+'.autopkg',  'r' ).readlines()	
	versionfile_new = open( argument_file+'2.autopkg', 'w' )
	for line in versionfile_old:
		match = version_regex.search( line )
		if match:
			print("MatchLine"+line )
			if argument_version == 'increment':  
				version = int( match.group(4) ) + 1
			else:
				version = argument_version
			
			versionfile_new.write( line.replace( match.group(4)+';', str( version )+';' ) )
		else:
			versionfile_new.write( line )
	versionfile_new.close()
	os.remove( argument_file+'.autopkg' )
	os.rename( argument_file+'2.autopkg', argument_file+'.autopkg' )

