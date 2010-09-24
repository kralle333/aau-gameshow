#include "FaceDetect.h"
#include <iostream>

JNIEXPORT void JNICALL Java_pFaceDetect_PFaceDetect_init
(JNIEnv* env, jobject obj, jint w, jint h, jstring str) 
{
	CFaceDetect* face = new CFaceDetect();
	jclass cls;
	jfieldID fid;
	jboolean iscopy;

	cls = env->GetObjectClass(obj);
	fid = env->GetFieldID(cls, "ptr", "J");
	env->SetLongField(obj, fid, (jlong) face);
	const char* s = env->GetStringUTFChars(str, &iscopy);
	face->init(s, w, h);
	env->ReleaseStringUTFChars(str, s);
}
JNIEXPORT void JNICALL Java_pFaceDetect_PFaceDetect_check
(JNIEnv* env, jobject obj, jintArray arr)
{
	CFaceDetect* face;
	jclass cls;
	jfieldID fid;
	jboolean isCopy;

	cls = env->GetObjectClass(obj);
	fid = env->GetFieldID(cls, "ptr", "J");
	face = (CFaceDetect *) env->GetLongField(obj, fid);
	jint* myPtr;
	myPtr = env->GetIntArrayElements(arr, &isCopy);
	face->check((int*) myPtr);
	env->ReleaseIntArrayElements(arr, myPtr, 0);
}
JNIEXPORT jobjectArray JNICALL Java_pFaceDetect_PFaceDetect_getFaces
(JNIEnv* env, jobject obj)
{
	const int MAX = 4;
	CFaceDetect* face;
	jclass cls;
	jfieldID fid;
	double scl;

	cls = env->GetObjectClass(obj);
	fid = env->GetFieldID(cls, "ptr", "J");
	face = (CFaceDetect *) env->GetLongField(obj, fid);
	scl = face->scale;
	
	jobjectArray rects;
	int sz = face->pFaces ? (face->pFaces)->total : 0;
	jintArray tmp = (jintArray)env->NewIntArray(MAX);

	rects = (jobjectArray)env->NewObjectArray(sz, env->GetObjectClass(tmp), NULL);
	for (int i=0;i<sz;i++) {
		CvRect* r = (CvRect*)cvGetSeqElem(face->pFaces,i);

		jintArray rec = (jintArray)env->NewIntArray(MAX);
		jint* val = (jint *) malloc(MAX*sizeof(jint));
		val[0] = (jint) r->x*scl;
		val[1] = (jint) r->y*scl;
		val[2] = (jint) r->width*scl;
		val[3] = (jint) r->height*scl;
		env->SetIntArrayRegion(rec,0,MAX,val);
		env->SetObjectArrayElement(rects, i, rec);
		free(val);
	}
	return rects;
}