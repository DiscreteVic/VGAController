import cv2
import matplotlib
import numpy as np

#read image 
img = cv2.imread('/mnt/d/Projects/VGAController/img2mem/img.jpg')

newimg = np.zeros((480,640,3), np.uint8)
 
blue_channel = img[:,:,0]
green_channel = img[:,:,1]
red_channel = img[:,:,2]

blue_channel = blue_channel >> 4
green_channel = green_channel >> 4
red_channel = red_channel >> 4

newimg[:,:,0] = blue_channel
newimg[:,:,1] = green_channel
newimg[:,:,2] = red_channel

#blue_channel = img >> 4

cv2.imwrite('testb.png', newimg)

f = open("../VHDL/memB.mif", "w")
f.write( "WIDTH=2560;\nDEPTH=480;\nADDRESS_RADIX=HEX;\nDATA_RADIX=HEX;\n\nCONTENT BEGIN\n\n")

for row in range(0,480):
    f.write( "{0:03X}".format(row) + "  :   ")
    for col in range(0, 640):
        f.write(hex(blue_channel[row,col])[2:])
    f.write(";-- "+str(row)+"\n")

f.write("END;")
f.close()

f = open("../VHDL/memR.mif", "w")
f.write( "WIDTH=2560;\nDEPTH=480;\nADDRESS_RADIX=HEX;\nDATA_RADIX=HEX;\n\nCONTENT BEGIN\n\n")

for row in range(0,480):
    f.write( "{0:03X}".format(row) + "  :   ")
    for col in range(0, 640):
        f.write(hex(red_channel[row,col])[2:])
    f.write(";-- "+str(row)+"\n")

f.write("END;")
f.close()

f = open("../VHDL/memG.mif", "w")
f.write( "WIDTH=2560;\nDEPTH=480;\nADDRESS_RADIX=HEX;\nDATA_RADIX=HEX;\n\nCONTENT BEGIN\n\n")

for row in range(0,480):
    f.write( "{0:03X}".format(row) + "  :   ")
    for col in range(0, 640):
        f.write(hex(green_channel[row,col])[2:])
    f.write(";-- "+str(row)+"\n")

f.write("END;")
f.close()



 
 