//
//  ViewController.m
//  UIImageWriteToSavedPhotosAlbumSample
//
//  Created by 廣川政樹 on 2013/04/19.
//  Copyright (c) 2013年 Dolice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIButton *button;

@end

@implementation ViewController

//保存する画像ファイル
NSString *_imageName = @"Pandora_640_1136.jpg";

int _buttonWidth = 58;
int _buttonHeight = 42;
int _buttonMarginY = 32;

- (void)viewDidLoad
{
  [super viewDidLoad];
	[self initImage];
  [self initSaveButton];
}

- (void)initImage
{
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
  imageView.image = [[UIImage imageNamed:_imageName] init];
  [self.view addSubview:imageView];
}

- (void)initSaveButton
{
  self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  self.button.frame = CGRectMake((self.view.frame.size.width / 2) - (_buttonWidth / 2),
                                 self.view.frame.size.height - _buttonHeight - _buttonMarginY,
                                 _buttonWidth,
                                 _buttonHeight);
  [self.button setTitle:@"Save"
               forState:UIControlStateNormal];
  [self.button sizeToFit];
  [self.button addTarget:self
                  action:@selector(saveButtonEvent)
        forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.button];
}

//画像を保存する
- (void)saveButtonEvent
{
  //保存する画像を指定
  UIImage *image = [UIImage imageNamed:_imageName];
  //画像保存完了時のセレクタ指定
  SEL selector = @selector(onCompleteCapture:didFinishSavingWithError:contextInfo:);
  //画像を保存する
  UIImageWriteToSavedPhotosAlbum(image, self, selector, NULL);
}

//画像保存完了時のセレクタ
- (void)onCompleteCapture:(UIImage *)screenImage
 didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
  NSString *message = @"画像を保存しました";
  if (error) message = @"画像の保存に失敗しました";
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @""
                                                  message: message
                                                 delegate: nil
                                        cancelButtonTitle: @"OK"
                                        otherButtonTitles: nil];
  [alert show];
}

@end
