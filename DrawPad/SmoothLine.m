#import "SmoothLine.h"
#import <QuartzCore/QuartzCore.h>

@implementation SmoothLine

@synthesize arrayStrokes,arrayAbandonedStrokes,currentColor,currentSize;

-(BOOL)isMultipleTouchEnabled {
	return NO;
}

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
    }
    
    return  self;
}

-(void) viewJustLoaded {
	NSLog(@"viewJustLoaded");
    [self setBackgroundColor:[UIColor whiteColor]];
    
    self.layer.borderWidth = 2.0;
    self.layer.borderColor= [[UIColor redColor] CGColor];
    
    self.opaque=false;
    
	
	self.arrayStrokes = [NSMutableArray array];
	self.arrayAbandonedStrokes = [NSMutableArray array];
	self.currentSize = 5.0;
	[self setColor:[UIColor redColor]];
}

-(void) setColor:(UIColor*)theColor {
	self.currentColor = theColor;
}


// Start new dictionary for each touch, with points and color
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	NSMutableArray *arrayPointsInStroke = [NSMutableArray array];
	NSMutableDictionary *dictStroke = [NSMutableDictionary dictionary];
	[dictStroke setObject:arrayPointsInStroke forKey:@"points"];
	[dictStroke setObject:self.currentColor forKey:@"color"];
	[dictStroke setObject:[NSNumber numberWithFloat:self.currentSize] forKey:@"size"];
	
    
	CGPoint point = [[touches anyObject] locationInView:self]; //ktl delete
	[arrayPointsInStroke addObject:NSStringFromCGPoint(point)]; // ktl delete
	
	[self.arrayStrokes addObject:dictStroke];
    
    //to add page no here
}

// Add each point to points array
- (void) touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event
{
	CGPoint point = [[touches anyObject] locationInView:self];
	CGPoint prevPoint = [[touches anyObject] previousLocationInView:self];
	NSMutableArray *arrayPointsInStroke = [[self.arrayStrokes lastObject] objectForKey:@"points"];
	[arrayPointsInStroke addObject:NSStringFromCGPoint(point)];
	
	CGRect rectToRedraw = CGRectMake(\
									 ((prevPoint.x>point.x)?point.x:prevPoint.x)-currentSize,\
									 ((prevPoint.y>point.y)?point.y:prevPoint.y)-currentSize,\
									 fabs(point.x-prevPoint.x)+2*currentSize,\
									 fabs(point.y-prevPoint.y)+2*currentSize\
									 );
	[self setNeedsDisplayInRect:rectToRedraw];
}


// Send over new trace when the touch ends
- (void) touchesEnded:(NSSet *) touches withEvent:(UIEvent *) event
{
	[self.arrayAbandonedStrokes removeAllObjects];
}




// Draw all points, foreign and domestic, to the screen
- (void) drawRect: (CGRect) rect
{
   // NSLog(@"drawrect here 1");
    
	if (self.arrayStrokes)
	{
		int arraynum = 0;
		// each iteration draw a stroke
		// line segments within a single stroke (path) has the same color and line width
		for (NSDictionary *dictStroke in self.arrayStrokes)
		{
			NSArray *arrayPointsInstroke = [dictStroke objectForKey:@"points"];
			UIColor *color = [dictStroke objectForKey:@"color"];
			float size = [[dictStroke objectForKey:@"size"] floatValue];
			[color set];		// equivalent to both setFill and setStroke
			
            //			// won't draw a line which is too short
            //			if (arrayPointsInstroke.count < 3)	{
            //				arraynum++;
            //				continue;		// if continue is executed, the program jumps to the next dictStroke
            //			}
			
			// draw the stroke, line by line, with rounded joints
			UIBezierPath* pathLines = [UIBezierPath bezierPath];
			CGPoint pointStart = CGPointFromString([arrayPointsInstroke objectAtIndex:0]);
			[pathLines moveToPoint:pointStart];
			for (int i = 0; i < (arrayPointsInstroke.count - 1); i++)
			{
				CGPoint pointNext = CGPointFromString([arrayPointsInstroke objectAtIndex:i+1]);
				[pathLines addLineToPoint:pointNext];
			}
			pathLines.lineWidth = size;
			pathLines.lineJoinStyle = kCGLineJoinRound;
			pathLines.lineCapStyle = kCGLineCapRound;
			[pathLines stroke];
			
			arraynum++;
		}
	}
}

-(void)undo {
    NSLog(@"Gona undo");
	if ([arrayStrokes count]>0) {
		NSMutableDictionary* dictAbandonedStroke = [arrayStrokes lastObject];
		[self.arrayAbandonedStrokes addObject:dictAbandonedStroke];
		[self.arrayStrokes removeLastObject];
		[self setNeedsDisplay];
	}
}


-(void)redo {
    NSLog(@"Gona redo");
	if ([arrayAbandonedStrokes count]>0) {
		NSMutableDictionary* dictReusedStroke = [arrayAbandonedStrokes lastObject];
		[self.arrayStrokes addObject:dictReusedStroke];
		[self.arrayAbandonedStrokes removeLastObject];
		[self setNeedsDisplay];
	}
}

-(void)clearCanvas {
    NSLog(@"clear canvas");
	[self.arrayStrokes removeAllObjects];
	[self.arrayAbandonedStrokes removeAllObjects];
	[self setNeedsDisplay];
}


-(void)dealloc {
	[arrayStrokes release];
	[arrayAbandonedStrokes release];
	[currentColor release];
	[super dealloc];
}


@end
