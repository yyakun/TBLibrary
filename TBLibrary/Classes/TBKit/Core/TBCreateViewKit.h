//
//  TBCreateViewKit.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#ifndef TBCreateViewKit_h
#define TBCreateViewKit_h

//  创建一个全局的、用frame来初始化的视图view，没有父视图
#define createView_Global_WithNoneSuperview_WithFrame(className, viewName, viewFrame)\
\
- (className *)viewName\
{\
    if (!_##viewName) {\
        createView_Local_WithNoneSuperview_WithFrame(className, viewName, viewFrame)\
        _##viewName = viewName;\
    }\
    return _##viewName;\
}

//  创建一个用frame来初始化的视图view，没有父视图
#define createView_Local_WithNoneSuperview_WithFrame(className, viewName, viewFrame)\
\
className *viewName = [[className alloc] initWithFrame:viewFrame];\
viewName.objectIdentifier = @#viewName;

//  创建一个局部的、用户自定义的视图view方法的公共部分
#define createView_Local_WithNoneSuperview(className, viewName)\
\
className *viewName = [[className alloc] init];\
[viewName useAutoLayout];\
viewName.objectIdentifier = @#viewName;

//  创建一个局部的、用户自定义的视图view方法的公共部分，并添加到父视图
#define createView_Local(className, viewName, superview)\
\
createView_Local_WithNoneSuperview(className, viewName)\
[superview addSubview:viewName];

//  创建一个局部的视图view
#define createView_Local_UIView(viewName, superview)\
\
createView_Local(UIView, viewName, superview)

//  创建一个全局的、用户自定义的视图view方法的公共部分
#define createView_Global(className, viewName, superview)\
\
- (className *)viewName\
{\
    if (!_##viewName) {\
        createView_Local(className, viewName, superview)\
        _##viewName = viewName;\
    }\
    return _##viewName;\
}

//  创建一个全局的UIView类的视图
#define createView_Global_UIView(viewName, superview)\
\
createView_Global(UIView, viewName, superview)



//  创建一个局部的、用户自定义的标签label方法的公共部分
#define createLabel_Local_WithNoneSuperview(className, labelName, labelTextColor, fontSize, labelText)\
\
createView_Local_WithNoneSuperview(className, labelName)\
labelName.backgroundColor = [UIColor clearColor];\
labelName.textColor = labelTextColor;\
labelName.font = fontSize;\
labelName.text = labelText;

//  创建一个局部的、用户自定义的标签label
#define createLabel_Local(className, labelName, superview, labelTextColor, fontSize, labelText)\
\
createLabel_Local_WithNoneSuperview(className, labelName, labelTextColor, fontSize, labelText)\
[superview addSubview:labelName];

//  创建一个局部的UILabel类的标签
#define createLabel_Local_UILabel(labelName, superview, labelText, labelTextColor, fontSize)\
\
createLabel_Local(UILabel, labelName, superview, labelTextColor, fontSize, labelText)

//  创建一个全局的、自定义的的标签label
#define createLabel_Global(className, labelName, superview, labelTextColor, fontSize, labelText)\
\
- (className *)labelName {\
    if (!_##labelName) {\
        createLabel_Local(className, labelName, superview, labelTextColor, fontSize, labelText)\
        _##labelName = labelName;\
    }\
    return _##labelName;\
}

//  创建一个全局的UILabel类的标签label
#define createLabel_Global_UILabel(labelName, superview, labelTextColor, fontSize, labelText)\
\
createLabel_Global(UILabel, labelName, superview, labelTextColor, fontSize, labelText)



//  创建文本框textField方法的公共部分
#define createTextField_Local_WithNoneSuperview(className, textFieldName, theTextColor, fontSize, textBorderStyle, placeholderText)\
\
createView_Local_WithNoneSuperview(className, textFieldName)\
textFieldName.textColor = theTextColor;\
textFieldName.font = fontSize;\
textFieldName.borderStyle = textBorderStyle;\
textFieldName.placeholder = placeholderText;

