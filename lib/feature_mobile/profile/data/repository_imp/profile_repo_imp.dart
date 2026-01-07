import 'dart:io';
import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/core/service/base_url.dart';
import 'package:ams_mobile/core/service/http_service.dart';
import 'package:ams_mobile/feature_mobile/profile/data/model/user_profile.dart';
import 'package:ams_mobile/feature_mobile/profile/domain/entities/update_profile_entity.dart';
import 'package:ams_mobile/feature_mobile/profile/domain/repository/profile_repository.dart';
import 'package:dio/dio.dart';

class ProfileRepoImp extends ProfileRepository {
  @override
  Future<BaseResponse<UserProfile>> getUserProfile() async {
    final response = await HttpService.instance.get(BaseUrl.userProfile);
    return BaseResponse<UserProfile>.fromJson(
      response.data,
      (json) => UserProfile.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<BaseResponse<String>> uploadProfileImage(File imageFile) async {
    try {
      // Step 1: Upload file to /files/upload endpoint
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      final uploadResponse = await HttpService.instance.uploadFile(
        BaseUrl.fileUpload,
        formData: formData,
      );

      // Parse the upload response to get the file path
      final uploadData = uploadResponse.data;
      String imagePath;
      String imageUrl;

      if (uploadData is Map<String, dynamic>) {
        // Extract path and URL from nested data structure
        if (uploadData.containsKey('data') &&
            uploadData['data'] is Map<String, dynamic>) {
          final data = uploadData['data'] as Map<String, dynamic>;
          imagePath = data['path'] as String;
          imageUrl = data['url'] as String;
        } else if (uploadData.containsKey('path')) {
          imagePath = uploadData['path'] as String;
          imageUrl = uploadData['url'] as String;
        } else {
          throw Exception('File path not found in upload response');
        }
      } else {
        throw Exception('Invalid upload response format');
      }

      // Step 2: Update profile with the image path
      final updateResponse = await HttpService.instance.put(
        BaseUrl.userProfile,
        data: {'image': imagePath},
      );

      // Return success response with the image URL
      return BaseResponse<String>.fromJson(
        updateResponse.data,
        (json) => imageUrl,
      );
    } catch (e) {
      print('Error uploading profile image: $e');
      rethrow;
    }
  }

  @override
  Future<BaseResponse<UserProfile>> updateUserProfile(
    UpdateProfileEntity entity,
  ) async {
    try {
      final response = await HttpService.instance.put(
        BaseUrl.userProfile,
        data: entity.toJson(),
      );

      return BaseResponse<UserProfile>.fromJson(response.data, (json) {
        try {
          // The update endpoint returns user data nested under "user" key
          if (json is Map<String, dynamic> && json.containsKey('user')) {
            final userData = json['user'] as Map<String, dynamic>;
            return UserProfile.fromJson(userData);
          }
          // Fallback: try parsing directly if user key is not present
          return UserProfile.fromJson(json as Map<String, dynamic>);
        } catch (e) {
          print('Error parsing user profile: $e');
          print('JSON data: $json');
          rethrow;
        }
      });
    } catch (e) {
      print('Error updating profile: $e');
      rethrow;
    }
  }
}
