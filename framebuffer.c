#include <stdio.h>
//using extern keyword to get access to variabels defined in another file
extern char *buffer;
extern int buff_heigth;
extern int buff_length;

int FrameBufferGetWidth(){
    return buff_heigth;
}

int FrameBufferGetHeight(){
    return buff_length;
}


int FrameShow(){
    //printing * at top of framebuffer for better formatting
    for(int i=0; i<buff_length; i++){
        printf("*");
    } 
    printf("\n");

    int count=0;
    //outer loop for coloumns-wise printing
    for(int i=0;i<buff_heigth;i++){
        //inner loop for row-wise printing
        for(int j=0; j<buff_length; j++)
        {
            printf("%c", buffer[count]);
            count++;
         }
        
        printf("\n"); 
    }
    //printing * at top of framebuffer for better formatting
    for(int i=0; i<buff_length; i++){
        printf("*");
    }
    printf("\n");
    return 0;
}