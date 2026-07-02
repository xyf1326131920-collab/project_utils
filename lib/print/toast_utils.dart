import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

const Color _bgColor = Colors.black87;
const double _radius = 8.0;
const int _closeTime = 1500;
// 表示是否该分组内是否在同一时间里只存在一个Toast,区分是哪一个组是按照[groupKey]来区分的,默认false
const bool _onlyOne = true;
// 是否在点击屏幕触发事件时自动关闭该Toast,默认false
const bool _clickClose = false;
// 是否跨页面显示,如果为true,则该Toast会跨越多个Route显示,如果为false则在当前Route发生变化时,会自动关闭该Toast,默认true
// 注意，设置为false时，如果需要在全屏弹框回调中展示toast，可以添加100延时
const bool _crossPage = true;
// 点击穿透toast显示区域,为true可以穿透,默认false
const bool _ignoreContentClick = false;
// 是否在该Loading Toast显示时,能否正常点击触发事件,默认false
const bool _allowClickLoading = false;
// 是否允许该Loading跨页面显示,如果为true,则该Toast会跨越多个Route显示,如果为false则在当前Route发生变化时,会自动关闭该Toast,默认false
const bool _crossPageLoading = false;
// 点击物理返回键的行为(在android上等同于物理的返回键)
const BackButtonBehavior _backButtonBehavior = BackButtonBehavior.none;
// Toast显示位置,中间往上一点
const Alignment _alignment = Alignment(0.0, -0.2);

enum _ToastType {
  text,
  success,
  error,
  info,
  loading,
}

/// BotToast 通用参数说明
/// https://github.com/MMMzq/bot_toast/blob/master/API.md#通用参数说明
class ToastUtils {
  /// MaterialApp.builder，接入 BotToast
  static TransitionBuilder appBuilder([TransitionBuilder? builder]) {
    final botBuilder = BotToastInit();
    if (builder == null) {
      return botBuilder;
    }
    return (context, child) => botBuilder(context, builder(context, child));
  }

  /// MaterialApp.navigatorObservers，接入 BotToast
  static List<NavigatorObserver> navigatorObservers([
    List<NavigatorObserver>? observers,
  ]) {
    return [BotToastNavigatorObserver(), ...?observers];
  }

  /// 显示纯文本 Toast。
  static CancelFunc? showText(String? loadingText, {VoidCallback? onClose}) {
    if (loadingText == null || loadingText == '重复点击') {
      return null;
    }
    return _showToast(loadingText, _ToastType.text, onClose: onClose);
  }

  /// 显示成功 Toast（带勾选图标）。
  static CancelFunc? showSuccess(String? loadingText) {
    return _showToast(loadingText, _ToastType.success);
  }

  /// 显示错误 Toast（带错误图标）。
  static CancelFunc? showError(String? loadingText) {
    return _showToast(loadingText, _ToastType.error);
  }

  /// 显示信息 Toast（带信息图标）。
  static CancelFunc? showInfo(String? loadingText) {
    return _showToast(loadingText, _ToastType.info);
  }

  /// 显示加载中 Toast，默认文案为「加载中...」。
  static CancelFunc? showLoadingText([String loadingText = '加载中...']) {
    return _showLoading(loadingText);
  }

  /// 关闭所有 Loading Toast。
  static void hide() {
    BotToast.closeAllLoading();
  }
}

CancelFunc _showToast(loadingText, _ToastType toastType, {VoidCallback? onClose}) {
  return BotToast.showCustomText(
    duration: const Duration(milliseconds: _closeTime),
    align: _alignment,
    onlyOne: _onlyOne,
    clickClose: _clickClose,
    crossPage: _crossPage,
    ignoreContentClick: _ignoreContentClick,
    backButtonBehavior: _backButtonBehavior,
    backgroundColor: Colors.transparent,
    onClose: onClose,
    toastBuilder: (cancelFunc) => _showCustomToast(loadingText, toastType),
  );
}

CancelFunc _showLoading(loadingText) {
  return BotToast.showCustomLoading(
    align: _alignment,
    clickClose: _clickClose,
    allowClick: _allowClickLoading,
    crossPage: _crossPageLoading,
    ignoreContentClick: _ignoreContentClick,
    backButtonBehavior: _backButtonBehavior,
    backgroundColor: Colors.transparent,
    toastBuilder: (cancelFunc) => _showCustomToast(loadingText, _ToastType.loading),
  );
}

Widget _showCustomToast(loadingText, _ToastType toastType) {
  Container topWidget;
  if (toastType == _ToastType.text) {
    topWidget = Container();
  } else if (toastType == _ToastType.loading) {
    topWidget = Container(
      width: 40.0,
      height: 40.0,
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(4.0),
      child: const CircularProgressIndicator(
        strokeWidth: 3.0,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  } else {
    IconData? icon;
    if (toastType == _ToastType.success) {
      icon = Icons.check_circle_outline;
    }
    if (toastType == _ToastType.error) {
      icon = Icons.highlight_off;
    }
    if (toastType == _ToastType.info) {
      icon = Icons.info_outline;
    }
    topWidget = Container(
      width: 40.0,
      height: 40.0,
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(4.0),
      child: Icon(icon, size: 30, color: Colors.white),
    );
  }

  var w = Container(
    margin: const EdgeInsets.all(50.0),
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    decoration: BoxDecoration(color: _bgColor, borderRadius: BorderRadius.circular(_radius)),
    child: ClipRect(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Visibility(
            visible: toastType != _ToastType.text,
            child: topWidget,
          ),
          Text(loadingText, style: const TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center),
        ],
      ),
    ),
  );
  return w;
}