//  创建一个局部的、用户自定义的文本框textField
#define createTextField_Local(className, textFieldName, superview, theTextColor, fontSize, textBorderStyle, placeholderText)\
\
createTextField_Local_WithNoneSuperview(className, textFieldName, theTextColor, fontSize, textBorderStyle, placeholderText)\
[superview addSubview:textFieldName];

//  创建一个局部的UITextField类的文本框textField
#define createTextField_Local_UITextField(textFieldName, superview, theTextColor, fontSize, textBorderStyle, placeholderText)\
\
createTextField_Local(UITextField, textFieldName, superview, theTextColor, fontSize, textBorderStyle, placeholderText)

//  创建一个全局的、用户自定义的文本框textField
#define createTextField_Global(className, textFieldName, superview, theTextColor, fontSize, textBorderStyle, placeholderText)\
\
- (className *)textFieldName\
{\
    if (!_##textFieldName) {\
        createTextField_Local(className, textFieldName, superview, theTextColor, fontSize, textBorderStyle, placeholderText)\
        _##textFieldName = textFieldName;\
    }\
    return _##textFieldName;\
}

//  创建一个全局的、UITextField类的文本框textField
#define createTextField_Global_UITextField(textFieldName, superview, theTextColor, fontSize, textBorderStyle, placeholderText)\
\
createTextField_Global(UITextField, textFieldName, superview, theTextColor, fontSize, textBorderStyle, placeholderText)



//  创建图像视图imageView方法的公共部分
#define createImageView_Local_WithNoneSuperview(imageViewName, imageObject)\
\
createView_Local_WithNoneSuperview(UIImageView, imageViewName)\
imageViewName.image = imageObject;

//  创建一个局部的图像视图imageView
#define createImageView_Local(imageViewName, superview, imageObject)\
\
createImageView_Local_WithNoneSuperview(imageViewName, imageObject)\
[superview addSubview:imageViewName];

//  创建一个全局的图像视图
#define createImageView_Global(imageViewName, superview, imageObject)\
\
- (UIImageView *)imageViewName\
{\
    if (!_##imageViewName) {\
        createImageView_Local(imageViewName, superview, imageObject)\
        _##imageViewName = imageViewName;\
    }\
    return _##imageViewName;\
}


#define createTableView_Local_WithNoneSuperview(className, tableViewName, tableViewStyle)\
\
className *tableViewName = [[className alloc] initWithFrame:CGRectZero style:tableViewStyle];\
[tableViewName useAutoLayout];\
tableViewName.objectIdentifier = @#tableViewName;\
tableViewName.delegate = self;\
tableViewName.dataSource = self;\
tableViewName.backgroundColor = [UIColor clearColor];\
tableViewName.separatorStyle = UITableViewCellSeparatorStyleNone;\
tableViewName.tableFooterView = [UIView new];

//  创建一个表视图tableView
#define createTableView_Local(className, tableViewName, superview, tableViewStyle)\
\
createTableView_Local_WithNoneSuperview(className, tableViewName, tableViewStyle)\
[superview addSubview:tableViewName];\

#define createTableView_Local_UITableView(tableViewName, superview, tableViewStyle)\
\
createTableView_Local(UITableView, tableViewName, superview, tableViewStyle)

//  创建一个全局的表视图tableView
#define createTableView_Global(className, tableViewName, superview, tableViewStyle)\
\
- (className *)tableViewName\
{\
    if (!_##tableViewName) {\
        createTableView_Local(className, tableViewName, superview, tableViewStyle)\
        _##tableViewName = tableViewName;\
    }\
    return _##tableViewName;\
}

#define createTableView_Global_UITableView(tableViewName, superview, tableViewStyle)\
\
createTableView_Global(UITableView, tableViewName, superview, tableViewStyle)



