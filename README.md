# Webus

## Clone + 启动

    git clone --recursive git@fitark.org:Laniakea/webus.git
    sudo mkdir -p /dfs/lan
    sudo chown fitark /dfs/lan
    sudo mkdir /upload
    sudo chown fitark /upload
    sudo mkdir /dfs/lan/dicom
    sudo chown fitark /dfs/lan/dicom
    meteor

    ALIYUN="TRUE"  ACCESS_KEY_ID="h17xgVZatOgQ6IeJ"  ACCESS_KEY_SECRET="6RrQAXRaurcitBPzdQ18nrvEWjWuWO" meteor
    
## 更改submudule的方法

如果你需要修改submodule，请严格按照下述方法操作，否则会有问题，我们以lib/schema举例
    
首先切换到submodule所在目录
    
    cd lib/schema 
    
然后取出develop分支

    git checkout develop
    
具体修改代码，然后#在develop上commit，push

    git add .
    git commit -m 'modify ....'
    git push origin develop
    
最后需要在主项目里面提交更新，主要是引用的


    cd .../..
    git add .
    git commit -m 'modify ...'
    git push origin develop
    
    



## 数据库字段缩写表

数据库字段尽量采用缩写，以优化存储空间，不过仅对下列列表内容进行缩写，这个列表可以扩充

- name+id配对： 字段本身表示name，尾部加id表示id，比如pat患者，patid患者id
- doc : Doctor 医生
- pat : Pattient 患者
- sc  : Spell Code 拼音缩写码
- hos : Hospital 医院
- dep : Department 科室
- apl : Apply申请
- src : Source 来源
- qc  : Quality Control质控
- img : Image 图像
- vid  : Video 视频
- sex : Gender/Sex 性别
- mod : Modality 模态,  allowedValues:['CT','US','MR','XR']
- dev : Device 设备
- exm : Examination 检查
- exmpt : Examination Part 检查部位
- exmitm : Examination Item 检查项目
- nd  : Node 节点
- usf : Us Findinig 超声所见
- ush : Us Hint 超声所得
- adr : Address 地址
- c   : Count 数量，一般作为尾椎
- des : Description 描述
- itm : Item项目
- t   : Time时间
- apm : Appoiment 预约
- knd : KnowledgeNode

约定的名称

- createdAt: 创建时间
- updatedAt: 修改时间# webus
