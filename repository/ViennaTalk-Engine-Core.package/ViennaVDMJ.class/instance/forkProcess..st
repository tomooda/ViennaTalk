private
forkProcess: desc
	^ UnixProcess
		forkJob: self javaPath
		arguments:
			{'-Dfile.encoding=whatever'.
			'-jar'.
			(self json4vdmjPath fullName)}
		environment: nil
		descriptors: desc