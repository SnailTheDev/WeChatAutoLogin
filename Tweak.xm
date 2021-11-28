// 8013微信版本后
@interface MultiDeviceCardLoginContentView : UIView
- (void)layoutSubviews;
- (void)onTapConfirmButton;
@end

%hook MultiDeviceCardLoginContentView
// 在展示子视图的同时，执行登录函数
- (void)layoutSubviews {

  %orig;
  [self onTapConfirmButton];
  
}
%end

// 8012之前
@interface ExtraDeviceLoginViewController
@property(retain, nonatomic) UIButton *confirmBtn;
- (void)onConfirmBtnPress:(id)arg1;
@end

#define ARC4RANDOM_MAX      0x100000000

%hook ExtraDeviceLoginViewController

- (void)viewDidLoad {
  %orig;

  double delayInSeconds = ((double)arc4random() / ARC4RANDOM_MAX) * 1.2f;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      [self onConfirmBtnPress: self.confirmBtn];
    });

}
%end





%ctor {
	NSLog(@"HookWechat自动登陆已注入");
}