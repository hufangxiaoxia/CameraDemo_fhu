# CameraDemo_fhu
This is a simplified demo, include below features:
1. Use iPhone camera to take pictures;
2. Save each picture into database(support naming each picture, store the name, creation time); 
3. Retrieve all pictures from database and show them in a list;
4. When select a picture, show the picture in full screen.

Some basic steps and thoughts:
1. Break down the features, choose an architecture(MVC);
2. Find solutions for each feature:
2.1 Take a picture: use AVFoundation library;
2.2 Save a picture: use CoreData(save multiple information: piture name, shoot date, image, etc);
2.3 Retrieve pictures: use tableView;

Things left:
Error handling, multiple device adaption, unit test, etc.
Also lots of optimizations can be made, including: animation, gestures, localization, tableview performance, etc.

If you have any questions, please drop me an email to: hufangxiaoxia@163.com
