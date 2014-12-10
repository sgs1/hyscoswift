//
//  webview.m
//  hyscoswift
//
//  Created by Joas Scicchitano on 10/12/14.
//  Copyright (c) 2014 ___informaticamilano___. All rights reserved.
//

#import "webview.h"
@interface webview ()
@property (strong, nonatomic) UIWebView *hsycoview;
@end

@implementation webview


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *urlString = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"urlremoto"];
    
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //[NSURL URLWithString:@"https://office.hsyco.net/hschschsc/office"];
    
    // request load with cache
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:15.0];
    
    // Define webframe with autosize and rotation, width/height
    self.hsycoview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.hsycoview.scalesPageToFit = YES;
    self.hsycoview.frame = CGRectMake(0, 0, 1024, 768);
    self.hsycoview.autoresizesSubviews = YES;
    self.hsycoview.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    [self.view addSubview:self.hsycoview];
    
    [self.hsycoview loadRequest:theRequest];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
#if DEBUG
@implementation NSURLRequest (NSURLRequestWithIgnoreSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}

@end

#endif

