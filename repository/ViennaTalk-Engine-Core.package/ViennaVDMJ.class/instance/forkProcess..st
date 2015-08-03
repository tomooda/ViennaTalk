private
forkProcess: desc
	^ UnixProcess
		forkJob: self javaPath
		arguments:
			{'-Dfile.encoding=whatever'.
			'-jar'.
			(self vdmpadPath fullName)}
		environment: nil
		descriptors: desc