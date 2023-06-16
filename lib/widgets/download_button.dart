import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
enum DownloadStatus {
  notDownloaded,
  fetchingDownload,
  downloading,
  downloaded,
}
class DownloadButton extends StatelessWidget {
  const DownloadButton(
      {Key? key,
      required this.status,
      this.shapeWidth = 60,
      this.downloadProgress = 0.0,
      required this.onDownload,
      required this.onOpen,
      required this.onCancel,
      this.transitionDuration = const Duration(milliseconds: 500)})
      : super(key: key);
  // 按钮宽度
  final double shapeWidth;

  // 状态
  final DownloadStatus status;

  // 下载进度
  final double downloadProgress;

  // 点击打开回调
  final VoidCallback onOpen;

  // 点击下载回调
  final VoidCallback onDownload;

  // 点击取消回调
  final VoidCallback onCancel;

  // 时长
  final Duration transitionDuration;

  bool get isDownloading => status == DownloadStatus.downloading;

  bool get isFetching => status == DownloadStatus.fetchingDownload;

  bool get isDownloaded => status == DownloadStatus.downloaded;

  void onPress() {
    switch (status) {
      case DownloadStatus.notDownloaded:
        onDownload();
        break;
      case DownloadStatus.fetchingDownload:
        break;
      case DownloadStatus.downloading:
        onCancel();
        break;
      case DownloadStatus.downloaded:
        onOpen();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Stack(
        children: [
          ButtonShapeWidget(
              shapeWidth: shapeWidth,
              isDownloading: isDownloading,
              isDownloaded: isDownloaded,
              isFetching: isFetching,
              transitionDuration: transitionDuration),
          Positioned.fill(
              child: AnimatedOpacity(
            opacity: isDownloading || isFetching ? 1.0 : 0.0,
            duration: transitionDuration,
            curve: Curves.ease,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ProgressIndicatorWidget(
                    downloadProgress: downloadProgress,
                    isDownloading: isDownloading,
                    isFetching: isFetching),
                if (isDownloading)
                  const Icon(
                    Icons.stop,
                    size: 14,
                    color: CupertinoColors.activeBlue,
                  )
              ],
            ),
          ))
        ],
      ),
    );
  }
}

/// 按钮外形 控件
class ButtonShapeWidget extends StatelessWidget {
  const ButtonShapeWidget(
      {Key? key,
      required this.shapeWidth,
      required this.isDownloading,
      required this.isDownloaded,
      required this.isFetching,
      required this.transitionDuration})
      : super(key: key);

  final double shapeWidth;
  final bool isDownloading;
  final bool isDownloaded;
  final bool isFetching;
  final Duration transitionDuration;

  @override
  Widget build(BuildContext context) {
    var shape = const ShapeDecoration(
        shape: StadiumBorder(), color: CupertinoColors.lightBackgroundGray);

    if (isFetching || isDownloading) {
      shape = ShapeDecoration(
          shape: const CircleBorder(), color: Colors.white.withOpacity(0));
    }

    return AnimatedContainer(
      duration: transitionDuration,
      curve: Curves.ease,
      width: shapeWidth,
      decoration: shape,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: AnimatedOpacity(
          duration: transitionDuration,
          opacity: isDownloading || isFetching ? 0.0 : 1.0,
          curve: Curves.ease,
          child: Text(
            isDownloaded ? "OPEN" : "GET",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.button?.copyWith(
                fontWeight: FontWeight.bold, color: CupertinoColors.activeBlue),
          ),
        ),
      ),
    );
  }
}

/// 进度 控件
class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget(
      {Key? key,
      required this.downloadProgress,
      required this.isDownloading,
      required this.isFetching})
      : super(key: key);
  final double downloadProgress;
  final bool isDownloading;
  final bool isFetching;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: downloadProgress),
          duration: const Duration(milliseconds: 200),
          builder: (context, progress, child) {
            return CircularProgressIndicator(
              backgroundColor: isDownloading
                  ? CupertinoColors.lightBackgroundGray
                  : Colors.white.withOpacity(0),
              valueColor: AlwaysStoppedAnimation(isFetching
                  ? CupertinoColors.lightBackgroundGray
                  : CupertinoColors.activeBlue),
              strokeWidth: 2,
              value: isFetching ? null : progress,
            );
          },
        ));
  }
}
