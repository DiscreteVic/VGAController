import cv2
import matplotlib
import numpy as np

#read image 
img = cv2.imread('/mnt/d/Projects/VGAController/img2mem/test.jpg')

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


f = open("../VHDL/mem.mif", "w")
f.write( "WIDTH=12;\nDEPTH=307200;\nADDRESS_RADIX=HEX;\nDATA_RADIX=HEX;\n\nCONTENT BEGIN\n\n")

for row in range(0,480):
    for col in range(0, 640):
        f.write( "{0:03X}".format((row*640)+col) + "  :   ")
        f.write(hex(red_channel[row,col])[2:]+hex(green_channel[row,col])[2:]+hex(blue_channel[row,col])[2:])
        f.write(";-- "+str(row)+"\n")

f.write("END;")
f.close()






 
 