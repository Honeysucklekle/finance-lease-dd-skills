# 融资租赁承租人财务尽调技能包

本仓库提供一组面向融资租赁承租人财务尽调场景的 Codex Skills、说明文档和校验脚本，用于在脱敏或合成数据环境下复现重点科目分析与报告撰写流程。

项目聚焦可复用的方法、规则和文档结构，不包含真实客户资料、真实尽调成稿或原始财务底稿。

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

## 仓库校验

在提交、分发或二次发布仓库前，可运行：

```powershell
.\scripts\check-sensitive-terms.ps1
.\scripts\validate-skills.ps1
```

如果脚本提示存在敏感命名或文件，建议先完成脱敏、替换为合成样例，或将相关材料保留在仓库之外。

## 数据与合规说明

本仓库仅面向工作流、模板说明和示例结构，不承载真实业务资料。使用者在复用本项目时，应根据所在机构的数据安全、保密和合规要求，自行处理输入材料、样例数据与导出结果。

如需公开 fork、二次分发或用于演示，建议仅保留脱敏模板、合成样例和说明文档。
