# project_utils

Flutter 项目常用工具库，提供跨平台能力封装、Toast 提示与页面状态保持等实用组件。

## 功能特性

- **平台信息**：通过 Method Channel 获取当前运行平台的系统版本
- **Toast 提示**：基于 [bot_toast](https://pub.dev/packages/bot_toast) 封装的统一 Toast / Loading 组件
- **状态保持**：`KeepAliveWrapper` 用于在 `TabBarView`、`PageView` 等可滚动容器中保持子页面状态

## 支持平台

| 平台    | 支持 |
| ------- | ---- |
| Android | ✅   |
| iOS     | ✅   |
| Web     | ✅   |
| Windows | ✅   |
| macOS   | ✅   |
| Linux   | ✅   |

## 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  project_utils: ^0.0.1
```

或从 Git 安装：

```yaml
dependencies:
  project_utils:
    git:
      url: https://github.com/xyf1326131920-collab/project_utils.git
```

或使用本地路径：

```yaml
dependencies:
  project_utils:
    path: ../project_utils
```

然后执行：

```bash
flutter pub get
```

## 使用说明

### ToastUtils

使用前需在 `MaterialApp` 中接入 BotToast：

```dart
import 'package:project_utils/project_utils.dart';

MaterialApp(
  builder: ToastUtils.appBuilder(),
  navigatorObservers: ToastUtils.navigatorObservers(),
  home: MyHomePage(),
)
```

若已有自定义 `builder` 或 `navigatorObservers`，可传入原有配置进行合并：

```dart
MaterialApp(
  builder: ToastUtils.appBuilder(myBuilder),
  navigatorObservers: ToastUtils.navigatorObservers(myObservers),
  home: MyHomePage(),
)
```

#### API

| 方法 | 说明 |
| ---- | ---- |
| `ToastUtils.showText(text, {onClose})` | 纯文本提示，支持关闭回调 |
| `ToastUtils.showSuccess(text)` | 成功提示（带勾选图标） |
| `ToastUtils.showError(text)` | 错误提示（带错误图标） |
| `ToastUtils.showInfo(text)` | 信息提示（带信息图标） |
| `ToastUtils.showLoadingText([text])` | 加载中提示，默认文案为「加载中...」 |
| `ToastUtils.hide()` | 关闭所有 Loading 提示 |

```dart
// 文本提示
ToastUtils.showText('操作成功');

// 带关闭回调
ToastUtils.showText('保存完成', onClose: () => refreshData());

// 加载提示
ToastUtils.showLoadingText('请稍候...');

// 关闭 Loading
ToastUtils.hide();

// 状态提示
ToastUtils.showSuccess('提交成功');
ToastUtils.showError('网络异常');
ToastUtils.showInfo('请先登录');
```

> **提示**：若在全屏弹框的回调中展示 Toast，可将 `crossPage` 设为 `false` 并添加约 100ms 延时，以避免 Toast 被立即关闭。

### KeepAliveWrapper

在 `TabBarView` 或 `ListView` 中包裹子组件，避免切换时状态被销毁：

```dart
import 'package:project_utils/project_utils.dart';

TabBarView(
  children: [
    KeepAliveWrapper(child: FirstPage()),
    KeepAliveWrapper(child: SecondPage()),
  ],
)
```

通过 `keepAlive` 参数可动态控制是否保持状态，默认为 `true`：

```dart
KeepAliveWrapper(
  keepAlive: shouldKeepAlive,
  child: MyPage(),
)
```

### ProjectUtils

获取当前平台的系统版本：

```dart
import 'package:project_utils/project_utils.dart';

final projectUtils = ProjectUtils();
final version = await projectUtils.getPlatformVersion();
// 例如：Android 14、iOS 17.0 等
```

## 示例

运行 example 项目查看完整演示：

```bash
cd example
flutter run
```

## 依赖

- [bot_toast](https://pub.dev/packages/bot_toast) ^4.1.3
- [plugin_platform_interface](https://pub.dev/packages/plugin_platform_interface) ^2.0.2

## 许可证

[MIT](LICENSE)
