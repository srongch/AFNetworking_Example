//
//  ViewController.m
//  AFNetworking Testing
//
//  Created by Chhem Sronglong on 30/05/2018.
//  Copyright © 2018 Things9. All rights reserved.
//

#import "ViewController.h"
#import "APIManager.h"
#import "APIModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *list;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self demoAPI];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.list.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    
    APIModel *model = [[APIModel alloc ] initWithDictionary:[self.list objectAtIndex:indexPath.row] error:nil];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://206.189.145.92:8080/dtalk/download/image?file=%@", model.image]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    return cell;
}

#pragma mark LOGIN_API

-(void)demoAPI{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@"all" forKey:@"action"];
    [param setObject:@"test2@email.com" forKey:@"userid"];
    [param setObject:@"lastest" forKey:@"kind"];
    [param setObject:@"1" forKey:@"index"];
    
    NSURLSessionDataTask *task = [APIManager callAPIServer:@"ideabookList" callback:^(NSDictionary *response, id userData, NSError *error) {
        NSLog(@"%@",error.description);
        NSLog(@"%@",response[@"extra"]);
        self.list = [response[@"extra"] objectForKey:@"list"];
        [self.collectionView reloadData];
        
    } param:param enabledInteraction:NO];
    [task resume];
    
    
}

@end
