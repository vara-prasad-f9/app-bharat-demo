import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  static const String _authKey = 'auth_state';
  
  AuthNotifier() : super(const AuthState()) {
    _loadAuthState();
  }
  
  Future<void> _loadAuthState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final authData = prefs.getString(_authKey);
      
      if (authData != null) {
        final Map<String, dynamic> data = jsonDecode(authData);
        state = AuthState.fromJson(data);
      }
    } catch (e) {
      // Handle error, maybe clear the saved state if it's corrupted
      await _clearAuthState();
    }
  }
  
  Future<void> _saveAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authKey, jsonEncode(state.toJson()));
  }
  
  Future<void> _clearAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authKey);
  }

  Future<void> setPhoneNumber(String phone) async {
    state = state.copyWith(phoneNumber: phone);
    await _saveAuthState();
  }

  Future<void> setOtp(String otp) async {
    state = state.copyWith(otp: otp);
    await _saveAuthState();
  }

  Future<bool> verifyOtp() async {
    try {
      state = state.copyWith(isLoading: true);
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // For demo, consider it verified if OTP is '123456'
      final isVerified = state.otp == '123456';
      
      if (isVerified) {
        state = state.copyWith(
          isAuthenticated: true,
          isLoading: false,
        );
        await _saveAuthState();
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        await _saveAuthState();
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> logout() async {
    state = const AuthState();
    await _clearAuthState();
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

  factory AuthState.fromJson(Map<String, dynamic> json) {
    return AuthState(
      phoneNumber: json['phoneNumber'] ?? '',
      otp: json['otp'] ?? '',
      isAuthenticated: json['isAuthenticated'] ?? false,
      isLoading: json['isLoading'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'otp': otp,
      'isAuthenticated': isAuthenticated,
      'isLoading': isLoading,
    };
  }

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
