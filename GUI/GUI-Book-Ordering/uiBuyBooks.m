function varargout = uiBuyBooks(varargin)
% UIBUYBOOKS M-file for uiBuyBooks.fig
%      UIBUYBOOKS, by itself, creates a new UIBUYBOOKS or raises the existing
%      singleton*.
%
%      H = UIBUYBOOKS returns the handle to a new UIBUYBOOKS or the handle to
%      the existing singleton*.
%
%      UIBUYBOOKS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UIBUYBOOKS.M with the given input arguments.
%
%      UIBUYBOOKS('Property','Value',...) creates a new UIBUYBOOKS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before uiBuyBooks_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to uiBuyBooks_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help uiBuyBooks

% Last Modified by GUIDE v2.5 17-Sep-2012 05:08:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @uiBuyBooks_OpeningFcn, ...
                   'gui_OutputFcn',  @uiBuyBooks_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

end

%初始化函数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function uiBuyBooks_OpeningFcn(hObject, ~, handles, varargin)
%handles里面的各种field
%
%names:单列元胞数组,每个元胞中是人名
%Nnames:numel(names)
%male_ind:单行double,男生的编号
%female_ind:单行double,女生的编号
%buy:买书的序号,元胞数组,每个元胞内是double数组
%person_price:单列double数组,每个人应交的钱
%remarks:单列元胞,每个人的备注
%ind: 当前清单的人名引索
%booknames:单列元胞数组,每个元胞是书名
%Nbooks:numel(booknames)
%bookprices:单列double数组,书的单价
%subtotals:单列double数组,每本书的总数
%total_price:所有书的总价
%list:单列元胞数组,每个人的清单

folder=which('buybooks.mat');
if isempty(folder);   %无存档,生成新数据
     folder=input('没有存档文件, 输入地址以新建存档');
     names={'岑伟智';  '时宏宇'; '朱应'; '李叙彬'; '麦德平'; '高旅威'; '游才臻'; '林文槟'; '杨根'; '陈许权';......
                 '陈银州'; '孙海鹰'; '潘威'; '李伟良'; '徐鼎豪'; '李将';.....
                 '李莹莹'; '邓妍'; '康慧敏'; '许炜苹'; '曾静华'; '王洁琳'; '赵佳玮'; '凌舒愉'; '郑少芳'; '许史媛';........
                 '吴敏怡'; '王晓通'; '黄彦'; '吴秋珍'; '黄妙芝'; '张黎莉'; '郑一秀'; '杨蕙应'; '李欣璐'; '米拉';.........
                 '黄文如'};
    male_ind=1:13;%男生的编号
    female_ind=14:33;%女生的编号
    Nnames=numel(names);%总人数
    buy=cell(Nnames,1);buy(:)={''};
    remarks=cell(Nnames,1); remarks(:)={''};%备注
    
    booknames={};%元胞数组
    bookprices=[];%double数组
