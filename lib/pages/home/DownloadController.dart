import 'package:flutter/material.dart';
import 'package:fluttertest/widgets/download_button.dart';


class DownloadController with ChangeNotifier  {
  DownloadController({
    DownloadStatus downloadStatus = DownloadStatus.notDownloaded,
    double progress = 0.0,
    required VoidCallback onOpenDownload,
  })  : _downloadStatus = downloadStatus,
        _progress = progress,
        _onOpenDownload = onOpenDownload;

  DownloadStatus _downloadStatus;

  DownloadStatus get downloadStatus => _downloadStatus;

  double _progress;

  final VoidCallback _onOpenDownload;

  bool _isDownloading = false;

  double get progress => _progress;

  void startDownload() {
    if (downloadStatus == DownloadStatus.notDownloaded) {
      _doDownload();
    }
  }

  void openDownload() {
    if (downloadStatus == DownloadStatus.downloaded) {
      _onOpenDownload();
    }
  }

  void stopDownload() {
    if (_isDownloading) {
      _isDownloading = false;
      _downloadStatus = DownloadStatus.notDownloaded;
      _progress = 0.0;
      notifyListeners();
    }
  }
  Future<void> _doDownload() async {
    _isDownloading = true;
    _downloadStatus = DownloadStatus.fetchingDownload;
    notifyListeners();

    // fetch耗时1秒钟
    await Future<void>.delayed(const Duration(seconds: 1));

    if (!_isDownloading) {
      return;
    }

    // 转换到下载的状态
    _downloadStatus = DownloadStatus.downloading;
    notifyListeners();

    const downloadProgressStops = [0.0, 0.05,0.1,0.3,0.4,0.45,0.8,0.9, 1.0];
    for (final progress in downloadProgressStops) {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (!_isDownloading) {
        return;
      }
      //更新progress
      _progress = progress;
      notifyListeners();
    }

    await Future<void>.delayed(const Duration(seconds: 1));
    if (!_isDownloading) {
      return;
    }
    //切换到下载完毕状态
    _downloadStatus = DownloadStatus.downloaded;
    _isDownloading = false;
    notifyListeners();
  }
}