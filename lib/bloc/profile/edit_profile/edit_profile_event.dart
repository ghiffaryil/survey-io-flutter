part of 'edit_profile_bloc.dart';

@freezed
class EditProfileEvent with _$EditProfileEvent {
  const factory EditProfileEvent.started() = _Started;
  const factory EditProfileEvent.editProfile(EditProfileRequestModel requestModel) = _EditProfile;
}