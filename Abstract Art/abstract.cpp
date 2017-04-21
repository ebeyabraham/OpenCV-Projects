#include<bits/stdc++.h>
#include<opencv2/opencv.hpp>

#define num 50
#define x_1 0
#define x_2 1000
#define y_1 0
#define y_2 500

using namespace std;
using namespace cv;

Scalar randomColor( RNG& rng )
{
	int icolor = (unsigned) rng;
 	return Scalar( icolor&255, (icolor>>8)&255, (icolor>>16)&255 );
}

int drawRandomLines(Mat image, RNG rng)
{
	int type=8;
	Point p1,p2;
	for(int i=0;i<3*num;i++)
	{
		p1.x=rng.uniform(x_1,x_2);
		p1.y=rng.uniform(y_1,y_2);
		p2.x=rng.uniform(x_1,x_2);
		p2.y=rng.uniform(y_1,y_2);
		line(image,p1,p2,randomColor(rng),rng.uniform(1,10),type);
	}
}

int drawRandomRects(Mat image, RNG rng)
{
	int type=8;
	Point p1,p2;
	for(int i=0;i<2*num;i++)
	{
		p1.x=rng.uniform(x_1,x_2);
		p1.y=rng.uniform(y_1,y_2);
		p2.x=rng.uniform(x_1,x_2);
		p2.y=rng.uniform(y_1,y_2);
		rectangle(image,p1,p2,randomColor(rng),rng.uniform(-5,10),type);
	}
}

int drawRandomTriangles(Mat image, RNG rng)
{
	int type=8;
	Point vertices[1][3];
	int count[]={3};
	for(int i=0;i<2*num;i++)
	{
		for(int j=0;j<3;j++)
		{
			Point p;
			p.x=rng.uniform(x_1,x_2);
			p.y=rng.uniform(y_1,y_2);
			vertices[0][j]=p;
		}
		const Point* ppt[1]={vertices[0]};
		fillPoly(image,ppt,count,1,randomColor(rng),type);
	}
}

int drawRandomCircles(Mat image, RNG rng)
{
	int type=8;
	Point center;
	for(int i=0;i<num/2;i++)
	{
		center.x=rng.uniform(x_1,x_2);
		center.y=rng.uniform(y_1,y_2);
		circle(image,center,rng.uniform(30,150),randomColor(rng),rng.uniform(-5,10),type);
	}
}

int main()
{
	srand(unsigned(time(0)));
	RNG rng(rand());
	Mat image=Mat::zeros(500,1000,CV_8UC3);
	drawRandomLines(image,rng);
	drawRandomRects(image,rng);
	drawRandomTriangles(image,rng);
	drawRandomCircles(image,rng);
	namedWindow("IMAGE",CV_WINDOW_AUTOSIZE);
	imshow("IMAGE",image);
	waitKey(0);
	return 0;
}
