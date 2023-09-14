import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:water_level_flutter/models/AttachPolicyToUserRes.dart';

part 'settings_repository.g.dart';

class SettingsRepository {
  Future<List<AuthUserAttribute>> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      for (final element in result) {
        safePrint('key: ${element.userAttributeKey}; value: ${element.value}');
      }
      return result;
    } on AuthException catch (e) {
      safePrint('Error fetching user attributes: ${e.message}');
      throw e.message;
    }
  }

  Future attachPolicy(String id) async {
    const attachPolicyToUser = 'AttachPolicyToUser';
    String graphQLDocument = '''query AttachPolicyToUser {
  $attachPolicyToUser(username: "$id") {
          status
    message
  }
}''';
    final request = GraphQLRequest<AttachPolicyToUserRes>(
      document: graphQLDocument,
      modelType: AttachPolicyToUserRes.classType,
      decodePath: attachPolicyToUser,
    );
    return query(request);
  }

  Future<AsyncValue> query(GraphQLRequest request) async {
    try {
      final response = await Amplify.API.query(request: request).response;
      print('Response: data : ${response.data}  error :${response.errors}');
      if (response.errors.isNotEmpty) {
        if (response.errors.first.message == 'ResourceNotFoundException') {
          throw 'Device not found';
        }
        if (response.errors.first.message == 'UriParameterException') {
          throw 'Something went wrong';
        }
        throw response.errors.first.message;
      }
      return AsyncData(response.data);
    } catch (e) {
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(SettingsRepositoryRef ref) {
  return SettingsRepository();
}

@riverpod
Future<List<AuthUserAttribute>> fetchCurrentUserAttributesFuture(
    FetchCurrentUserAttributesFutureRef ref) async {
  final repository = ref.read(settingsRepositoryProvider);
  final result = await repository.fetchCurrentUserAttributes();
  return result;
}
