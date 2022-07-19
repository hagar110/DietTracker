import 'package:firstgp/globals/globalVariables.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import 'package:firstgp/modules/social_app/edit_profile/scan_inbody_screen.dart';
import 'package:firstgp/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/styles/icon_broken.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var priceController = TextEditingController();
  var clinicPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialUserUpdateSuccessState) {
          showToast(
            text: 'Updated',
            state: ToastStates.SUCCESS,
          );
        }
      },
      builder: (context, state) {
        if (isDoctor) {
          nameController.text = currentdoctor.username;
          clinicPhoneController.text = currentdoctor.cliniquePhone;
          priceController.text = currentdoctor.price.toString();
        } else {
          nameController.text = currentpatient.username;
          ageController.text = currentpatient.Age.toString();
        }
        var profileImage = SocialCubit.get(context).profileImage;
        return Scaffold(
          appBar: defaultAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                function: () {
                  if (SocialCubit.get(context).profileImage == null) {
                    if (isDoctor) {
                      SocialCubit.get(context).updateUserProfile(
                        name: nameController.text,
                        age: 0,
                        clinicPhone: clinicPhoneController.text,
                        price: num.parse(priceController.text),
                      );
                    } else {
                      SocialCubit.get(context).updateUserProfile(
                        name: nameController.text,
                        age: int.parse(ageController.text),
                        clinicPhone: '',
                        price: 0,
                      );
                    }
                  } else {
                    if (isDoctor) {
                      SocialCubit.get(context).uploadProfileImage(
                        name: nameController.text,
                        age: 0,
                        clinicPhone: clinicPhoneController.text,
                        price: num.parse(priceController.text),
                      );
                    } else {
                      SocialCubit.get(context).uploadProfileImage(
                        name: nameController.text,
                        age: int.parse(ageController.text),
                        clinicPhone: '',
                        price: 0,
                      );
                    }
                  }
                  setState(() {});
                },
                text: 'Update',
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  if (state is SocialGetUserLoadingState ||
                      state is SocialUserUpdateLoadingState)
                    const SizedBox(
                      height: 10.0,
                    ),
                  if (state is SocialGetUserLoadingState ||
                      state is SocialUserUpdateLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialGetUserLoadingState ||
                      state is SocialUserUpdateLoadingState)
                    const SizedBox(
                      height: 10.0,
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CircleAvatar(
                        radius: 62,
                        backgroundColor: Colors.green[100],
                        child: CircleAvatar(
                          radius: 60.0,
        backgroundColor: Colors.green[100],
                          backgroundImage: profileImage == null
                              ? NetworkImage(currentuser.image)
                              : (FileImage(profileImage)) as ImageProvider,
                        ),
                      ),
                      IconButton(
                        icon:  CircleAvatar(
                            radius: 20.0,
                           backgroundColor: Colors.green[100],
                           child: const Icon(IconBroken.Camera)),
                        onPressed: () {
                          SocialCubit.get(context).getProfileImage();
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Name can not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: IconBroken.User,
                  ),

                  const SizedBox(
                    height: 20.0,
                  ),
                  if (isDoctor)
                    defaultFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      label: ' Enter your Price',
                      prefix: IconBroken.Paper,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Price can not be empty';
                        }
                        return null;
                      },
                    )
                  else
                    defaultFormField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      label: ' Enter your age',
                      prefix: IconBroken.User,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Age can not be empty';
                        }
                        return null;
                      },
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (!isDoctor)
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScanInbodyScreen()),
                              ).then((value) => setState(() {}));
                            },
                            child: const Text('Scan InBody'),
                          ),
                        )
                      ],
                    )
                  else defaultFormField(
                    controller: clinicPhoneController,
                    keyboardType: TextInputType.phone,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Clinic Phone can not be empty';
                      }
                      return null;
                    },
                    label: 'Clinic Phone',
                    prefix: IconBroken.Call,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
