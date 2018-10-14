Real-time-Keyboard-Recognition-and-Augmented-Reality 
====   

###### Author: Haoxuan Yang and Ryan Thorpe  

***Augmented reality*** applications are on the rise and scientists and engineers are finding new applications. With the increase of processing power even mobile phones can perform computer computer vision operations to help the user learn new skills or analyze their surroundings. For this project we will focus on how augmented reality could help anyone learn to play the piano. It becomes more apparent every year that people wish to learn more skills in less time. Although, there are obvious downsides to such a hasty approach to learning, there is a substantial market for it. Applications like Photomath allow you to photograph a math problem and solve it in real time without knowing how to even add. Our piano playing program seeks to obviate the character building exercise of learning to read and understand musical structure. It will read music from an LCD screen and directly tell the user what key to play and when. These songs are pre-loaded onto a special piano with an LCD screen.   
## Assumptions  
### Song Selection  
The user cannot play just any song. Unfortunately, the user is limited to songs that are pre-programmed into the Casio SA76. The piano has around 20 songs pre-loaded song which allowed enough opportunities to test the image processing program. The piano does not have a standard number of keys and we will only use the first 26 white keys as shown in figure blow.   
<div align=center><img width="450" src="https://github.com/yhx89757/Real-time-Keyboard-Recognition-and-Augmented-Reality/blob/master/pics/figure1.JPG"/></div>  

### Camera Resolution  
The camera used was a Microsoft lifecam with 720p of resolution. We recommended cameras with with at least 720p of resolution. 
 
### Lighting  
However, the program is very susceptible to lighting and positional environmental factors. We tested this program in rooms with a somewhat diffuse and constant white light. When the piano is played directly under a light fixture, harsh glaring surfaces on the LCD screen, the white CCC window and on the white piano keys, themselves. We speculate that any point source light should be softened with a piece of white paper to diffuse the light evenly across the piano.  
<div align=center><img width="450" src="https://github.com/yhx89757/Real-time-Keyboard-Recognition-and-Augmented-Reality/blob/master/pics/figure5.JPG"/></div>  
 
### Piano Modification  
Although piano modification was kept to a minimum some changes were required. For the music reader to be able to localize the LCD screen a white CCC window will need to be added to the face of the piano. This window will be used to calculate the corner homography points needed to perform the orthophoto correction. The inner width and height must be precisely measured and used as constants for the ortho-correcting process. 
 
## Piano Position  
### Music Reader  
Position of the piano is also a key factor for the program to correctly recognize music notes and overlay the next note to be played.  Since the LCD screen is recessed into the keyboard creating an orthophoto can vary depending upon the camera’s angle of view. This view is similar to parallax and will be discussed later. Ideally, the camera will be positioned directly over the LCD screen. The program does allow for some degree of off angle camera positions. Please check out this [VIDEO FOR TIME NOTES](https://www.youtube.com/watch?v=IQND2-eX8X0 "It Is a Youtube Video") for more details.  
<img width="450" src="https://github.com/yhx89757/Real-time-Keyboard-Recognition-and-Augmented-Reality/blob/master/pics/figure2.JPG"/><img width="450" src="https://github.com/yhx89757/Real-time-Keyboard-Recognition-and-Augmented-Reality/blob/master/pics/figure6.JPG"/> 

### Key Highlighter
The keyboard needs to be level with the image borders. This means that the camera should view the piano to be centered within its field of view with little rotation or skew. 

### The Finger Detector  
The finger detector reads one of the user’s fingers at a time in the demo video, but it can be applied to multiple fingers ( we haven’t tried it ). The finger detector is also dependent on the position of the keyboard and cannot tolerate much image rotation. Please check out this [FINGER RECOGNITION IN BLACK AND WHITE VIDEO](https://www.youtube.com/watch?v=Ir6FcDrCeQo "It Is a Youtube Video") and this [BAD PLAYER VIDEO](https://www.youtube.com/watch?v=eVLJ0Zkax98 "It Is a Youtube Video") for more details.  
<div align=center><img width="450" src="https://github.com/yhx89757/Real-time-Keyboard-Recognition-and-Augmented-Reality/blob/master/pics/figure7.JPG"/></div>  
