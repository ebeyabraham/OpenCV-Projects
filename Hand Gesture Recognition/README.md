#Simple Gesture Recognition Using OpenCV|Python
## Counts the number of fingers

###Algorithm Used
  1. Crop image of hand in ROI
  2. Isolate hand from noise in the image by finding largest area
  3. Find the convexivity defects
  4. Find the number of fingers by filtering the distance of defects by distance
  
### Issues
  1. Will not work if ROI has too many interfering obstacles
  2. Better algorithm required
  
  ![ice_screenshot_20170202-151145](https://cloud.githubusercontent.com/assets/15849927/22544366/731ab996-e95a-11e6-9b00-adbc250764e6.png)

