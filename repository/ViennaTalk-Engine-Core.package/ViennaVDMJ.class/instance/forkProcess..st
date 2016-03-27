private
forkProcess: desc
	^ UnixProcess
		forkJob: self javaPath
		arguments:
			{'-Dfile.encoding=whatever'.
			'-Xss2m'.
			'-jar'.
			(self json4vdmjPath fullName convertToEncoding: 'utf-8')}
		environment: nil
		descriptors: desc