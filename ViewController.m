//
//  ViewController.m
//  TableView分级
//
//  Created by qiu on 16/1/11.
//  Copyright © 2016年 hioquax. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)BOOL isOpen1;
@property (nonatomic, assign)BOOL isOpen2;
@property (nonatomic, assign)BOOL isOpen3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.isOpen1 = NO;
    self.isOpen2 = NO;
    self.isOpen3 = NO;
    [self.view addSubview:self.tableView];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self rowCountsWithSection:section];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CELLIDEN"];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLIDEN"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

        UIView *vi = [[UIView alloc]init];
        vi.backgroundColor = [UIColor grayColor];
        return vi;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 1) {
        return 20;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
    
        
        int isSelect = [self rowCountsWithSection:indexPath.section];
        if (isSelect == 2) {
            [self didSelectedCellWithSection:indexPath.section hiden:YES];
        }else{
            [self didSelectedCellWithSection:indexPath.section hiden:NO];
        }
        
    }else{
    
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)didSelectedCellWithSection:(NSInteger)section hiden:(BOOL)aHiden{
    [self changeSelectStateWithSection:section];
    [self.tableView beginUpdates];
    if (aHiden) {
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:section]] withRowAnimation:UITableViewRowAnimationTop];
    }else{
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:section]] withRowAnimation:UITableViewRowAnimationTop];
    }
    [self.tableView endUpdates];
}
- (void)changeSelectStateWithSection:(NSInteger)section{

    switch (section) {
        case 0:
            self.isOpen1 = !self.isOpen1;
            break;
        case 1:
            self.isOpen2 = !self.isOpen2;
            break;
            
        case 2:
            self.isOpen3 = !self.isOpen3;
            break;
            
        default:
            break;
    }
}
- (int)rowCountsWithSection:(NSInteger)aSection{
    switch (aSection) {
        case 0:
            if (self.isOpen1) {
                return 2;
            }
            break;
        case 1:
            if (self.isOpen2) {
                return 2;
            }
            break;
        case 2:
            if (self.isOpen3) {
                return 2;
            }
            break;
        default:
            break;
    }
    return 1;
}

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELLIDEN"];
        _tableView = table;
    }
    return _tableView;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
