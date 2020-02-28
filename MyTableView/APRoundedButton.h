//
//  APRoundedButtom.h
//  MyTableView
//
//  Created by macOS on 30/06/19.
//  Copyright © 2019 macOS. All rights reserved.
//  http:/ /www.albertopasca.it/whiletrue/
//  https:/ /github.com/elpsk/APRoundedButton
//

#import <UIKit/UIKit.h>


IB_DESIGNABLE
@interface APRoundedButton : UIButton

@property (nonatomic) IBInspectable BOOL    topLeft;
@property (nonatomic) IBInspectable BOOL    topRigth;
@property (nonatomic) IBInspectable BOOL    bottomLeft;
@property (nonatomic) IBInspectable BOOL    bottomRigth;
@property (nonatomic) IBInspectable int     cornerRadius;
@property (nonatomic) IBInspectable UIColor *fillColor;

@end
