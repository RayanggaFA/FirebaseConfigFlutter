import 'dart:convert'; // Import untuk base64 decode
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'register.dart';
import 'Welcome_page.dart';
import 'package:firebase_database/firebase_database.dart'; // Import untuk Firebase Realtime Database

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController    = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth                        = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn                = GoogleSignIn();
  final DatabaseReference _databaseRef            = FirebaseDatabase.instance.ref('User');

  bool _isLoading = false;
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Verifikasi email dan password di Firebase Auth
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Ambil data pengguna dari Realtime Database
      DatabaseEvent event = await _databaseRef.child(userCredential.user!.uid).once();
      DataSnapshot snapshot = event.snapshot;  // Menggunakan DataSnapshot di sini

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        final storedPassword = data['password'] as String;

        String decodedPassword = utf8.decode(base64.decode(storedPassword));

        // Periksa apakah password yang dimasukkan cocok dengan yang disimpan
        if (decodedPassword == _passwordController.text.trim()) {
          // Jika cocok, navigasi ke halaman berikutnya
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WelcomePage()),
          );
        } else {
          // Tampilkan AlertDialog jika password salah
          _showAlertDialog('Login gagal', 'Password salah.');
        }
      } else {
        _showAlertDialog('Login gagal', 'Pengguna tidak ditemukan.');
      }
    } catch (e) {
      print('Login error: ${e.toString()}');
      // Menampilkan AlertDialog jika terjadi kesalahan
      _showAlertDialog('Login gagal', 'Silakan periksa kredensial Anda.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

// Fungsi untuk menampilkan AlertDialog
void _showAlertDialog(String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}



  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final UserCredential userCredential = await _auth.signInWithCredential(
        GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        ),
      );

      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WelcomePage()),
        );
      }
    } catch (e) {
      print('Google Sign In error: ${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Google Sign In gagal.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Login Yuk!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,  // Make button full-width
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Masuk', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Atau', style: TextStyle(fontSize: 14)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset('assets/image/google.png'),
                      onPressed: _signInWithGoogle,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: 'Belum punya akun? ',
                      style: TextStyle(fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'Daftar Sekarang',
                          style: TextStyle(
                              color: Colors.orange, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
