//
//  registerTwoViewController.m
//  Demo
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "registerTwoViewController.h"
#import "AccountDao.h"
#import "AppDelegate.h"

@interface registerTwoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userAccountLabel;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *manBtn;

@property (weak, nonatomic) IBOutlet UIButton *womanBtn;
@property(nonatomic,strong)NSString *sex;

@property(nonatomic,strong)NSString *userAccount;

@property(nonatomic,retain)UIView *myView;

@property(nonatomic,strong)NSString *address;

@property (weak, nonatomic) IBOutlet UIButton *myButton;

@end

@implementation registerTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.userAccountLabel.text=appDelegate.userAccounr;
    
    [self.manBtn addTarget:self action:@selector(sexClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.womanBtn addTarget:self action:@selector(sexClick:) forControlEvents:UIControlEventTouchUpInside];


    //设置一个button按钮，点击弹出下拉列表myview
   // UIButton *myButton=[UIButton buttonWithType:UIButtonTypeCustom];
    //给按钮设置位置
   // myButton.frame=CGRectMake(220, 150, 120, 30);
    //设置按钮名称,yanse
    [self.myButton setTitle:@"下拉选择地址" forState:UIControlStateNormal];
    self.myButton.backgroundColor=[UIColor orangeColor];
    //添加点击方法
   // [myButton addTarget:self action:@selector(myActionButton) forControlEvents:UIControlEventTouchUpInside];
    //将按钮添加在主视图
   // [self.view addSubview:myButton];
    
    self.myView=[[UIView alloc]initWithFrame:(CGRectMake(231, 174, 106, 100))];

    UIButton *myButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    myButton1.frame=CGRectMake(0, 0, 106, 40);
    myButton1.backgroundColor=[UIColor orangeColor];
    [myButton1 setTitle:@"北京" forState:UIControlStateNormal];
    [myButton1 addTarget:self action:@selector(myButton1click) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *myButton2=[UIButton buttonWithType:UIButtonTypeCustom];
    myButton2.frame=CGRectMake(0, 40, 106, 40);
    myButton2.backgroundColor=[UIColor orangeColor];
    [myButton2 setTitle:@"上海" forState:UIControlStateNormal];
    [myButton2 addTarget:self action:@selector(myButton2click) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    //将两个button添加到myView上
    [self.myView addSubview:myButton1];
    [self.myView addSubview:myButton2];
    
    //设置myView的透明度
    self.myView.alpha=0;
    
    [self.view addSubview:self.myView];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)myButton:(id)sender {
    
    if(self.myView.alpha==0){
        self.myView.alpha=1;
    }else{
        self.myView.alpha=0;
    }

}

//实现下拉列表的点击方法
//-(void)myActionButton{
//    
//    
//    if(self.myView.alpha==0){
//        self.myView.alpha=1;
//    }else{
//        self.myView.alpha=0;
//    }
//}

-(void)myButton1click{
    
    self.address=@"北京";
    self.myView.alpha=0;
    self.myButton.titleLabel.text=self.address;
    
    
}

-(void)myButton2click{
    self.address=@"上海";
    self.myView.alpha=0;
    self.myButton.titleLabel.text=self.address;
}


-(void)sexClick:(UIButton *)sender{
    
 _manBtn.selected = !_manBtn.selected;
    if(_manBtn.selected==YES){
        _womanBtn.selected=NO;
        self.sex=_manBtn.titleLabel.text;
    }else{
        _womanBtn.selected=YES;
        self.sex=_womanBtn.titleLabel.text;
    }
    
}


- (IBAction)registerTwoNext:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.userName=self.userNameTextField.text;
    appDelegate.userSex=self.sex;
    appDelegate.userAddress=self.address;
    
    UINavigationController *nextThree=[self.storyboard instantiateViewControllerWithIdentifier:@"nextThree"];
    [self presentViewController:nextThree animated:YES completion:nil];

    
    
    
}




@end
