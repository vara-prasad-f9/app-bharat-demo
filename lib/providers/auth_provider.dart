import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  void setPhoneNumber(String phone) {
    state = state.copyWith(phoneNumber: phone);
  }

  void setOtp(String otp) {
    state = state.copyWith(otp: otp);
  }

  Future<bool> verifyOtp() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // For demo, consider it verified if OTP is '123456'
      final isVerified = state.otp == '123456';
      
      if (isVerified) {
        state = state.copyWith(
          isAuthenticated: true,
          isLoading: false,
        );
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  void logout() {
    state = const AuthState();
  }
}

class AuthState {
  final String phoneNumber;
  final String otp;
  final bool isAuthenticated;
  final bool isLoading;

  const AuthState({
    this.phoneNumber = '',
    this.otp = '',
    this.isAuthenticated = false,
    this.isLoading = false,
  });

  AuthState copyWith({
    String? phoneNumber,
    String? otp,
    bool? isAuthenticated,
    bool? isLoading,
  }) {
    return AuthState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
