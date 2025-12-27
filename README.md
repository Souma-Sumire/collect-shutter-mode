# 尼康 RAW 元数据提取工具 (Shutter Mode)

## 项目简介
本项目是一个基于 `ExifTool` 的自动化工具，专门用于批量提取尼康 `.NEF` 文件的元数据。其核心功能是识别“快门模式”（如机械快门、电子前帘快门等），并结合曝光参数和镜头信息导出为 CSV 报表，方便后续进行摄影习惯分析或相机行为验证。

## 目录结构
- **`RAW/`**: 放置需要扫描的 `.NEF` 格式原始照片。
- **`bin/`** (隐藏): 存放 `ExifTool` 核心二进制文件及相关 Perl 依赖库。
- **`collect_shutter_mode.bat`**: 一键执行脚本，双击即可开始处理。
- **`shutter_info.csv`**: 自动生成的分析结果文件。

## 提取数据项
脚本会自动提取并整理以下字段：
1. **FileName**: 文件名
2. **Lens**: 镜头详细型号
3. **FocalLength**: 当前拍摄焦距
4. **ShutterMode**: **快门模式** (Mechanical / Electronic Front Curtain / Electronic 等)
5. **ShutterSpeedDec**: 快门速度（秒，十进制）
6. **ShutterSpeedFrac**: 快门速度（秒，分数形式，如 1/4000）
7. **FNumber**: 使用的光圈值
8. **ISO**: 感光度设置
9. **VR**: 减震/防抖开启状态
10. **FocusMode**: 使用的对焦模式

## 使用流程
1. 将照片拷贝至 `RAW` 文件夹。
2. 双击运行 `collect_shutter_mode.bat`。
3. 命令行界面会显示当前进度条。
4. 完成后，使用 Excel 或任何文本编辑器打开 `shutter_info.csv` 查看数据。

## 技术备注
- 本工具使用了 ExifTool 13.45。
- 脚本通过 `-p` 格式化参数确保了快门速度同时以十进制和分数形式输出，满足不同的分析需求。
- 已对核心组件进行隐藏处理，保持项目根目录整洁并防止误删风险。

---
*Powered by Antigravity*
