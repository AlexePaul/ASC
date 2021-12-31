from pwn import *
context.log_level = 'error'
context.timeout = 20
inputArray = [
    [
        "5 1 1 0 0 0 0 0 3 0 0 0 0 0 0 4 5",
        "5 2 1 0 0 0 0 0 3 0 0 0 0 0 0 4 5",
        "5 3 1 0 0 0 0 0 3 0 0 0 0 0 0 4 5",
        "5 4 1 0 0 0 0 0 3 0 0 0 0 0 0 4 5",
        "5 5 1 0 0 0 0 0 3 0 0 0 0 0 0 4 5",
    ],
]
outputArray = [
    [
        "1 2 1 2 1 2 3 4 3 4 5 3 5 4 5",
        "1 2 3 1 2 4 3 1 5 2 4 5 3 4 5",
        "1 2 3 4 1 5 3 2 1 4 5 2 3 4 5",
        "1 3 2 4 5 1 3 2 4 5 1 3 2 4 5",
        "-1",
    ],
]
points = [
	  [10, 10, 10, 10]
	, [5, 5, 5, 5]
	, [5, 5, 5]
	, [3, 3, 3, 3, 3, 3, 3, 3, 3, 3]
]

executables = ["./134_Alexe_VasilePaul"]

estimatedGrade = 0

for taskIndex in range(len(executables)):
	findProcess = process(["find", executables[taskIndex]])
	findResult = findProcess.recv()
	findProcess.kill()
	
	if findResult.replace("\n", "").strip() != executables[taskIndex]:
		print "Executable %s not found!" % executables[taskIndex]
		continue 
		
	print "Task: %s" % executables[taskIndex]
		
	taskInputArray = inputArray[taskIndex]
	taskOutputArray = outputArray[taskIndex]
	taskPoints = points[taskIndex]
	
	for i in range(0, len(taskInputArray)):
		try:
			sh = process(executables[taskIndex])
			sh.sendline(taskInputArray[i])
			line = sh.recvline().replace("\n", "").strip()
			sh.kill()
			
			if line == taskOutputArray[i]:
				estimatedGrade += taskPoints[i]
				
				if taskIndex < 3:
					print "\tTest %d: OK (%dp)" % (i, taskPoints[i]) 
				
				if taskIndex == 3 and i % 2 == 0:
					print "\tTest %d: OK (%dp)" % (i, taskPoints[i]) 
					taskPoints[i + 1] = 0 # already scored
					
				if taskIndex == 3 and i % 2 == 1:
					if taskPoints[i] == 0:
						print "\tTest %d: already scored" % i
					else:
						print "\tTest %d: OK (%dp)" % (i, taskPoints[i])
			else:
				print "\tTest %d failed (0p)" % i 
				print "\t   Input: %s" % taskInputArray[i]
				print "\t   Your output: %s" % line 
				print "\t   Expected output: %s" % taskOutputArray[i]
			
			if taskIndex == 3 and i % 2 == 1:
				print "\t------------------"
		except:
			print "\tTest %d: exception! (0p)" % i
	print "\n"

print "Estimated grade %dp / 100" % (estimatedGrade + 10)
