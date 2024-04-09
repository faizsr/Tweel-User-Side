import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/presentation/bloc/notification/notification_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/post_by_id/post_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/post_edit/post_edit_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile_logics/profile_logics_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/report/report_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/search_user/search_user_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/post_logics/post_logics_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/comment/comment_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/follow_unfollow_user/follow_unfollow_user_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/forget_password/forget_password_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/like_unlike_post/like_unlike_post_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/media_picker/media_picker_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/saved_posts/saved_posts_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/search_follower/search_follower_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/story/story_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user/user_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user_sign_in/sign_in_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user_sign_up/sign_up_bloc.dart';
import 'package:tweel_social_media/presentation/cubit/drop_down/drop_down_cubit.dart';
import 'package:tweel_social_media/presentation/cubit/on_search/on_search_cubit.dart';
import 'package:tweel_social_media/presentation/cubit/post_image_index.dart/post_image_index.dart';
import 'package:tweel_social_media/presentation/cubit/report_radio/report_radio_cubit.dart';
import 'package:tweel_social_media/presentation/cubit/set_profile_image/cubit/set_profile_image_cubit.dart';
import 'package:tweel_social_media/presentation/cubit/story_index/story_index_cubit.dart';
import 'package:tweel_social_media/presentation/cubit/theme/theme_cubit.dart';
import 'package:tweel_social_media/presentation/cubit/toggle_notify_cubit/toggle_notify_cubit.dart';
import 'package:tweel_social_media/presentation/cubit/toggle_password/toggle_password_cubit.dart';
import 'package:tweel_social_media/presentation/pages/splash/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpBloc()),
        BlocProvider(create: (context) => SignInBloc()),
        BlocProvider(create: (context) => DropdownCubit()),
        BlocProvider(create: (context) => SetProfileImageCubit()),
        BlocProvider(create: (context) => ForgetPasswordBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => ProfileLogicsBloc()),
        BlocProvider(create: (context) => PostEditBloc()),
        BlocProvider(create: (context) => PostBloc()),
        BlocProvider(create: (context) => PostByIdBloc()),
        BlocProvider(create: (context) => SavedPostsBloc()),
        BlocProvider(create: (context) => PostLogicsBloc()),
        BlocProvider(create: (context) => CommentBloc()),
        BlocProvider(create: (context) => LikeUnlikePostBloc()),
        BlocProvider(create: (context) => StoryBloc()),
        BlocProvider(create: (context) => MediaPickerBloc()),
        BlocProvider(create: (context) => StoryIndexCubit()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => UserByIdBloc()),
        BlocProvider(create: (context) => FollowUnfollowUserBloc()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => OnSearchCubit()),
        BlocProvider(create: (context) => PostImageIndexCubit()),
        BlocProvider(create: (context) => SearchUserBloc()),
        BlocProvider(create: (context) => NotificationBloc()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => ToggleNotifyCubit()),
        BlocProvider(create: (context) => TogglePasswordCubit()),
        BlocProvider(create: (context) => ReportRadioCubit()),
        BlocProvider(create: (context) => ReportBloc()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, ThemeMode mode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Tweel Social Media',
            theme: lightTheme,
            themeMode: mode,
            darkTheme: darkTheme,
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
