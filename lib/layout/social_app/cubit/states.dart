abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialVerifyUserEmailState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates
{
  final String error;
  SocialGetUserErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends SocialStates{}

class SocialGetAllUsersSuccessState extends SocialStates{}

class SocialGetAllUsersErrorState extends SocialStates
{
  final String error;
  SocialGetAllUsersErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates{}

class SocialProfileImagePickedSuccessState extends SocialStates{}

class SocialProfileImagePickedErrorState extends SocialStates{}


class SocialUploadProfileImageSuccessState extends SocialStates{}

class SocialUploadProfileImageErrorState extends SocialStates{}


class SocialUserUpdateLoadingState extends SocialStates{}

class SocialUserUpdateSuccessState extends SocialStates{}


class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}
class SocialGetMessagesSuccessState extends SocialStates{}