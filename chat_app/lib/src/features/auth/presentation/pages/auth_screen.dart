import 'package:chat_app/src/features/landing/presentation/pages/landing.dart';
import 'package:chat_app/src/core/local/message_service.dart';
import 'package:chat_app/src/core/widgets/buttons/primary_button.dart';
import 'package:chat_app/src/core/widgets/inputs/input_primary.dart';
import 'package:chat_app/src/core/widgets/styles/colors.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController _emailController = TextEditingController(
    text: "kevin@chatapp.com",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "12345678",
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<AuthBloc>(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.brand(context),
                  ),
                ),
                const SizedBox(height: 24),
                InputPrimary(label: 'Email', controller: _emailController),
                InputPrimary(
                  label: 'Password',
                  controller: _passwordController,
                  password: true,
                ),
                const SizedBox(height: 12),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      MessageService.showApiError(state.error);
                    } else if (state is AuthSuccess) {
                      MessageService.showSuccess(state.data.message);
                      final user = state.data.data;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              LandingPage(userId: user.id, token: user.token),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;
                    return ButtonPrimary(
                      title: isLoading ? "Loading..." : "Sign In",
                      onPressed: isLoading
                          ? null
                          : () {
                              final email = _emailController.text.trim();
                              final password = _passwordController.text.trim();
                              context.read<AuthBloc>().add(
                                AuthSignInEvent(email, password),
                              );
                            },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
