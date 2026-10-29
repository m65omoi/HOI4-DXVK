# HOI4-DXVK: Hearts of Iron IV Vulkan Rendering Optimization

[![Game: Hearts of Iron IV](https://img.shields.io/badge/Game-Hearts_of_Iron_IV-blue.svg)](https://store.steampowered.com/app/394360/Hearts_of_Iron_IV/)
[![Graphics: Vulkan](https://img.shields.io/badge/Graphics-Vulkan_1.3-red.svg)](https://www.vulkan.org/)
[![License: Zlib](https://img.shields.io/badge/License-Zlib-green.svg)](https://github.com/doitsujin/dxvk/blob/master/LICENSE)

A drop-in **DXVK (DirectX 11 to Vulkan)** proxy mod and optimization suite specifically configured for **Hearts of Iron IV (Clausewitz Engine)**.

---

## 🌟 核心特性 (Features)

- **显著降低 CPU 驱动层开销**：将原版极其繁琐的 Direct3D 11 Draw Call 转化为高并发 Vulkan 命令列表，减轻渲染线程对 CPU 单核的抢占。
- **消除地图平移/缩放卡顿**：开启 Vulkan `Graphics Pipeline Library (GPL)`，后台异步编译着色器管线。
- **更平滑的前线微操**：针对师番号图标与地块网格开启 `cachedDynamicBuffers`，降低操作输入延迟。
- **100% 安全且零破坏**：
  - **不修改任何原版游戏二进制与数据文件**（利用 Windows DLL 优先搜索机制免侵入加载）。
  - **完全兼容铁人模式成就与多人联机**（不改变校验码 Checksum）。
  - **一键安装与一键卸载**。

---

## 🔬 逆向工程背景 (Technical Background)

经由 **REA (Reverse Engineer Anything)** 逆向分析工具对 `hoi4.exe` 的深度静态分析显示：

1. **引擎接口接入方式**：
   HOI4 渲染后端定义在 `clausewitz\pdx_gfx\gfx_dx11.cpp` 中。导入表表明游戏仅调用了 `d3d11.dll` 中的 `D3D11CreateDevice` 和 `dxgi.dll` 中的 `CreateDXGIFactory1/2`，并在此基础上构建 `gMasterContext` 即时渲染上下文。
2. **瓶颈成因**：
   全地图有数千个省份轮廓、师图标牌、补给虚线等高频动态图元。在原生 D3D11 驱动层下，状态切换与常量缓冲更新极大增加了 CPU 驱动层负担，导致与游戏逻辑 Tick 争抢 CPU 单核算力。
3. **DXVK 介入点**：
   通过在游戏同级目录放置 `d3d11.dll` 与 `dxgi.dll` 代理，拦截 `D3D11CreateDevice` 并转换为 Vulkan 1.3 渲染管线。

---

## 🚀 快速安装 (Quick Installation)

### 方法一：使用一键安装脚本（推荐）
1. 将本仓库下载并解压到任意位置（或直接放入 HOI4 安装根目录）。
2. 双击运行 `install.bat`，脚本将自动复制所需文件到 `hoi4.exe` 同级目录。
3. 通过 Steam 或 Paradox Launcher 正常启动游戏。

### 方法二：手动安装
1. 将本文件夹中的以下三个文件直接复制到《钢铁雄心 IV》安装根目录（即包含 `hoi4.exe` 的目录）：
   - `d3d11.dll`
   - `dxgi.dll`
   - `dxvk.conf`
2. 启动游戏。若屏幕左上角显示 DXVK HUD 状态栏（帧率、Vulkan 版本），则表示已成功接入。

---

## ⚙️ 配置文件说明 (`dxvk.conf`)

`dxvk.conf` 专为 Clausewitz 引擎调优：

```ini
# 1. 屏幕左上角 HUD 状态监测（显示实时帧率、GPU负载、显存使用及Vulkan版本）
#    验证生效后，如需隐藏界面，可将此项改为：dxvk.hud = 0
dxvk.hud = fps,memory,gpuload,version

# 2. 启用 Vulkan 图形管线库（GPL），消除平移/缩放地图时的着色器编译微卡顿
dxvk.enableGraphicsPipelineLibrary = True

# 3. 动态缓冲区缓存（针对 P 社引擎频繁刷新的地块轮廓与前线编制图标深度优化）
d3d11.cachedDynamicBuffers = True

# 4. 后台缓冲区最大容忍延迟（降低操作输入延迟与鼠标拖拽感）
d3d11.maxTolerantBackBufferLatency = 1

# 5. 垂直同步开关（0 = 关, 1 = 开）
dxgi.syncInterval = 1
```

---

## 🗑️ 一键卸载 (Uninstallation)

运行 `uninstall.bat`，或手动在 HOI4 根目录下删除以下文件即可无损恢复官方原生 DX11：
- `d3d11.dll`
- `dxgi.dll`
- `dxvk.conf`
- `hoi4.dxvk-cache`（如有生成）
- `hoi4_d3d11.log` / `hoi4_dxgi.log`

---

## 📜 许可证 (License)

本模组配置与安装套件开源发布。内置的 DXVK 动态库遵循其原始的 [Zlib License](https://github.com/doitsujin/dxvk/blob/master/LICENSE)。
《钢铁雄心 IV》（Hearts of Iron IV）及 Clausewitz Engine 版权归 Paradox Interactive 所有。
