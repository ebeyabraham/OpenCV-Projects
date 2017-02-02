import cv2
import numpy as np

cap=cv2.VideoCapture(0)

while(cap.isOpened()):
	_,feed=cap.read()
	cv2.rectangle(feed,(50,100),(300,400),(0,255,0),0)
	image=feed[100:400,50:300]
	#image=cv2.imread('C:\Users\Admin\Desktop\hand.jpg')
	img=cv2.cvtColor(image,cv2.COLOR_BGR2GRAY)
	blur=cv2.GaussianBlur(img,(35,35),0)
	ret,thresh = cv2.threshold(blur,0,255,1+cv2.THRESH_OTSU)
	_,contours, hierarchy = cv2.findContours(thresh,1,1)
	max_area=0
	pos=0
	for i in contours:
		area=cv2.contourArea(i)
		if area>max_area:
			max_area=area
			pos=i
	peri=cv2.arcLength(pos,True)
	approx=cv2.approxPolyDP(pos,0.02*peri,True)
	hull=cv2.convexHull(pos)
	#print len(hull)
	#cv2.polylines(image,[approx],True,(0,255,255))
	#cv2.drawContours(image,[approx],-1,(255,100,50),2)
	cv2.drawContours(image,[hull],-1,(0,0,255),2)
	hull = cv2.convexHull(pos,returnPoints = False)
	defects = cv2.convexityDefects(pos,hull)
	num=0
	l=defects.shape[0]
	for i in range(1,defects.shape[0]):
		s,e,f,d = defects[i,0]
		far = tuple(pos[f][0])
		if d>10000:
			num+=1
			cv2.circle(image,far,3,[0,0,255],-1)
	num+=1;
	if num==1:
		s='ONE'
	elif num==2:
		s='TWO'
	elif num==3:
		s='THREE'
	elif num==4:
		s='FOUR'
	elif num==5:
		s='FIVE'
	else:
		s='HELLO WOLRD'
	feed[100:400,50:300]=image
	font = cv2.FONT_HERSHEY_SIMPLEX
	cv2.putText(feed,s,(100,450), font, 2,(255,10,10),2,cv2.LINE_AA)
	cv2.imshow('Feed',feed)
	#cv2.imshow('image',thresh)
	k=cv2.waitKey(10)
	if k==27:
		break
cv2.destroyAllWindows()
