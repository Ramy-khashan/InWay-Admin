abstract class SignInStates {}

class InitialState extends SignInStates {}

class ChangeState extends SignInStates {}

class ValidEmailState extends SignInStates {}

class ValidPasswordState extends SignInStates {}

class DoneSignIn extends SignInStates {}

class CheckSignIn extends SignInStates {}
