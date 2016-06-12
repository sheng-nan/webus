# 约定的名称

- createdAt: 创建时间
- updatedAt: 修改时间


# 数据库字段缩写表

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

