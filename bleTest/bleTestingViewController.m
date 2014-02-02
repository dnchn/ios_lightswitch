//
//  bleTestingViewController.m
//  bleTest
//
//  Created by Karen Yee on 2/1/14.
//  Copyright (c) 2014 Karen Yee. All rights reserved.
//

#import "bleTestingViewController.h"

@interface bleTestingViewController ()

@end

@implementation bleTestingViewController

@synthesize ble;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ble = [[BLE alloc] init];
    [ble controlSetup];
    ble.delegate = self;
}
- (IBAction)yelowButtonPressed:(id)sender {
    UInt8 buf[2] = {0x02, 0x00};
    UISwitch *switchButton= (UISwitch *)sender;
    
    if (switchButton.on)
        buf[1]=0x01;
    else
        buf[1]=0x00;
    NSData *data = [[NSData alloc] initWithBytes:buf length:2];
    [ble write:data];
}

- (IBAction)greenButtonPressed:(id)sender {
    UInt8 buf[2] = {0x06, 0x00};
    UISwitch *switchButton= (UISwitch *)sender;
    
    if (switchButton.on)
        buf[1]=0x01;
    else
        buf[1]=0x00;
    NSData *data = [[NSData alloc] initWithBytes:buf length:2];
    [ble write:data];
    
}
- (IBAction)redButtonPressed:(id)sender {
    UInt8 buf[2] = {0x04, 0x00};
    UISwitch *switchButton= (UISwitch *)sender;
    if (switchButton.on)
        buf[1]=0x01;
    else
        buf[1]=0x00;
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:2];
    [ble write:data];
}

- (IBAction)bleConnection:(id)sender {
    if (ble.activePeripheral)
        if(ble.activePeripheral.state == CBPeripheralStateConnected)
        {
            [[ble CM] cancelPeripheralConnection:[ble activePeripheral]];
            [btnConnect setTitle:@"Connect" forState:UIControlStateNormal];
            return;
        }
    
    if (ble.peripherals)
        ble.peripherals = nil;
    
    [btnConnect setEnabled:false];
    [ble findBLEPeripherals:2];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)2.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
    
    [indConnecting startAnimating];
}

-(void) connectionTimer:(NSTimer *)timer
{
    [btnConnect setEnabled:true];
    [btnConnect setTitle:@"Disconnect" forState:UIControlStateNormal];
    
    if (ble.peripherals.count > 0)
    {
        [ble connectPeripheral:[ble.peripherals objectAtIndex:0]];
    }
    else
    {
        [btnConnect setTitle:@"Connect" forState:UIControlStateNormal];
        [indConnecting stopAnimating];
    }
}
// When disconnected, this will be called
-(void) bleDidConnect
{
    NSLog(@"->Connected");
    
    [indConnecting stopAnimating];
    
    // send reset
    UInt8 buf[] = {0x04, 0x00, 0x00};
    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
    [ble write:data];

}
- (void)bleDidDisconnect
{
    NSLog(@"->Disconnected");
    
    [btnConnect setTitle:@"Connect" forState:UIControlStateNormal];
    [indConnecting stopAnimating];
}

@end
