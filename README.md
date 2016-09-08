# DysonHackathonPoseidon


Team name: Poseidon

Tip: Don't hardcode IP

#General 

 - [x] Create Github project and invite others
 - [x] Create Xcode project


#Video feed over HTTP

 - [ ] Transform from 360
 - [x] Get bonus First tweet from camera feed
 - 
 
#Sensors

 - [ ] Read Sensors over MQTT

#Controls:

 - [ ] Send commands over MQTT (Left, Right: -4000 -> 4000)
 - [ ] Bonus for first to move robot
 - [ ] Create initial controller with 2 sliders
 - [ ] Create fancy joy stick controller



Notes:
	


Images:

![](images/IMG_1359.JPG?raw=true)
![](images/IMG_1361.JPG?raw=true)
![](images/IMG_1362.JPG?raw=true)

	
	

MQTT

subscribe to:

status/psd

eg {“FrontLeft":39,"FrontRight":214,"SideLeft":44,"SideRight":37}	

This sensor data.  the higher the value the closer the object to the respective sensor


status/odometry

e.g. {"Left":-3960,"Right":-10796}

 cumulative distance (since reboot?)  Maybe use to select “viewport” as right moves forward then viewport should move left along unpacked spherical image



