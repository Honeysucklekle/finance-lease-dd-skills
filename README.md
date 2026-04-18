# 融资租赁承租人财务尽调技能包

本仓库提供一组面向融资租赁承租人财务尽调场景的 Codex Skills、说明文档和校验脚本，用于在脱敏或合成数据环境下复现重点科目分析、偿债能力分析与报告撰写流程。

项目聚焦可复用的方法、规则和文档结构，不包含真实客户资料、真实尽调成稿或原始财务底稿。

## 能力概览

- 基于审计报告、科目余额表或半年报、结构化财务信息工作簿，组织承租人财务尽调输入材料。
- 按资产总额 `5%`、负债及权益总额 `3%` 阈值筛选重点科目，并整理科目明细与必要的补充披露。
- 围绕资产负债结构、经营现金流、债务期限结构和偿债能力形成分析框架。
- 按固定模板和样式约束生成中文财务尽调报告，并保留重点科目分析与格式复核要求。
- 提供脱敏检查、技能结构校验和打包脚本，便于复用、演示和二次分发。

## 包含技能

- `financial-key-subjects`：生成或复核重点科目底稿，按资产占比 `5%`、负债及权益占比 `3%` 筛选重点科目，整理二级明细、往来前五大和报表调整/重分类口径。
- `financial-lessee-due-diligence`：根据重点科目底稿、财务信息工作簿、审计报告和尽调模板，撰写、排版和复核承租人财务尽调报告。

## 仓库结构

```text
skills/      技能正文与 agent 配置
docs/        工作流说明、格式规则、脱敏与自查清单
templates/   模板占位与使用说明
examples/    合成样例目录与示例输出结构
scripts/     校验、检查与打包脚本
tests/       仓库校验说明与本地扩展词表模板
```

## 推荐工作流

1. 准备三年审计报告、最新一期科目余额表或半年报、结构化财务信息工作簿。
2. 使用 `financial-key-subjects` 生成或复核 `重要科目` sheet。
3. 依据重点科目清单组织主要科目分析，并结合租赁场景关注资产质量、现金流和偿债能力。
4. 使用 `financial-lessee-due-diligence` 复制模板、套用样式并生成正式报告。
5. 结合格式规则、自查清单和仓库校验脚本完成复核。

## 快速开始

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

## 文档索引

- [工作流程](docs/workflow.md)
- [数据材料要求](docs/data-requirements.md)
- [重点科目规则](docs/key-subject-rules.md)
- [报告格式规则](docs/report-format-rules.md)
- [交付自查清单](docs/qa-checklist.md)
- [脱敏指南](docs/redaction-guide.md)
- [安全与保密](SECURITY.md)

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
