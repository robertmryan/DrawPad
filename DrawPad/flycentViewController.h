#import <UIKit/UIKit.h>
#import "SmoothLine.h"
@interface flycentViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIButton *annotateBtn;
@property (retain, nonatomic)          SmoothLine *canvasView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)annotate:(id)sender;

@end
