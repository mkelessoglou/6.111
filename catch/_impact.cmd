setMode -bs
setMode -bs
setCable -port auto
Identify 
identifyMPM 
ReadIdcode -p 2 
assignFile -p 2 -file "/afs/athena.mit.edu/user/m/k/mkel/Desktop/6.111/finalproject/6.111/catch/catch.bit"
Program -p 2 
saveProjectFile -file "/afs/athena.mit.edu/user/m/k/mkel/Desktop/6.111/finalproject/6.111/catch/catch.ipf"
setMode -bs
deleteDevice -position 1
deleteDevice -position 1
deleteDevice -position 1
setMode -ss
setMode -sm
setMode -hw140
setMode -spi
setMode -acecf
setMode -acempm
setMode -pff
setMode -bs
