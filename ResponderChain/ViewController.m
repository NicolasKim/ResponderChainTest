//
//  ViewController.m
//  ResponderChain
//
//  Created by dreamtracer on 2019/3/8.
//  Copyright © 2019 dreamtracer. All rights reserved.
//
#import "ViewController.h"


@interface __InnerView : UIView

@property (nonatomic,weak)UIView * clientView;

@end

@implementation __InnerView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView * view = [super hitTest:point withEvent:event];
    NSLog(@"%s",__func__);
    if (view == self) {
        CGPoint p = [self convertPoint:point toView:self.clientView];
        if (p.x < 0) {
            p.x = 1;
        }
        else if (p.x > CGRectGetWidth(self.clientView.frame)){
            p.x = CGRectGetWidth(self.clientView.frame) - 1;
        }
        UIView * resultView = [self.clientView hitTest:p withEvent:event];
        if (resultView) {
            return resultView;
        }
        return self.clientView;
    }
    return view;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
}


@end


@interface TestTableViewCell : UITableViewCell
@property (nonatomic,strong)UIButton * button;
@end

@implementation TestTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.button];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.button.frame = CGRectMake(0, 0, CGRectGetHeight(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
}
-(UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor redColor];
    }
    return _button;
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView * view = [super hitTest:point withEvent:event];
    NSLog(@"%s",__func__);
    
    return view;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"%s",__func__);
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    NSLog(@"%s",__func__);
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    NSLog(@"%s",__func__);
}

@end


@interface TestTableView : UITableView


@property (nonatomic,assign)UIEdgeInsets ah_edgeInsets;

@end

@implementation TestTableView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView * view = [super hitTest:point withEvent:event];
    NSLog(@"%s",__func__);
    return view;
}

//
//-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//
//    _ah_edgeInsets = UIEdgeInsetsMake(0, -100, 0, -100);
//
//    CGRect expandedRect = CGRectMake(_ah_edgeInsets.left - self.contentInset.left,
//                                     _ah_edgeInsets.top - self.contentInset.top,
//                                     self.contentSize.width - _ah_edgeInsets.left - _ah_edgeInsets.right + self.contentInset.left + self.contentInset.right,
//                                     self.contentSize.height - _ah_edgeInsets.top - _ah_edgeInsets.bottom + self.contentInset.top + self.contentInset.bottom);
//    if (CGRectContainsPoint(expandedRect, point)) {
//        return YES;
//    }
//    else{
//        return [super pointInside:point withEvent:event];
//    }
//
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    
    NSLog(@"%s",__func__);
    
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    NSLog(@"%s",__func__);
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    NSLog(@"%s",__func__);
}


@end




@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)TestTableView * tableView;

@property (nonatomic,strong)UIScrollView * scrollView;

@end

@implementation ViewController
-(void)loadView{
    self.view = [[__InnerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    
    
    self.tableView = [[TestTableView alloc] initWithFrame:CGRectInset(self.view.bounds, 70, 0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.view addSubview:self.tableView];
    [(__InnerView *)self.view setClientView:self.tableView];
    
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectInset(self.view.bounds, 70, 0)];
//    self.scrollView.contentSize = CGSizeMake(2000, 2000);
//    self.scrollView.backgroundColor = [UIColor whiteColor];
//
//
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(950, 950, 100, 100)];
//    view.backgroundColor = [UIColor redColor];
//    [self.scrollView addSubview:view];
//    [self.view addSubview:self.scrollView];
//    [(__InnerView *)self.view setClientView:self.scrollView];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TestTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[TestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell.button addTarget:self action:@selector(didSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld条数据",indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cell selected");
}

-(void)didSelectButton:(UIButton *)sender{
    NSLog(@"button selected");
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"%s",__func__);
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    NSLog(@"%s",__func__);
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    NSLog(@"%s",__func__);
}


@end
