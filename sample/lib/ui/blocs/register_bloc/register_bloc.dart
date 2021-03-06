import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/service/authentication.dart';
import 'package:GTUBT/service/user.dart';
import 'package:GTUBT/ui/blocs/register_bloc/bloc.dart';
import 'package:GTUBT/ui/utils/validators.dart';
import 'package:GTUBT/models/enums.dart';
import 'package:bloc/bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();
  RegisterBloc();

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is EmailChanged) {
      yield state.update(isEmailValid: Validators.isValidEmail(event.email));
    } else if (event is NameChanged) {
      yield state.update(isNameValid: Validators.isValidString(event.name));
    } else if (event is LastnameChanged) {
      yield state.update(
          isLastnameValid: Validators.isValidString(event.lastname));
    } else if (event is PasswordChanged) {
      yield state.update(
          isPasswordValid: Validators.isValidPassword(event.password));
    } else if (event is ClassChanged) {
      yield state.update(isGradeValid: Validators.isValidDigit(event.year));
    } else if (event is PhoneNumberChanged) {
      yield state.update(
          isPhoneNumberValid: Validators.isValidPhoneNumber(event.phoneNumber));
    } else if (event is StudentNumberChanged) {
      yield state.update(
          isStudentNumberValid:
              Validators.isValidStudentNumber(event.studentNumber));
    } else if (event is DepartmentChanged) {
      yield state.update(
          isDepartmentValid: Validators.isValidDepartment(event.department));
    } else if (event is Submitted) {
      yield* _mapSubmittedToState(event);
    }
  }

  Stream<RegisterState> _mapSubmittedToState(Submitted event) async* {
    yield RegisterState.loading();

    try {
      User user = User(
          email: event.email,
          name: event.name,
          lastname: event.lastname,
          year: int.parse(event.year),
          department: Department.cse,
          phone: event.phoneNumber,
          studentId: event.studentNumber);

      await _authService.signUp({
        'email': user.email,
        'password': event.password,
      });
      await _userService.post(user);
      yield RegisterState.success();
    } catch (error) {
      print(error);
      yield RegisterState.failure();
    }
  }
}
