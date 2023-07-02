// import 'package:better_player/better_player.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoReviewController extends GetxController {
  // late final BetterPlayerController _betterPlayerController;
  late final YoutubePlayerController _youtubePlayerController;

  @override
  void onInit() {
    super.onInit();

    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(Get.arguments["data"]) ?? "",
    );

    // _setupVideoPlayer();
  }

  // void _setupVideoPlayer() async {
  //   _betterPlayerController = BetterPlayerController(
  //     const BetterPlayerConfiguration(
  //       controlsConfiguration: BetterPlayerControlsConfiguration(
  //         enableProgressText: true,
  //         enablePlaybackSpeed: true,
  //         enableSubtitles: false,
  //         enableQualities: false,
  //         enableAudioTracks: false,
  //         enableFullscreen: false,
  //         enableMute: false,
  //         enablePip: false,
  //         enableOverflowMenu: false,
  //         enablePlayPause: true,
  //         enableProgressBar: true,
  //         enableProgressBarDrag: true,
  //         enableSkips: false,
  //         showControlsOnInitialize: false,
  //         enableRetry: true,
  //         showControls: true,
  //       ),
  //       looping: false,
  //       autoPlay: true,
  //       allowedScreenSleep: false,
  //       autoDispose: true,
  //     ),
  //     betterPlayerDataSource: BetterPlayerDataSource.network(
  //       Get.arguments["data"],
  //     ),
  //   );

  //   _setBetterPlayerListener();
  // }

  // Future<void> _setBetterPlayerListener() async {
  //   _betterPlayerController.addEventsListener((event) {
  //     switch (event.betterPlayerEventType) {
  //       case BetterPlayerEventType.initialized:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.play:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.pause:
  //         break;
  //       case BetterPlayerEventType.seekTo:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.openFullscreen:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.hideFullscreen:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.setVolume:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.progress:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.finished:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.exception:
  //         Utils.showToast("There was a problem playing this reel!");
  //         break;
  //       case BetterPlayerEventType.controlsVisible:
  //         // TODO: Handle this case.
  //         break;

  //       case BetterPlayerEventType.setSpeed:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.changedSubtitles:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.changedTrack:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.changedPlayerVisibility:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.changedResolution:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.pipStart:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.pipStop:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.setupDataSource:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.bufferingStart:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.bufferingUpdate:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.bufferingEnd:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.changedPlaylistItem:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.controlsHiddenStart:
  //         // TODO: Handle this case.
  //         break;
  //       case BetterPlayerEventType.controlsHiddenEnd:
  //         // TODO: Handle this case.
  //         break;
  //     }
  //   });
  // }

  // BetterPlayerController get betterPlayerController => _betterPlayerController;
  YoutubePlayerController get youtubePlayerController =>
      _youtubePlayerController;

  @override
  void onClose() {
    // _betterPlayerController.dispose();
    _youtubePlayerController.dispose();
    super.onClose();
  }
}
