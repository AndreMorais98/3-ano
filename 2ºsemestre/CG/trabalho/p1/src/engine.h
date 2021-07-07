#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif
#include "rapidxml/rapidxml.hpp"
#include <iostream>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <fstream>
#include <string>
#include <vector>
#include <dirent.h>
#include <sys/types.h>
#include <string.h>

using namespace std;
using namespace rapidxml;

struct Ponto{
    float x;
    float y;
    float z;
};

vector<Ponto> pontos;

int type = GL_LINE;
float alfa = M_PI/4, bet = M_PI/4, radius = 10.0f;
float camX, camY, camZ;
