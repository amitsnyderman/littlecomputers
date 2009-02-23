#import <UIKit/UIKit.h>

@interface MyCustomView : UIView <UIAccelerometerDelegate> {
	CGFloat squareSize;
	CGFloat squareRotation;
	CGPoint squareCenter;
	CGPoint moveOffset;
	CGColorRef squareColor;
	
	BOOL isRotating;
	BOOL isMoving;
	
	IBOutlet UILabel *xField;
	IBOutlet UILabel *yField;
	IBOutlet UILabel *zField;
}
@end