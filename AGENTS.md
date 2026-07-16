# Project Continuity Kit — Agent Entry

开始任何工作前：

1. 先读根目录 [`PROJECT.md`](./PROJECT.md)。它是这个母包的当前事实入口。
2. 再只读与当前任务直接相关的模板、Skill、脚本或 `LESSONS.md`；不要为了接手重新扫描整个仓库。
3. 明确事项属于：`计划中`、`已实现/未验证` 或 `已验证`。

完成工作后：

1. 若改变了母包目标、模板结构、Skill 行为、安装接口、版本状态或经验库，执行 [`kit/skills/project-doc-sync/SKILL.md`](./kit/skills/project-doc-sync/SKILL.md)。
2. 先更新 `PROJECT.md`，再更新 README、模板、脚本和 `LESSONS.md` 中受影响的事实。
3. 不创建重复的状态页、第二份 handoff 或另一套模板说明。
4. 没有在真实项目中使用或验证时，不得把经验写成“已验证规律”。

硬边界：

- 母包必须保持项目无关，不写入任何具体项目的密钥、私密数据或用户目录。
- `kit/AGENTS.md` 必须保持短小，只作为入口和纪律，不承载完整架构。
- `kit/PROJECT.md` 是复制到新项目后的当前事实模板。
- `LESSONS.md` 只保存跨项目可复用、经过证据支持的经验。
- 安装脚本默认不得覆盖目标项目已有文件。
- 失败时只修已证实的问题，不顺手扩大模板体系。
