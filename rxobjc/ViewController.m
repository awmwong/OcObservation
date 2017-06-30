//
//  ViewController.m
//  rxobjc
//
//  Created by Anthony Wong on 2017-06-28.
//  Copyright © 2017 Anthony Wong. All rights reserved.
//

#import "ViewController.h"
#import "OCView.h"
#import "rxobjc-Swift.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet OCView *ocView;

@property (nonatomic, strong) ColorTicker *colorTicker;

@property (nonatomic, strong) OcObservation *colorObservation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colorTicker = [[ColorTicker alloc] init]; // swift vm
    __weak __typeof(self) that = self;
    self.colorObservation = self.colorTicker.colorObservation; // obtain observation bridge
    [self.colorObservation addSubscription:[[OcSubscription alloc] initOnNext:^(id _Nonnull o) {
        __typeof(that) this = that;
        if (!this) {
            return;
        }
        this.ocView.backgroundColor = o;
    } onError:^(NSError * _Nonnull e) {
        NSLog(@"error: %@", e.description);
    } onCompleted:^{
        NSLog(@"Completed");
    } onDisposed:^{
        NSLog(@"Disposed");
    }]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
