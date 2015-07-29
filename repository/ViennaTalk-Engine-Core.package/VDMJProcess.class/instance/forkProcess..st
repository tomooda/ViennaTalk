private
forkProcess: desc 
	^ UnixProcess
		forkJob: self javaPath
		arguments: {'-Dfile.encoding=whatever'. '-jar'.
				(FileStream fullName: 'VDMPad.jar')}
		environment: nil
		descriptors: desc