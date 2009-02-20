#import "MyCustomView.h"

#define kAccelerometerFrequency 10 //Hz

@interface MyCustomView ()
- (void)configureAccelerometer;
@end

@implementation MyCustomView

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {}
	return self;
}

- (void)awakeFromNib{
	squareSize = 100.0f;
	rotation = 0.5f;
	twoFingers = NO;
	
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
	xField.text = [NSString stringWithFormat:@"%.5f", acceleration.x];
	yField.text = [NSString stringWithFormat:@"%.5f", acceleration.y];
	zField.text = [NSString stringWithFormat:@"%.5f", acceleration.z];
}

#pragma mark Multitouch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"[touches] began [%d] %@", [touches count], touches);
	
	if ([touches count] > 1) {
		twoFingers = YES;
	}
	
	[self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"[touches] moved [%d] %@", [touches count], touches);
	
	[self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"[touches] ended [%d] %@", [touches count], touches);
	
	twoFingers = NO;
	
	[self setNeedsDisplay];
}

#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
	NSLog(@"drawRect");
	
	CGFloat centerX = rect.size.width / 2;
	CGFloat centerY = rect.size.height / 2;
	CGFloat half = squareSize / 2;
	CGRect aRect = CGRectMake(-half, -half, squareSize, squareSize);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, centerX, centerY);
	//CGContextRotateCTM(context, rotation);
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	
	if (!twoFingers) {
		CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
	} else {
		CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1.0);
	}
	
	CGContextFillRect(context, aRect);
	CGContextStrokeRect(context, aRect);
	CGContextRestoreGState(context);
}

- (void)dealloc {
	[super dealloc];
}

@end