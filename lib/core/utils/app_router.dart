import 'dart:io';


import 'package:file_picker/file_picker.dart';

import 'package:go_router/go_router.dart';

import '../../features/chat/presentation/views/chat_views.dart';
import '../../features/chat/presentation/views/widget/show_file_and_send.dart';
import '../../features/chat/presentation/views/widget/show_image.dart';
import '../../features/chat/presentation/views/widget/show_image_and_send.dart';
import '../../features/chat/presentation/views/widget/show_multy_image.dart';
import '../../features/chat/presentation/views/widget/video_player.dart';
import '../../features/login/presentation/views/login_view.dart';
import '../../features/login/presentation/views/register.dart';


abstract class AppRouts {
  static const kRegisterView = '/registerView';
  static const kChatView = '/ChatView';
  static const kVideoPlayer = '/VideoPlayer';

  static const kLogin = "/";

  static const kShowFileBeforeSend = '/ShowFileBeforeSend';
  static const kShowImage = '/ShowImage';

  static const kMediaSelection = '/MediaSelection';
  static const kShowImageandSend = '/ShowImageandSend';

  static final router = GoRouter(routes: [
GoRoute(
  path: kLogin,
  builder: (context, state) {

      return const LoginViews();
    
  },
),

    GoRoute(
      path: kRegisterView,
      builder: (context, state) => const RegisterViews(),
    ),
    GoRoute(
      path: kChatView,
      builder: (context, state) {
       
        return ChatView(
           state.extra as String,
        );
      },
    ),
    GoRoute(
      path: kShowFileBeforeSend,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;

        return ShowFileBeforeSend(
          pickedFile: data['file'] as PlatformFile,
          email: data['email'] as String,
        );
      },
    ),
    GoRoute(
      path: kShowImage,
      builder: (context, state) {
        final data = state.extra as String;
        return ShowImage(
          message: data,
        );
      },
    ),
    GoRoute(
      path: kMediaSelection,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return ShowMultyImage(
          file: data['imageFile'] as List<File>,
          email: data['email'] as String,
        );
      },
    ),
    GoRoute(
      path: kVideoPlayer,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;

        return VideoView(
          local: data['isFile'] as bool,
          videoUrl: data['message'] as String,
        );
      },
    ),
    GoRoute(
      path: kShowImageandSend,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return ShowImageAndSend(
          email: data['email'] as String,
          imageFromGallery: data['imageFile'] as File,
        );
      },
    ),
  ]);
}
