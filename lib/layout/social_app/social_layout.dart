import 'package:firstgp/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../globals/globalVariables.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          CacheHelper.init();
          uId = CacheHelper.getData(key: 'uId');
          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text(cubit.titles[cubit.currentIndex],style: const TextStyle(color: Colors.white)),
            ),
            body:
                SingleChildScrollView(child: cubit.screens[cubit.currentIndex]),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.green,
              currentIndex: cubit.currentIndex,
              onTap: (int index) {
                cubit.ChangeBottomNav(index);
              },
              items: [
                const BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Home,
                      color: Colors.white,
                    ),
                    label: 'Home',
                ),
                const BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Chat,
                        color: Colors.white,
                    ),
                    label: 'Chats'),
                !isDoctor
                    ? const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.how_to_reg_sharp,
                        color: Colors.white,
                    ),
                    label: 'Doctors')
                    : const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.playlist_add_circle_outlined,
                        color: Colors.white,
                    ),
                    label: 'Patients'),
                const BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Setting,
                        color: Colors.white,
                    ),
                    label: 'Settings'),
              ],
              fixedColor: Colors.white,
              unselectedItemColor: Colors.white,
            ),
          );
        });
  }
}
