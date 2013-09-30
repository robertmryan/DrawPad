#import "flycentViewController.h"

@implementation flycentViewController
@synthesize drawOnwebview;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"image1.jpg"]]];
    SmoothLine *canvasView = [[SmoothLine alloc] initWithFrame:CGRectMake(0, 0, 1024, 10000)];
    [canvasView viewJustLoaded];
    
    controller = canvasView;
    
    //[self.view addSubview:canvasView];
    
    
    drawOnwebview.scalesPageToFit = YES;
    drawOnwebview.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    drawOnwebview.scrollView.delegate = self;
    
    
    [[drawOnwebview scrollView] setContentOffset:CGPointMake(0,0) animated:YES];
    drawOnwebview.delegate= self;

    //drawOnwebview.scrollView.contentSize= CGSizeMake(1024, 2000);
    [[drawOnwebview scrollView] setContentInset:UIEdgeInsetsMake(0, 0, 10000, 10000)];

    [drawOnwebview.scrollView addSubview:controller];
    
    
    UIButton *temp1 = [[UIButton alloc] initWithFrame:CGRectMake(150, 150, 50, 50)];
    [temp1 setTitle:@"撤销" forState:UIControlStateNormal];
    [temp1 setBackgroundColor:[UIColor redColor]];
    [temp1 addTarget:self action:@selector(handelclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:temp1];
    
    
    UIButton *temp2 = [[UIButton alloc] initWithFrame:CGRectMake(300, 150, 50, 50)];
    [temp2 setTitle:@"清空" forState:UIControlStateNormal];
    [temp2 setBackgroundColor:[UIColor blueColor]];
    [temp2 addTarget:self action:@selector(handelclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:temp2];
    
    
    UIButton *temp3 = [[UIButton alloc] initWithFrame:CGRectMake(450, 150, 50, 50)];
    [temp3 setTitle:@"重画" forState:UIControlStateNormal];
    [temp3 setBackgroundColor:[UIColor greenColor]];
    [temp3 addTarget:self action:@selector(handelclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:temp3];
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)handelclick:(id)sender
{
    //    [[controller undoManager] undo];
    
    if ([((UIButton *)sender).titleLabel.text isEqualToString:@"撤销"]) {
        [controller undo];
    }else if([((UIButton *)sender).titleLabel.text isEqualToString:@"清空"]){
        [controller clearCanvas];
    }else{
        [controller redo];
    }
}


- (void)viewDidUnload
{
    [self setDrawOnwebview:nil];
    [self setAnnotateBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)dealloc {
    [_annotateBtn release];
    [super dealloc];
}
- (IBAction)annotate:(id)sender
{
    if(drawOnwebview.scrollView.scrollEnabled)
    {
        drawOnwebview.scrollView.scrollEnabled=false;
        [self.annotateBtn setTitle:@"Done" forState:UIControlStateNormal];
    }
    else
    {
        drawOnwebview.scrollView.scrollEnabled=true;
        [self.annotateBtn setTitle:@"Annotate" forState:UIControlStateNormal];

    }
}
@end
