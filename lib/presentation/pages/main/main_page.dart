import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/presentation/cubit/connectivity_status/connectivity_status_cubit.dart';
import 'package:tweel_social_media/presentation/pages/explore/explore_page.dart';
import 'package:tweel_social_media/presentation/pages/home/home_page.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/home_page_loading.dart';
import 'package:tweel_social_media/presentation/pages/main/widgets/bottom_nav.dart';
import 'package:tweel_social_media/presentation/pages/message/message_page.dart';
import 'package:tweel_social_media/presentation/pages/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late ConnectivityStatusCubit connectivityStatusCubit;
  List<Widget> pages = [];

  @override
  void initState() {
    pages = const [
      HomePage(),
      ExplorePage(),
      MessagePage(),
      ProfilePage(),
    ];
    connectivityStatusCubit = context.read<ConnectivityStatusCubit>();
    connectivityStatusCubit.getConnectiviy(context);
    super.initState();
  }

  @override
  void dispose() {
    connectivityStatusCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: indexChangeNotifier.value != 0,
      onPopInvoked: (didPop) {
        indexChangeNotifier.value = 0;
        return;
      },
      child: Scaffold(
        body: BlocBuilder<ConnectivityStatusCubit, ConnectivityStatus>(
          builder: (context, state) {
            if (state == ConnectivityStatus.connected) {
              return ValueListenableBuilder(
                valueListenable: indexChangeNotifier,
                builder: (context, int index, child) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  return IndexedStack(
                    index: index,
                    children: pages,
                  );
                },
              );
            }
            return const HomePageLoading();
          },
        ),
        bottomNavigationBar: const BottomNavigationWidget(),
      ),
    );
  }
}
