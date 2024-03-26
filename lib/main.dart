import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/presentation/bloc/bloc/search_user_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/bloc_logics/post_logics_bloc.dart';
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
import 'package:tweel_social_media/presentation/bloc/theme/theme_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user/user_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user_sign_in/sign_in_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user_sign_up/sign_up_bloc.dart';
import 'package:tweel_social_media/presentation/cubit/drop_down/drop_down_cubit.dart';
import 'package:tweel_social_media/presentation/cubit/on_search/on_search_cubit.dart';
import 'package:tweel_social_media/presentation/cubit/set_profile_image/cubit/set_profile_image_cubit.dart';
import 'package:tweel_social_media/presentation/cubit/story_index/story_index_cubit.dart';
import 'package:tweel_social_media/presentation/pages/splash/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        BlocProvider(create: (context) => PostBloc()),
        BlocProvider(create: (context) => SavedPostsBloc()),
        BlocProvider(create: (context) => PostLogicsBloc()),
        BlocProvider(create: (context) => CommentBloc()),
        BlocProvider(create: (context) => LikeUnlikePostBloc()),
        BlocProvider(create: (context) => StoryBloc()),
        BlocProvider(create: (context) => MediaPickerBloc()),
        BlocProvider(create: (context) => StoryIndexCubit()),
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => UserByIdBloc()),
        BlocProvider(create: (context) => FollowUnfollowUserBloc()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => OnSearchCubit()),
        BlocProvider(create: (context) => SearchUserBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Tweel Social Media',
            theme: lightTheme,
            themeMode: ThemeMode.system,
            darkTheme: darkTheme,
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
