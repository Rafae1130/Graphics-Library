#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "framebuffer.h"
#include <unistd.h>
#include "agra.h"

//creating global variables
char *buffer= NULL;
int buff_heigth=0;
int buff_length=0;


int main(int num, char **aargv){

//taking input from command line the lenght and height of buffer

    buff_length=atoi(aargv[1]);
    buff_heigth=atoi(aargv[2]);

    //creating a framebuffer of required memory according to input arguments
    buffer=(char*)malloc((buff_heigth*buff_length)*sizeof(char));
    memset(buffer, ' ', (buff_heigth*buff_length)*sizeof(char));

    // starting and ending points for the line
    int x0=0;
    int y0=0;
    int x1=39;
    int y1=19;
    //calling line drawing funciton in assembly
    draw_a_line(x0, y0, x1, y1);

    //circle center and radius
    int center_x=20;
    int center_y=10;
    int radius=7;
    
    //calling circle drawing funciton in assembly
    draw_a_circle(center_x, center_y, radius);
    
    //pixel position
    int pixel_x=25;
    int pixel_y=2;

    //calling pixel drawing function
    draw_a_pixel(pixel_x, pixel_y, buffer);
  
    //printing the framebuffer
    FrameShow();
    //freeing the memory
    free(buffer);
    return 0;
}
