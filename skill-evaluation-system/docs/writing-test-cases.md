# How to Write Good Test Cases

编写好的测试用例是skill评估的关键。

## 🎯 核心原则

### 1. 真实性(Authenticity)

测试用例应该反映真实用户的使用场景,而不是开发者臆想的情况。

**Good ✅**:
```json
{
  "prompt": "开始今天的工作",
  "expected_output": "检测今日状态,显示任务列表"
}
```

**Bad ❌**:
```json
{
  "prompt": "Initialize daily workflow management system",
  "expected_output": "System initialization complete"
}
```

**为什么?** 用户会说"开始今天的工作",不会说"Initialize daily workflow management system"。

---

### 2. 覆盖度(Coverage)

测试用例应该覆盖skill的核心功能路径,而不是边缘功能。

**核心路径示例**:
- 启动/初始化
- 核心操作执行
- 完成/收尾

**推荐的测试分布**:
- 60% 核心功能测试
- 30% 重要功能测试
- 10% 边界场景测试

---

### 3. 可验证性(Verifiability)

assertions要能被客观验证,避免主观判断。

**Good ✅**:
```json
{
  "assertions": [
    {
      "name": "创建文件",
      "check": "输出中提到创建文件夹"
    },
    {
      "name": "包含必要字段",
      "check": "task_plan.md包含'任务目标'字段"
    }
  ]
}
```

**Bad ❌**:
```json
{
  "assertions": [
    {
      "name": "用户体验好",
      "check": "感觉流畅"
    }
  ]
}
```

**为什么?** "感觉流畅"无法客观验证,"输出包含XX"可以验证。

---

## 📝 测试用例结构

### 基本结构

```json
{
  "id": 1,
  "prompt": "用户输入",
  "expected_output": "预期输出描述",
  "files": [],
  "assertions": [
    {
      "name": "检查项名称",
      "check": "检查条件"
    }
  ]
}
```

### 各字段说明

**id** (必需):
- 唯一标识符
- 数字,从1开始递增

**prompt** (必需):
- 用户实际会说的内容
- 使用用户语言,不要技术术语
- 可以包含上下文信息

**expected_output** (必需):
- 简洁描述预期输出
- 帮助理解测试目的

**files** (可选):
- 测试需要的输入文件路径
- 相对路径或绝对路径
- 如果不需要文件,留空数组

**assertions** (推荐):
- 具体的检查项
- 每个assertion应该是独立的
- assertion数量:3-5个为宜

---

## 🎨 编写技巧

### Tip 1: 使用用户角色

想象你是一个第一次使用skill的用户:
- 他们会说什么?
- 他们期望看到什么?
- 什么会让他们困惑?

### Tip 2: 从问题出发

从用户遇到的问题出发编写测试:
- 用户想要完成什么任务?
- 任务的输入是什么?
- 成功的标志是什么?

### Tip 3: 渐进式复杂度

从简单场景开始,逐步增加复杂度:
```
Test 1: 简单启动
Test 2: 基本操作
Test 3: 复杂操作
Test 4: 边界场景
```

### Tip 4: 使用真实数据

尽可能使用真实数据,而不是虚构数据:
- 真实的文件路径
- 真实的数据格式
- 真实的用户表达

---

## ⚠️ 常见错误

### 错误1: 测试过于抽象

**Bad**:
```json
{
  "prompt": "Process data",
  "expected_output": "Data processed successfully"
}
```

**Good**:
```json
{
  "prompt": "将这个CSV文件转换为JSON格式: data/sales_2024.csv",
  "expected_output": "读取CSV文件,转换为JSON,保存为sales_2024.json"
}
```

### 错误2: assertions太严格

**Bad**:
```json
{
  "assertions": [
    {
      "name": "输出完全匹配",
      "check": "输出必须等于'任务完成'"
    }
  ]
}
```

**Good**:
```json
{
  "assertions": [
    {
      "name": "包含完成标记",
      "check": "输出包含'完成'或'✅'"
    }
  ]
}
```

**为什么?** 太严格的assertion会导致误判,skill的输出可能略有变化但仍正确。

### 错误3: 测试数量太多

**Bad**: 一上来就写20个测试用例

**Good**: 先写3-5个核心测试,通过后再扩展

---

## 📚 测试用例类型

### 1. 启动测试(Initialization Test)

测试skill的初始化流程。

```json
{
  "id": 1,
  "prompt": "开始[功能]",
  "assertions": [
    {"name": "状态检测", "check": "检测当前状态"},
    {"name": "信息显示", "check": "显示相关信息"},
    {"name": "用户指引", "check": "提供下一步选项"}
  ]
}
```

### 2. 功能测试(Functionality Test)

测试核心功能是否正常工作。

```json
{
  "id": 2,
  "prompt": "执行[核心操作]",
  "assertions": [
    {"name": "输入处理", "check": "正确处理输入"},
    {"name": "操作执行", "check": "执行核心操作"},
    {"name": "输出生成", "check": "生成预期输出"}
  ]
}
```

### 3. 完成测试(Completion Test)

测试任务完成流程。

```json
{
  "id": 3,
  "prompt": "完成/结束",
  "assertions": [
    {"name": "状态更新", "check": "更新完成状态"},
    {"name": "数据保存", "check": "保存相关数据"},
    {"name": "总结生成", "check": "生成完成总结"}
  ]
}
```

### 4. 边界测试(Edge Case Test)

测试特殊场景和异常情况。

```json
{
  "id": 4,
  "prompt": "[特殊场景]",
  "assertions": [
    {"name": "错误检测", "check": "检测到异常情况"},
    {"name": "友好提示", "check": "提供错误提示"},
    {"name": "恢复选项", "check": "提供解决方案"}
  ]
}
```

---

## 🎯 检查清单

提交测试用例前,确认:

- [ ] 每个prompt都使用用户真实表达
- [ ] assertions可以客观验证
- [ ] 覆盖核心功能路径
- [ ] 测试用例数量合理(3-10个)
- [ ] 有清晰的expected_output描述
- [ ] 文件路径(如果有)真实存在

---

## 💡 示例对比

### Poor Test Case

```json
{
  "id": 1,
  "prompt": "Do something",
  "expected_output": "Something done",
  "assertions": [
    {"name": "Works", "check": "It works"}
  ]
}
```

**问题**:
- prompt不真实
- expected_output太模糊
- assertion无法验证

### Good Test Case

```json
{
  "id": 1,
  "prompt": "将这个PDF文件转换为Word文档: reports/quarterly.pdf",
  "expected_output": "读取PDF内容,转换为Word格式,保存为quarterly.docx",
  "assertions": [
    {"name": "文件读取", "check": "输出提到读取了quarterly.pdf"},
    {"name": "格式转换", "check": "生成.docx文件"},
    {"name": "内容保留", "check": "Word文档包含PDF的主要内容"}
  ]
}
```

**优点**:
- prompt真实具体
- expected_output清晰
- assertions可验证
- 使用真实文件路径

---

## 📖 延伸阅读

- [评估方法论](./evaluation-methodology.md)
- [解读评估结果](./interpreting-results.md)
- [最佳实践](./best-practices.md)

---

**记住**: 好的测试用例能真实反映skill的价值! 🎯