//  创建按钮方法的公共部分
#define createButton_Local_WithNotAddTarget_WithNoneSuperview(className, buttonName, buttonType, titleColor, fontSize, title)\
\
className *buttonName = [className buttonWithType:buttonType];\
[buttonName useAutoLayout];\
buttonName.objectIdentifier = @#buttonName;\
[buttonName setTitleColor:titleColor forState:UIControlStateNormal];\
[buttonName.titleLabel setFont:fontSize];\
[buttonName setTitle:title forState:UIControlStateNormal];

//  创建一个局部的、自定义类的按钮，没有添加到父视图上，并设置其按钮大小
#define createButton_Local_WithNoneSuperview_WithFrame(className, buttonName, buttonType, titleColor, fontSize, title, buttonFrame)\
\
createButton_Local_WithNotAddTarget_WithNoneSuperview(className, buttonName, buttonType, titleColor, fontSize, title)\
[buttonName addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];\
[buttonName setView_frame:buttonFrame];

//  创建一个局部的、UIButton类的按钮，没有添加到父视图上，并设置其按钮大小
#define createButton_Local_WithNoneSuperview_WithFrame_UIButton(buttonName, buttonType, titleColor, fontSize, title, buttonFrame)\
\
createButton_Local_WithNoneSuperview_WithFrame(UIButton, buttonName, buttonType, titleColor, fontSize, title, buttonFrame)

//  创建一个局部的、用户自定义的按钮，没有添加点击触发事件
#define createButton_Local_WithNotAddTarget(className, buttonName, superview, buttonType, titleColor, fontSize, title)\
\
createButton_Local_WithNotAddTarget_WithNoneSuperview(className, buttonName, buttonType, titleColor, fontSize, title)\
[superview addSubview:buttonName];

//  创建一个局部的、用户自定义的按钮
#define createButton_Local(className, buttonName, superview, buttonType, titleColor, fontSize, title)\
\
createButton_Local_WithNotAddTarget(className, buttonName, superview, buttonType, titleColor, fontSize, title)\
[buttonName addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];

//  创建一个局部的、UIButton类的按钮，没有添加点击触发事件
#define createButton_Local_WithNotAddTarget_UIButton(buttonName, superview, buttonType, titleColor, fontSize, title)\
\
createButton_Local_WithNotAddTarget(UIButton, buttonName, superview, buttonType, titleColor, fontSize, title)

//  创建一个局部的、UIButton类的按钮
#define createButton_Local_UIButton(buttonName, superview, buttonType, titleColor, fontSize, title)\
\
createButton_Local(UIButton, buttonName, superview, buttonType, titleColor, fontSize, title)

//  创建一个全局的、用户自定义的按钮，首次使用它需要打点调用。
#define createButton_Global(className, buttonName, superview, buttonType, titleColor, fontSize, title)\
\
- (className *)buttonName {\
    if (!_##buttonName) {\
        createButton_Local(className, buttonName, superview, buttonType, titleColor, fontSize, title)\
        _##buttonName = buttonName;\
    }\
    return _##buttonName;\
}

//  创建一个全局的、用户自定义的按钮，没有添加点击触发方法，首次使用它需要打点调用。
#define createButton_Global_WithNotAddTarget(className, buttonName, superview, buttonType, titleColor, fontSize, title)\
\
- (className *)buttonName {\
    if (!_##buttonName) {\
        createButton_Local_WithNotAddTarget(className, buttonName, superview, buttonType, titleColor, fontSize, title)\
        _##buttonName = buttonName;\
    }\
    return _##buttonName;\
}

//  创建一个全局的、UIButton类的按钮，首次使用它需要打点调用。
#define createButton_Global_UIButton(buttonName, superview, buttonType, titleColor, fontSize, title)\
\
createButton_Global(UIButton, buttonName, superview, buttonType, titleColor, fontSize, title)

//  创建一个全局的、UIButton类的按钮，没有添加点击触发方法，首次使用它需要打点调用。
#define createButton_Global_WithNotAddTarget_UIButton(buttonName, superview, buttonType, titleColor, fontSize, title)\
\
createButton_Global_WithNotAddTarget(UIButton, buttonName, superview, buttonType, titleColor, fontSize, title)


#endif
