//
//  bleTestingViewController.h
//  bleTest
//
//  Created by Karen Yee on 2/1/14.
//  Copyright (c) 2014 Karen Yee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLE.h"

@interface bleTestingViewController : UIViewController <BLEDelegate>{
    
    IBOutlet UIButton *btnConnect;
    IBOutlet UIActivityIndicatorView *indConnecting;
    
}


@property (strong, nonatomic) BLE *ble;
@end
