@interface SmoothLine : UIView<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (retain) UIColor* currentColor;
@property float currentSize;
@property (retain) NSMutableArray* arrayStrokes;
@property (retain) NSMutableArray* arrayAbandonedStrokes;
@property BOOL captureTouches;

-(void)undo;
-(void)redo;
-(void)clearCanvas;
@end
