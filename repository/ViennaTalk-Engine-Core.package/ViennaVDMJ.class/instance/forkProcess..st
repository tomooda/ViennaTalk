private
forkProcess: desc
	^ UnixProcess
		forkJob: self javaPath
		arguments:
			{'-Dfile.encoding=whatever'.
			'-jar'.
			(self json4vdmjPath fullName convertToEncoding: 'utf-8')}
		environment: nil
		descriptors: desc