import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_app/app/di/injection_container.dart';
import 'package:insurance_app/features/login/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(repository: sl()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Đăng nhập')),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.failure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage ?? '')));
            }
            if (state.status == LoginStatus.success) {
              // TODO: Chuyển sang màn hình chính hoặc lưu token
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Vui lòng nhập email'
                          : null,
                      onSaved: (value) => state.dataForm['email'] = value ?? '',
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Mật khẩu'),
                      obscureText: true,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Vui lòng nhập mật khẩu'
                          : null,
                      onSaved: (value) => state.dataForm['password'] = value ?? '',
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: state.dataForm['rememberMe'],
                          onChanged: (value) {
                            setState(() {
                              state.dataForm['rememberMe'] = value ?? false;
                            });
                          },
                        ),
                        const Text('Ghi nhớ đăng nhập'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    state.status == LoginStatus.loading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  context.read<LoginBloc>().add(
                                    LoginSubmitted(
                                      email: state.dataForm['email'],
                                      password: state.dataForm['password'],
                                      rememberMe: state.dataForm['rememberMe'],
                                    ),
                                  );
                                }
                              },
                              child: const Text('Đăng nhập'),
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