else  %如果有存档,读取存档路径,读取存档数据
    temp=strfind(folder,'\');
    folder=folder(1: temp(end));
    
    load buybooks.mat names  buy booknames bookprices remarks male_ind female_ind
    Nnames=numel(names);%总人数
end

person_price=zeros(Nnames,1);%个人总价
Nbooks=numel(booknames);%书的种类数
subtotals=zeros(Nbooks,1);%每本书的数量
list=cell(Nnames,1); list(:)={{''}};%个人清单.list{ii}中是cell格式的文本(每个cell一行)

%保存数据
handles.folder=folder;
handles.names=names;
handles.male_ind=male_ind;
handles.female_ind=female_ind;
handles.Nnames=Nnames;
handles.buy=buy;
handles.person_price=person_price;
handles.remarks=remarks;
handles.ind=1;%个人清单的内容(第ind个人)

handles.booknames=booknames;
handles.Nbooks=Nbooks;
handles.bookprices=bookprices;
handles.subtotals=subtotals;
handles.total_price=0;
handles.list=list;

handles=calculate(handles);%刷新数据
renew_tables(handles);%刷新表格
show_text(handles);%更新清单

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
end

%回调函数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function save_Callback(~, ~, handles)%把原始数据(非计算结果)保存到mat文件

names=handles.names;
male_ind=handles.male_ind;
female_ind=handles.female_ind;
buy=handles.buy;
remarks=handles.remarks;

booknames=handles.booknames;
bookprices=handles.bookprices;

if exist('buybooks.mat','file')
    delete buybooks.mat
end

folder=handles.folder;
oldfolder=cd;
cd(folder);
save buybooks names male_ind female_ind buy remarks booknames bookprices
cd(oldfolder);

end

function add_Callback(~, ~, handles)%在table1(左)底部加入一行
% hObject    handle to add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Nbooks=handles.Nbooks+1;
handles.booknames=[handles.booknames;{''}];
handles.bookprices=[handles.bookprices;0];
handles.subtotals=[handles.subtotals; 0];
guidata(handles.table1,handles);

renew_tables(handles);

end

function table1_CellEditCallback(~, ~, handles)
handles=renew_handles(handles);
handles=calculate(handles);
renew_tables(handles);
show_text(handles);
end


function table2_CellEditCallback(~, ~, handles)
handles=renew_handles(handles);
handles=calculate(handles);
renew_tables(handles);
show_text(handles);
end

function table2_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to table2 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(eventdata.Indices) && eventdata.Indices(2)==1 %选中某个人名
    handles.ind=eventdata.Indices(1);
    show_text(handles);
    guidata(hObject,handles);
end
end



%自编函数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function handles1=calculate(handles)

names=handles.names;
Nnames=handles.Nnames;
male_ind=handles.male_ind;
female_ind=handles.female_ind;
buy=handles.buy;
remarks=handles.remarks;


booknames=handles.booknames;
Nbooks=handles.Nbooks;
bookprices=handles.bookprices;

%计算每本书的总数,每个人的清单
subtotals=zeros(Nbooks,1);
list=cell(Nnames,1);
person_price=zeros(Nnames,1);

for ii=1:Nnames
    if ~isempty(buy{ii})%如果有订书
        ind=buy{ii};
        n=numel(ind);%该同学订书的数量
        list{ii}=cell(n+4,1);list{ii}(:)={''};
        list{ii}{1}=[names{ii} '的清单'];
        for jj=1:n
            list{ii}{jj+2}=[booknames{ind(jj)} '   '  num2str(bookprices(ind(jj))) ];
            subtotals(ind(jj))=subtotals(ind(jj))+1;
            person_price(ii)=person_price(ii)+bookprices(ind(jj));
        end
        %文本总计
        list{ii}{jj+4}=['总计:' num2str(person_price(ii))];
    end
end
%男生总价
male_price=0;
for ii=male_ind
    male_price=male_price+person_price(ii);
end
%女生总价
female_price=0;
for ii=female_ind
    female_price=female_price+person_price(ii);
end
%总价
total_price=male_price+female_price;

%评论处理
%1.含有数字, 则默认是已交的钱数
%2.含有'已交', 或'!', 则默认已经交齐
%3.含有'已发', 或'~',则说明已经下发
%暂时尽量不要含有其他的备注

states=zeros(Nnames,3);%第一列:已交标记(1/0) 第二列: 已发标记(1/0) 第三列: 已交数目(数字)

for ii=1:Nnames
    if isempty(remarks{ii});
        continue
    else
        temp1=strfind(remarks{ii},'!');
        temp2=strfind(remarks{ii},'已交');
        if ~isempty(temp1) || ~isempty(temp2)
            remarks{ii}(temp1)=[];
            remarks{ii}(temp2)=[];
            states(ii,1)=1;
        end
        
        temp1=strfind(remarks{ii},'~');
        temp2=strfind(remarks{ii},'已发');
        if ~isempty(temp1) || ~isempty(temp2)
            remarks{ii}(temp1)=[];
            remarks{ii}(temp2)=[];
            states(ii,2)=1;
        end
        
        temp=zeros(2,1);
        
        for jj=1:numel(remarks{ii})%这个循环找到第一串数字
            if remarks{ii}(jj)<='9' && remarks{ii}(jj)>='0'
                if temp(1)==0
                    temp(1)=jj;
                else
                    break
                end
            else
                if temp(1)~=0
                    temp(2)=jj;
                end
            end
        end
        
        if temp(1)~=0
            if temp(2)~=0
                states(ii,3)=str2double(remarks{ii}(temp(1) : temp(2)));
            else
                states(ii,3)=str2double(remarks{ii}(temp(1) : end));
            end
        end
    end
end



for ii=1:Nnames
    text='';
    if states(ii,1)==1
        text='已交';
    elseif states(ii,3)~=0
        text=['交了' num2str(states(ii,3))];
    end
    
    if states(ii,2)==1
        text=[text ' 已发'];
    end
    remarks{ii}=text;
    
end



handles.list=list;
handles.person_price=person_price;
handles.subtotals=subtotals;
handles.total_price=total_price;
handles.male_price=male_price;
handles.female_price=female_price;
handles.remarks=remarks;
handles.states=states;


guidata(handles.edit,handles)

if nargout>0
    handles1=handles;
end

end

function show_text(handles)%显示个人清单
set(handles.edit,'String',handles.list{handles.ind})
end

function renew_tables(handles)%根据handles中的数据,更新表格以及显示总价的text

%填写table1
table1Data=cell(handles.Nbooks,3);
table1Data(:,1)=handles.booknames(:);
table1Data(:,2)=num2cell(handles.bookprices(:));
table1Data(:,3)=num2cell(handles.subtotals(:));
set(handles.table1,'Data',table1Data);
set(handles.text,'String',['总价:' num2str(handles.total_price)])

%填写table2
table2Data=cell(handles.Nnames,4);
table2Data(:,1)=handles.names(:);
for ii=1:handles.Nnames
table2Data{ii,2}=num2str(handles.buy{ii});
end
table2Data(:,3)=num2cell(handles.person_price(:));
table2Data(:,4)=handles.remarks(:);
set(handles.table2,'Data',table2Data);
set(handles.text1,'String',['男生总计:' num2str(handles.male_price)]);
set(handles.text2,'String',['女生总计:' num2str(handles.female_price)]);



end

function handles1=renew_handles(handles)%把表格里的东西更新到handles中(不包括计算结果)
    
table1Data=get(handles.table1,'Data');
table2Data=get(handles.table2,'Data');

handles.booknames=table1Data(:,1);
handles.bookprices=[table1Data{:,2}]';
    
handles.names=table2Data(:,1);
for ii=1:handles.Nnames
    handles.buy{ii}=str2num(table2Data{ii,2});
end
handles.remarks=table2Data(:,4);
guidata(handles.table1,handles)

if nargout>0
    handles1=handles;
end

end

%没用的函数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = uiBuyBooks_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

function edit_CreateFcn(hObject, ~, ~)
% hObject    handle to edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end
