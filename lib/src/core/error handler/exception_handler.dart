part of 'app_exception.dart';

class AppExceptionHandler {
  static throwException(Object? error, [int? statusCode]) {
    if (error is SocketException) {
      throw InternetSocketException(error.message);
    } else if (error is FirebaseException) {
      handleFirebaseException(error);
    } else if (error is FormatException) {
      throw DataFormatException(error.message);
    } else if (error is TimeoutException) {
      throw ApiTimeOutException(error.message);
    } else if (error is PlatformException) {
      AppException(title: error.code, message: error.message);
    } else if (error is AppException) {
      throw error;
    } else {
      throw AppException();
    }
  }

  static handleFirebaseException(Object error) {
    if (error is SocketException) {
      throw InternetSocketException(error.message);
    } else if (error is FirebaseAuthException) {
      throw FirebaseError(
          message: generateExceptionMessage(error.code), title: error.code);
    } else if (error is TimeoutException) {
      throw ApiTimeOutException(error.message);
    } else if (error is PlatformException) {
      AppException(
          exceptionType: 'Platform Exception',
          title: error.code,
          message: error.message);
    } else if (error is AppException) {
      throw error;
    } else {
      throw AppException();
    }
  }

  static String generateExceptionMessage(String exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      // Firebase Auth errors
      case "claims-too-large":
        errorMessage = "The claims payload size is too large.";
        break;
      case "email-already-exists":
        errorMessage = "The email has already been registered.";
        break;
      case "id-token-expired":
        errorMessage = "The user's ID token has expired.";
        break;
      case "id-token-revoked":
        errorMessage = "The ID token has been revoked.";
        break;
      case "insufficient-permission":
        errorMessage = "You do not have permission to perform this action.";
        break;
      case "internal-error":
        errorMessage = "An internal error occurred.";
        break;
      case "invalid-email":
        errorMessage = "Your email address appears to be malformed.";
        break;
      case "user-not-found":
        errorMessage = "User with this email doesn't exist.";
        break;
      case "wrong-password":
        errorMessage = "Your password is wrong.";
        break;
      case "invalid-credential":
        errorMessage = "The email or password is incorrect";
        break;
      case "email-already-in-use":
        errorMessage = "The email has already been registered. Please login.";
        break;
      case "network-request-failed":
        errorMessage = "A network error occurred. Please try again.";
        break;
      case "too-many-requests":
        errorMessage =
            "We have blocked all requests from this device due to unusual activity.";
        break;
      case "user-disabled":
        errorMessage = "The user account has been disabled.";
        break;

      // Firebase Storage errors
      case "unknown":
        errorMessage = "An unknown error occurred in storage.";
        break;
      case "object-not-found":
        errorMessage = "The requested file was not found in the storage.";
        break;
      case "bucket-not-found":
        errorMessage = "The specified storage bucket was not found.";
        break;
      case "project-not-found":
        errorMessage = "The Firebase project was not found.";
        break;
      case "quota-exceeded":
        errorMessage = "You have exceeded your storage quota.";
        break;
      case "unauthenticated":
        errorMessage = "You need to authenticate before accessing the storage.";
        break;
      case "unauthorized":
        errorMessage = "You are not authorized to perform this action.";
        break;
      case "retry-limit-exceeded":
        errorMessage = "The retry limit has been exceeded. Please try again.";
        break;
      case "invalid-checksum":
        errorMessage =
            "File checksum does not match. The file may be corrupted.";
        break;
      case "canceled":
        errorMessage = "The operation was canceled by the user.";
        break;

      // Firestore errors
      case "permission-denied":
        errorMessage =
            "You do not have permission to access this Firestore resource.";
        break;
      case "not-found":
        errorMessage = "The requested Firestore document was not found.";
        break;
      case "resource-exhausted":
        errorMessage = "You have exhausted your quota. Please try again later.";
        break;
      case "cancelled":
        errorMessage = "The Firestore operation was cancelled.";
        break;
      case "data-loss":
        errorMessage = "Unrecoverable data loss or corruption occurred.";
        break;
      case "deadline-exceeded":
        errorMessage = "The operation took too long to complete.";
        break;
      case "unavailable":
        errorMessage = "Firestore service is currently unavailable.";
        break;
      default:
        errorMessage = "An undefined error happened.";
        break;
    }

    return errorMessage;
  }
}
