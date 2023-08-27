import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository(this._auth);
  final AmplifyAuthCognito _auth;

  Future<AuthUser> get currentUser async => await _auth.getCurrentUser();

  Future<void> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      for (final element in result) {
        safePrint('key: ${element.userAttributeKey}; value: ${element.value}');
      }
    } on AuthException catch (e) {
      safePrint('Error fetching user attributes: ${e.message}');
    }
  }

  Future<void> updateUserEmail({
    required String newEmail,
  }) async {
    try {
      final result = await Amplify.Auth.updateUserAttribute(
        userAttributeKey: AuthUserAttributeKey.email,
        value: newEmail,
      );
      _handleUpdateUserAttributeResult(result);
    } on AuthException catch (e) {
      safePrint('Error updating user attribute: ${e.message}');
    }
  }

  void _handleUpdateUserAttributeResult(
    UpdateUserAttributeResult result,
  ) {
    switch (result.nextStep.updateAttributeStep) {
      case AuthUpdateAttributeStep.confirmAttributeWithCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthUpdateAttributeStep.done:
        safePrint('Successfully updated attribute');
        break;
    }
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }

  Future<void> updateUserAttributes() async {
    const attributes = [
      AuthUserAttribute(
        userAttributeKey: AuthUserAttributeKey.email,
        value: 'email@email.com',
      ),
      AuthUserAttribute(
        userAttributeKey: AuthUserAttributeKey.familyName,
        value: 'MyFamilyName',
      ),
    ];
    try {
      final result = await Amplify.Auth.updateUserAttributes(
        attributes: attributes,
      );
      result.forEach((key, value) {
        switch (value.nextStep.updateAttributeStep) {
          case AuthUpdateAttributeStep.confirmAttributeWithCode:
            final destination = value.nextStep.codeDeliveryDetails?.destination;
            safePrint('Confirmation code sent to $destination for $key');
            break;
          case AuthUpdateAttributeStep.done:
            safePrint('Update completed for $key');
            break;
        }
      });
    } on AuthException catch (e) {
      safePrint('Error updating user attributes: ${e.message}');
    }
  }

  Future<void> verifyAttributeUpdate() async {
    try {
      await Amplify.Auth.confirmUserAttribute(
        userAttributeKey: AuthUserAttributeKey.email,
        confirmationCode: '390739',
      );
    } on AuthException catch (e) {
      safePrint('Error confirming attribute update: ${e.message}');
    }
  }

  Future<void> resendVerificationCode() async {
    try {
      final result = await Amplify.Auth.resendUserAttributeConfirmationCode(
        userAttributeKey: AuthUserAttributeKey.email,
      );
      _handleCodeDelivery(result.codeDeliveryDetails);
    } on AuthException catch (e) {
      safePrint('Error resending code: ${e.message}');
    }
  }
}

@Riverpod(keepAlive: true)
AmplifyAuthCognito amplifyAuthCognito(AmplifyAuthCognitoRef ref) {
  return AmplifyAuthCognito();
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(ref.watch(amplifyAuthCognitoProvider));
}
