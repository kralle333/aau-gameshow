#pragma once
#include <jni.h>
#include "pFaceDetect_PFaceDetect.h"
#include "cv.h"
#include "highgui.h"
#include "cxcore.h"

class CFaceDetect
{

private:
	CvHaarClassifierCascade *pCascade;
	CvMemStorage *pStorage;
	int capW;
	int capH;

public:
	CvSeq *pFaces;
	double scale;

	CFaceDetect(void);
	~CFaceDetect(void);
	void init(const char* _p, int _w, int _h);
	void check(int* _p);
};
