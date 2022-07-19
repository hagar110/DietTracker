

import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:firstgp/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../globals/globalFunctions.dart';
import '../../../layout/social_app/cubit/cubit.dart';
import '../../../screens/loginandregister.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();

}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(
          height: 10.0,
        ),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Row(
           children: [
             CircleAvatar(
               radius: 57,
               backgroundColor: Colors.green[100],
               child: CircleAvatar(
                 radius: 55.0,
                   backgroundColor: Colors.green[100],
                 backgroundImage: NetworkImage(currentuser.image),
               ),
             ),
            const SizedBox(
               width: 5.0,
             ),
             Padding(
               padding: const EdgeInsets.only(bottom: 50.0),
               child: Text(

                 isDoctor?currentdoctor.username:currentpatient.username,
                 style: TextStyle(
                     fontSize: 20.0,
                     fontWeight: FontWeight.bold,
                     color: Colors.grey[600]
                 ),
               ),
             ),
           ],
         ),
       ),
        const SizedBox(
          height: 3.0,
        ),
        Container(
          height: 1.0,
          width: double.infinity,
          color: Colors.green,
        ),
        const SizedBox(
          height: 50.0,
        ),
      if(!isDoctor)    Row(
          children:  [
            const Text(
              '  Weight:  ',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                  ,color: Colors.green
              ),
            ),
            Text(
              currentInbody.weight.toString()+ ' Kg',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
          ],
        ),

        if(!isDoctor)   const SizedBox(
          height: 10.0,
        ),
        if(!isDoctor)  Row(
          children:  [
            const Text(
              '  Height:  ',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                  ,color: Colors.green
              ),
            ),
            Text(
              currentInbody.height!.round().toString()+ ' Cm',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
          ],
        ),


        if (!isDoctor)const SizedBox(
          height: 10.0,
        ),
        if(!isDoctor)     Row(
          children:  [
            const Text(
              '  Case:     ',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                  ,color: Colors.green
              ),
            ),
            Text(
              currentpatient.Case,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),

          ],
        )
        else Row(
          children:  [
            const Text(
              '  Price:     ',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                  ,color: Colors.green
              ),
            ),
            Text(
              currentdoctor.price.toString()+ " L.E.",
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),

          ],
        ),

        const SizedBox(
          height: 10.0,
        ),
        if(!isDoctor)   Row(
          children:  [
            const Text(
              '  Age:     ',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                  ,color: Colors.green
              ),
            ),
            Text(

              currentpatient.Age.toString(),
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),

          ],
        )
        else Row(
          children:  [
            const Text(
              '  Clinic phone: ',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                  ,color: Colors.green
              ),
            ),
            Text(
              currentdoctor.cliniquePhone,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),

          ],
        ),
        const SizedBox(
          height: 10.0,
        ),///Height

        Row(
          children:  [
            const Text(
              '  Email:    ',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                  ,color: Colors.green
              ),
            ),
            Text(
              isDoctor?currentdoctor.email:currentpatient.email,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ), //Email
        const SizedBox(
          height: 100.0,
        ),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(

                onPressed: (){

                  Navigator.push( context, MaterialPageRoute( builder: (context) => EditProfileScreen()), ).then((value) => setState(() {}));
                },
                child: const Text('Edit Profile'),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: (){
                  SocialCubit.get(context).currentIndex=0;
                  setAllToLogout();
                  setAllMealsToZero();
                 navigateAndFinish(
                    context,
                    LoginScreen(),
                  );
                  },
                child: const Text('Log Out'),
              ),
            )
          ],
        ),
      ],
    );
  }
}
