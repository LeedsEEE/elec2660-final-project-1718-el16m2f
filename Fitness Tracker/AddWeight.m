//
//  AddWeight.m
//  Fitness Tracker
//
//  Created by Matthew Fisher [el16m2f] on 23/11/2017.
//  Copyright © 2017 Matthew Fisher [el16m2f]. All rights reserved.
//

#import "AddWeight.h"

@interface AddWeight ()

@end

@implementation AddWeight

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _SaveButton.layer.cornerRadius = 25;
    
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

#pragma WeightPickerView setip

-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component {
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 6;                                                                               //Setting the number of columns in the picker view to 5. 2 numbers, a decimal place, a number and a measurement choice.
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    
    NSInteger rows;
    
    
    if(component == 0){
        rows = 2;
    }else if(component == 3) {
        rows = 1;
    }else if(component == 5){
        rows = 2;
    }else{
        rows = 10;
    }
    
    return rows;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component {
    
    NSString *Title;
        
    if(component == 3){
        
        Title = [NSString stringWithFormat:@"."];
        
    }else if(component == 5){
        
        if (row == 0){
            Title = [NSString stringWithFormat:@"Kg"];
        }else if(row == 1){
            Title = [NSString stringWithFormat:@"lb"];
        }
        
    }else{
        
        Title = [NSString stringWithFormat:@"%li",row];
        
    }
    
    return Title;
    
}

- (IBAction)SaveButtonPressed:(id)sender {
    
}

@end
