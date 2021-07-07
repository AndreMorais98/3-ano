#ifdef __APPLE__
#define GL_SILENCE_DEPRECATION
#include <OpenGL/gl.h>
#include <GLUT/glut.h>
#else
#include <GL/gl.h>
#include <GL/glut.h>
#endif

#define _USE_MATH_DEFINES
#include <math.h>

// angle of rotation for the camera direction
float angle=M_PI/4;
// actual vector representing the camera's direction
float lx=0.0f,lz=-1.0f;
// XZ position of the camera
float x=0.0f,z=5.0f;


void changeSize(int w, int h) {

	// Prevent a divide by zero, when window is too short
	// (you cant make a window with zero width).
	if(h == 0)
		h = 1;

	// compute window's aspect ratio
	float ratio = w * 1.0 / h;

	// Set the projection matrix as current
	glMatrixMode(GL_PROJECTION);
	// Load Identity Matrix
	glLoadIdentity();

	// Set the viewport to be the entire window
  glViewport(0, 0, w, h);

	// Set perspective
	gluPerspective(45.0f ,ratio, 1.0f ,1000.0f);

	// return to the model view matrix mode
	glMatrixMode(GL_MODELVIEW);
}

void drawAxis(){

    glBegin(GL_LINES);
        // X axis in red
        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex3f(0.0f, 0.0f, 0.0f);
        glVertex3f(100.0f, 0.0f, 0.0f);
        // Y Axis in Green
        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex3f(0.0f, 0.0f, 0.0f);
        glVertex3f(0.0f, 100.0f, 0.0f);
        // Z Axis in Blue
        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex3f(0.0f, 0.0f, 0.0f);
        glVertex3f(0.0f, 0.0f, 100.0f);
    glEnd();
}

void drawCylinder(float radius, float height, int slices) {
  float angulo = (2*M_PI) /slices;
  glBegin(GL_TRIANGLES);
glVertex3f(1,0.5,0.5);
glVertex3f(0.333333,0.166667,0.5);
glVertex3f(1,0.166667,0.5);
glVertex3f(0.333333,0.5,0.5);
glVertex3f(-0.333333,0.166667,0.5);
glVertex3f(0.333333,0.166667,0.5);
glVertex3f(-0.333333,0.5,0.5);
glVertex3f(-1,0.166667,0.5);
glVertex3f(-0.333333,0.166667,0.5);
glVertex3f(1,0.166667,0.5);
glVertex3f(0.333333,-0.166667,0.5);
glVertex3f(1,-0.166667,0.5);
glVertex3f(0.333333,0.166667,0.5);
glVertex3f(-0.333333,-0.166667,0.5);
glVertex3f(0.333333,-0.166667,0.5);
glVertex3f(-0.333333,0.166667,0.5);
glVertex3f(-1,-0.166667,0.5);
glVertex3f(-0.333333,-0.166667,0.5);
glVertex3f(1,-0.166667,0.5);
glVertex3f(0.333333,-0.5,0.5);
glVertex3f(1,-0.5,0.5);
glVertex3f(0.333333,-0.166667,0.5);
glVertex3f(-0.333333,-0.5,0.5);
glVertex3f(0.333333,-0.5,0.5);
glVertex3f(-0.333333,-0.166667,0.5);
glVertex3f(-1,-0.5,0.5);
glVertex3f(-0.333333,-0.5,0.5);
//    for(int i = 0; i < slices; i++){
//      glColor3f(1,0,0);
//      glVertex3f(0,height,0);
//      glVertex3f(radius*sin(angulo*i),height,radius*cos(angulo*i));
//      glVertex3f(radius*sin(angulo*(i+1)),height,radius*cos(angulo*(i+1)));
//
//      glColor3f(0,1,0);
//      glVertex3f(radius*sin(angulo*i),height,radius*cos(angulo*i));
//      glVertex3f(radius*sin(angulo*i),0,radius*cos(angulo*i));
//      glVertex3f(radius*sin(angulo*(i+1)),height,radius*cos(angulo*(i+1)));
//
//
//      glColr3f(0,0,1);
//      glVertex3f(radius*sin(angulo*(i+1)),height,radius*cos(angulo*(i+1)));
//      glVertex3f(radius*sin(angulo*i),0,radius*cos(angulo*i));
//      glVertex3f(radius*sin(angulo*(i+1)),0,radius*cos(angulo*(i+1)));
//
//      glColor3f(1,0,1);
//      glVertex3f(radius*sin(angulo*i),0,radius*cos(angulo*i));
//      glVertex3f(0,0,0);
//      glVertex3f(radius*sin(angulo*(i+1)),0,radius*cos(angulo*(i+1)));
//    }
  glEnd();
}


void renderScene(void) {

	// clear buffers
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	// set the camera
	glLoadIdentity();
	//gluLookAt(5*cos(angle2)*sin(angle1),5*sin(angle2),5*cos(angle2)*cos(angle1),
	//	      0.0,0.0,0.0,
	//		  0.0f,1.0f,0.0f);

  gluLookAt(	x, 1.5f, z,   //camera position
			x+lx, 1.25f,  z+lz,    //points we're looking at -- Look At Point = Line of Sight + Camera Position
			0.0f, 1.0f,  0.0f),     //up vector


    //glRotatef(angle1,0,1,0);
    //glRotatef(angle2,0,0,1);
    drawAxis();
    drawCylinder(1,1,50);

	// End of frame
	glutSwapBuffers();
}


void processKeys(unsigned char c, int xx, int yy) {

// put code to process regular keys in here

}


void processSpecialKeys(int key, int xx, int yy) {
    float fraction = 0.1f;

    switch (key){
        case GLUT_KEY_LEFT:
            angle -= 0.02f;
            lx= sin(angle);
            lz= -cos(angle);
            break;
        case GLUT_KEY_RIGHT:
            angle += 0.02f;
            lx= sin(angle);
            lz= -cos(angle);
            break;
        case GLUT_KEY_UP:
            x +=lx * fraction;
            z +=lz * fraction;
            break;
        case GLUT_KEY_DOWN:
            x -=lx * fraction;
            z -=lz * fraction;
        break;
    }
    glutPostRedisplay();

}


int main(int argc, char **argv) {

// init GLUT and the window
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DEPTH|GLUT_DOUBLE|GLUT_RGBA);
	glutInitWindowPosition(100,100);
	glutInitWindowSize(1000,1000);
	glutCreateWindow("CG@DI-UM");

// Required callback registry
	glutDisplayFunc(renderScene);
	glutReshapeFunc(changeSize);

// Callback registration for keyboard processing
	glutKeyboardFunc(processKeys);
	glutSpecialFunc(processSpecialKeys);

//  OpenGL settings
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);

// enter GLUT's main cycle
	glutMainLoop();

	return 1;
}
