SimpleSchema.messages
  required: '[label] 是必填项'
  minString: '[label] 最少需要 [min] 个字符(每个中文字符占2位)'
  maxString: '[label] 不能超过 [max] 个字符(每个中文字符占2位)'
  minNumber: '[label] 不能小于 [min]'
  maxNumber: '[label] 不能超过 [max]'
  minDate: '[label] 必须晚于 [min]'
  maxDate: '[label] 必须早于 [max]'
  badDate: '[label] 不是一个合法的日期格式'
  minCount: '您最少需要定义 [minCount] 个值'
  maxCount: '这里不能超过 [maxCount] 个值'
  noDecimal: '[label] 必须是一个整数'
  notAllowed: '[value] 是不允许的数据格式'
  expectedString: '[label] 必须是一个字符串'
  expectedNumber: '[label] 必须是一个数字'
  expectedBoolean: '[label] 必须是一个是非值'
  expectedArray: '[label] 必须是一个列表'
  expectedObject: '[label] 必须是一个对象'
  expectedConstructor: '[label] 必须是一个 [type]'
  regEx: [
    { msg: '[label] 正则校验失败' }
    {
      exp: SimpleSchema.RegEx.Email
      msg: '[label] 好像并不是一个电子邮件地址'
    }
    {
      exp: SimpleSchema.RegEx.WeakEmail
      msg: '[label] 好像并不是一个电子邮件地址'
    }
    {
      exp: SimpleSchema.RegEx.Domain
      msg: '[label] 看起来不像一个链接地址'
    }
    {
      exp: SimpleSchema.RegEx.WeakDomain
      msg: '[label] 看起来不像一个链接地址'
    }
    {
      exp: SimpleSchema.RegEx.IP
      msg: '[label] 并不是一个合法的 IPv4 或 IPv6 地址'
    }
    {
      exp: SimpleSchema.RegEx.IPv4
      msg: '[label] 并不是一个合法的 IPv4 地址'
    }
    {
      exp: SimpleSchema.RegEx.IPv6
      msg: '[label] 并不是一个合法的 IPv6 地址s'
    }
    {
      exp: SimpleSchema.RegEx.Url
      msg: '[label] 应该是一个链接'
    }
    {
      exp: SimpleSchema.RegEx.Id
      msg: '[label] 应该是一个合法的标识符'
    }
  ]
  keyNotInSchema: '[key] 不在数据模型的结构中'