import cv2
import numpy as np

cap=cv2.VideoCapture(0)

while(cap.isOpened()):
    ret,img=cap.read()
    #BGR Image
    cv2.imshow('Capturing...',img)
    hsv=cv2.cvtColor(img,cv2.COLOR_BGR2HSV)
    #Binary
    msk=cv2.inRange(hsv,np.array([170,170,153]),np.array([180,255,255]))
    res=cv2.bitwise_and(img,img,mask=msk)
    cv2.imshow('Result',res)
    k=cv2.waitKey(10)
    if k==27:
        break
cap.release()
cv2.destroyAllWindows()
