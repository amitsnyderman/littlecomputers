#import "MyCustomView.h"

#define kAccelerometerFrequency 10 //Hz

@interface MyCustomView ()
- (void)configureAccelerometer;
- (void)moveWithTouch:(UITouch *)touch;
- (void)rotateAndScaleWithTouches:(NSSet *)touches;
CGFloat angleBetweenPoints(CGPoint point1, CGPoint point2);
CGFloat distanceBetweenPoints(CGPoint point1, CGPoint point2);
@end

@implementation MyCustomView

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {}
	return self;
}

- (void)awakeFromNib{
	squareSize = 100.0f;
	squareRotation = 0.0f;
	squareCenter = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
	//squareColor = CGColorCreateGenericRGB(1.0, 0.0, 0.0, 1.0);
	isRotating = NO;
	isMoving = NO;
	
	self.multipleTouchEnabled = YES;
	
	[self configureAccelerometer];
}

#pragma mark Accelerometer

- (void)configureAccelerometer {
	UIAccelerometer *a = [UIAccelerometer sharedAccelerometer];
	if (a) {
		a.updateInterval = 1 / kAccelerometerFrequency;
		a.delegate = self;
	} else {
		NSLog(@"No accelerometer. Not running on an iPhone.");
	}
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	//squareColor = CGColorCreateGenericRGB(abs(acceleration.x), abs(acceleration.y), abs(acceleration.z), 1.0);
	//[self setNeedsDisplay];
	xField.text = [NSString stringWithFormat:@"%.5f", acceleration.x];
	yField.text = [NSString stringWithFormat:@"%.5f", acceleration.y];
	zField.text = [NSString stringWithFormat:@"%.5f", acceleration.z];
}

#pragma mark Multitouch

// Make movement vs. rotation and scaling explicit actions.
// Only initiate a move when a single touch begins on the object.
// An offset is maintained between where the touch started and the center of the object,
// preventing the object from jumping to the touch.
// Switch to rotate/resize mode if a second touch is detected, canceling move action.

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	//NSLog(@"[touches] began [%d] %@", [touches count], touches);
	
	if ([touches count] == 1) {
		CGPoint start = [[[touches allObjects] objectAtIndex:0] locationInView:nil];
		CGRect square = CGRectMake(squareCenter.x - (squareSize / 2), squareCenter.y - (squareSize / 2), squareSize, squareSize);
		
		if (!CGRectContainsPoint(square, start)) return;
		
		isMoving = YES;
		moveOffset = CGPointMake(start.x - squareCenter.x, start.y - squareCenter.y);
	}
	
	if ([touches count] == 2) {
		isRotating = YES;
	}
	
	[self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	//NSLog(@"[touches] moved [%d] %@", [touches count], touches);
	
	if ([touches count] == 2) {
		isRotating = YES;
		isMoving = NO;
		[self rotateAndScaleWithTouches:touches];
	}
	
	if (isMoving && [touches count] == 1) {
		[self moveWithTouch:[[touches allObjects] objectAtIndex:0]];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	//NSLog(@"[touches] ended [%d] %@", [touches count], touches);
	
	isMoving = isRotating = NO;
	moveOffset = CGPointMake(0, 0);
	
	[self setNeedsDisplay];
}

- (void)moveWithTouch:(UITouch *)touch {
	//NSLog(@"moveWithTouch");
	
	CGPoint touchLocation = [touch locationInView:nil];
	
	squareCenter = CGPointMake(touchLocation.x - moveOffset.x, touchLocation.y - moveOffset.y);
	
	[self setNeedsDisplay];
}

- (void)rotateAndScaleWithTouches:(NSSet *)touches {
	//NSLog(@"rotateAndScaleWithTouch");
	
	UITouch *touch1 = [[touches allObjects] objectAtIndex:0];
	UITouch *touch2 = [[touches allObjects] objectAtIndex:1];
	
	CGPoint previousPoint1 = [touch1 previousLocationInView:nil];
	CGPoint previousPoint2 = [touch2 previousLocationInView:nil];
	CGFloat previousAngle = angleBetweenPoints(previousPoint1, previousPoint2);
	CGFloat previousDistance = distanceBetweenPoints(previousPoint1, previousPoint2);
	
	CGPoint currentPoint1 = [touch1 locationInView:nil];
	CGPoint currentPoint2 = [touch2 locationInView:nil];
	CGFloat currentAngle = angleBetweenPoints(currentPoint1, currentPoint2);
	CGFloat currentDistance = distanceBetweenPoints(currentPoint1, currentPoint2);
	
	squareRotation += currentAngle - previousAngle;
	
	if (squareSize + (currentDistance - previousDistance) > 0) {
		squareSize += (currentDistance - previousDistance);
	}
	
	[self setNeedsDisplay];
}

CGFloat angleBetweenPoints(CGPoint point1, CGPoint point2) {
	return atan2(point2.y - point1.y, point2.x - point1.x);
}

CGFloat distanceBetweenPoints(CGPoint point1, CGPoint point2) {
	return sqrt(pow(point2.x - point1.x, 2.0) + pow(point2.y - point1.y, 2.0));
}

#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
	CGFloat half = squareSize / 2;
	CGRect aRect = CGRectMake(-half, -half, squareSize, squareSize);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, squareCenter.x, squareCenter.y);
	CGContextRotateCTM(context, squareRotation);
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
	//CGContextSetFillColorWithColor(context, squareColor);
	//[squareColor setFill];
	CGContextFillRect(context, aRect);
	CGContextStrokeRect(context, aRect);
	CGContextRestoreGState(context);
}

- (void)dealloc {
	[xField release];
	[yField release];
	[zField release];
	[super dealloc];
}

@end