#import "flycentViewController.h"

@implementation flycentViewController
//@synthesize drawOnwebview;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.canvasView = [[[SmoothLine alloc] initWithFrame:CGRectMake(0, 0, 1024, 10000)] autorelease];

    [self.scrollView addSubview:self.canvasView];
    [self.scrollView setContentSize:CGSizeMake(1024, 10000)];
    
    UIButton *temp1 = [[[UIButton alloc] initWithFrame:CGRectMake(150, 150, 50, 50)] autorelease];
    [temp1 setTitle:@"撤销" forState:UIControlStateNormal];
    [temp1 setBackgroundColor:[UIColor redColor]];
    [temp1 addTarget:self action:@selector(handleUndoButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:temp1];
    
    UIButton *temp2 = [[[UIButton alloc] initWithFrame:CGRectMake(300, 150, 50, 50)] autorelease];
    [temp2 setTitle:@"清空" forState:UIControlStateNormal];
    [temp2 setBackgroundColor:[UIColor blueColor]];
    [temp2 addTarget:self action:@selector(handleClearButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:temp2];

    UIButton *temp3 = [[[UIButton alloc] initWithFrame:CGRectMake(450, 150, 50, 50)] autorelease];
    [temp3 setTitle:@"重画" forState:UIControlStateNormal];
    [temp3 setBackgroundColor:[UIColor greenColor]];
    [temp3 addTarget:self action:@selector(handleRedoButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:temp3];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)handleUndoButton:(id)sender
{
    [self.canvasView undo];
}

- (void)handleClearButton:(id)sender
{
    [self.canvasView clearCanvas];
}

- (void)handleRedoButton:(id)sender
{
    [self.canvasView redo];
}

// FYI, this is no longer called in iOS 6 and later

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setAnnotateBtn:nil];

    [super viewDidUnload];
}

// FYI, this is deprecated in iOS 6

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)dealloc {
    [_annotateBtn release];
    [_scrollView release];
    [super dealloc];
}

- (IBAction)annotate:(id)sender
{
    if(self.scrollView.scrollEnabled)
    {
        self.scrollView.scrollEnabled = NO;
        self.canvasView.captureTouches = YES;
        [self.annotateBtn setTitle:@"Done" forState:UIControlStateNormal];
    }
    else
    {
        self.scrollView.scrollEnabled = YES;
        self.canvasView.captureTouches = NO;
        [self.annotateBtn setTitle:@"Annotate" forState:UIControlStateNormal];
    }
}
@end
