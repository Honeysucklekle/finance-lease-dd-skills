# 融资租赁承租人财务尽调技能包

这是一套面向融资租赁业务经理的 Codex Skills，用于根据审计报告、科目余额表和财务信息工作簿，辅助生成承租人财务尽调报告。

本项目只发布可复用的工作流、技能说明、脱敏模板说明和校验脚本，不包含任何真实客户资料。

## 包含技能

- `financial-key-subjects`：生成或复核重点科目底稿，按资产占比 5%、负债及权益占比 3% 筛选重点科目，整理二级明细、往来前五大和报表调整/重分类口径。
- `financial-lessee-due-diligence`：根据重点科目底稿、财务信息工作簿、审计报告和尽调模板，撰写、排版和复核承租人财务尽调报告。

## 核心流程

1. 准备三年审计报告、最新一期科目余额表或半年报、财务信息工作簿。
2. 使用 `financial-key-subjects` 生成或复核 `重要科目` sheet。
3. 按资产 5%、负债及权益 3% 阈值确定正式尽调的主要科目清单。
4. 使用 `financial-lessee-due-diligence` 复制尽调模板，撰写正式尽调。
5. 复核格式、表格、文字分析、前五大披露和数据勾稽。

## 正式尽调披露规则

- 不写入 `入选科目及占比汇总`。
- 不单独写入 `报表调整/重分类口径说明` 板块。
- 前五大只披露最新一期；只有最新一期没有资料时才披露上一年。
- 有前五大的科目顺序为：科目明细表、文字说明、前五大表格。
- 若底稿中的重要科目比 Word 报告多，必须补齐报告，不能概括掉。

## 安装到 Codex

将 `skills/` 下的两个目录复制到本机 Codex skills 目录：

```powershell
$source = "C:\path\to\finance-lease-dd-skills\skills"
$target = "$env:USERPROFILE\.codex\skills"
Copy-Item "$source\financial-key-subjects" "$target\financial-key-subjects" -Recurse -Force
Copy-Item "$source\financial-lessee-due-diligence" "$target\financial-lessee-due-diligence" -Recurse -Force
```

复制后，新会话中即可使用：

- `$financial-key-subjects`
- `$financial-lessee-due-diligence`

## 发布前检查

发布到 GitHub 前运行：

```powershell
.\scripts\check-sensitive-terms.ps1
.\scripts\validate-skills.ps1
```

如果检测到真实客户名称、审计报告、科目余额表、尽调成稿、合同、银行账户等敏感材料，不要提交。

## 隐私声明

本项目不包含真实客户数据、真实审计报告、真实科目余额表或真实尽调成稿。使用者应自行确保输入材料和输出报告符合所在机构的数据安全和保密要求。

建议第一版以 GitHub private repository 方式发布；确认所有模板和样例完全脱敏后，再考虑公开发布。
