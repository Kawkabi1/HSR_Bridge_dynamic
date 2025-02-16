function RunAbaqus(UseWriteFile, Usersub, DIR)
ABAQUS_SUCCESS=dos(['abaqus job=' UseWriteFile '.inp user=' Usersub ' cpus=2  interactive scratch=' DIR])