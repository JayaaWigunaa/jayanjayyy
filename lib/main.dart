import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

// ═══════════════════════════════════════════════
// THEME CONSTANTS
// ═══════════════════════════════════════════════
const kPrimary = Color(0xFF00E5FF);
const kGold    = Color(0xFFFFD700);
const kBg      = Color(0xFF0D0D0F);
const kCard    = Color(0xFF131320);
const kInput   = Color(0xFF1E1E30);
const kPurple  = Color(0xFF7C4DFF);
const kGreen   = Color(0xFF00E676);
const kRed     = Color(0xFFFF5252);

// ═══════════════════════════════════════════════
// GAME IMAGES (base64 encoded)
// ═══════════════════════════════════════════════
class GameImages {
  static const String ml      = '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';
  static const String ff      = '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';
  static const String genshin = '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';
  static const String valorant = 'iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAYAAADDPmHLAA...'; // (base64 Valorant icon - merah putih clean)
  static const String pubg = 'iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAYAAADDPmHLAA...'; // (base64 PUBG Mobile icon)
  static const String hok = 'iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAYAAADDPmHLAA...'; // (base64 Honor of Kings icon)
  
  static Widget image(String? b64, {double size = 46}) {
    if (b64 == null || b64.isEmpty) return const SizedBox.shrink();
    try {
      final bytes = base64Decode(b64);
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(bytes, width: size, height: size, fit: BoxFit.cover),
      );
    } catch (_) {
      return const SizedBox.shrink();
    }
  }
}

// ═══════════════════════════════════════════════
// MODELS
// ═══════════════════════════════════════════════
class GameProduct {
  final String id, name;
  final IconData icon;
  final Color color, color2;
  final List<TopUpItem> items;
  final String? imageB64;
  const GameProduct({required this.id, required this.name, required this.icon, required this.color, required this.color2, required this.items, this.imageB64});
}

class TopUpItem {
  final String label;
  final int amount, price;
  final bool isPopular, isBonus;
  const TopUpItem({required this.label, required this.amount, required this.price, this.isPopular = false, this.isBonus = false});
}

class Transaction {
  final String game, item, amount, status;
  final int price;
  final DateTime date;
  final IconData icon;
  final Color color;
  const Transaction({required this.game, required this.item, required this.amount, required this.price, required this.date, required this.status, required this.icon, required this.color});
}

// ═══════════════════════════════════════════════
// DUMMY DATA
// ═══════════════════════════════════════════════
class AppData {
  static final List<GameProduct> games = [
    GameProduct(
      id: 'ml', name: 'Mobile Legends', icon: Icons.gamepad_rounded, color: kPrimary, color2: const Color(0xFF0077B6), imageB64: GameImages.ml,
      items: [
        const TopUpItem(label: '11 + 2 Diamonds',    amount: 13,   price: 3000),
        const TopUpItem(label: '22 + 2 Diamonds',    amount: 24,   price: 5500),
        const TopUpItem(label: '44 + 4 Diamonds',    amount: 48,   price: 10500),
        const TopUpItem(label: '56 + 6 Diamonds',    amount: 62,   price: 13000),
        const TopUpItem(label: '86 + 8 Diamonds',    amount: 94,   price: 19000, isPopular: true),
        const TopUpItem(label: '112 + 12 Diamonds',  amount: 124,  price: 25000),
        const TopUpItem(label: '170 + 17 Diamonds',  amount: 187,  price: 37000),
        const TopUpItem(label: '222 + 22 Diamonds',  amount: 244,  price: 48000),
        const TopUpItem(label: '257 + 27 Diamonds',  amount: 284,  price: 57000),
        const TopUpItem(label: '340 + 35 Diamonds',  amount: 375,  price: 75000),
        const TopUpItem(label: '355 + 37 Diamonds',  amount: 392,  price: 78000,  isBonus: true),
        const TopUpItem(label: '514 + 52 Diamonds',  amount: 566,  price: 113000),
        const TopUpItem(label: '566 + 58 Diamonds',  amount: 624,  price: 123000, isPopular: true),
        const TopUpItem(label: '706 + 72 Diamonds',  amount: 778,  price: 155000),
        const TopUpItem(label: '878 + 88 Diamonds',  amount: 966,  price: 194000),
        const TopUpItem(label: '963 + 96 Diamonds',  amount: 1059, price: 213000, isBonus: true),
        const TopUpItem(label: '1412 + 144 Diamonds', amount: 1556, price: 310000),
        const TopUpItem(label: '2195 + 220 Diamonds', amount: 2415, price: 483000),
        const TopUpItem(label: '3688 + 372 Diamonds', amount: 4060, price: 810000),
        const TopUpItem(label: '5532 + 553 Diamonds', amount: 6085, price: 1210000),
      ],
    ),
    GameProduct(
      id: 'ff', name: 'Free Fire', icon: Icons.whatshot_rounded, color: kGold, color2: const Color(0xFFFF6D00), imageB64: GameImages.ff,
      items: [
        const TopUpItem(label: '5 Diamonds',    amount: 5,    price: 1000),
        const TopUpItem(label: '12 Diamonds',   amount: 12,   price: 2000),
        const TopUpItem(label: '50 Diamonds',   amount: 50,   price: 8000,   isPopular: true),
        const TopUpItem(label: '70 Diamonds',   amount: 70,   price: 11000),
        const TopUpItem(label: '100 Diamonds',  amount: 100,  price: 15000),
        const TopUpItem(label: '140 Diamonds',  amount: 140,  price: 21000),
        const TopUpItem(label: '210 Diamonds',  amount: 210,  price: 31500),
        const TopUpItem(label: '355 Diamonds',  amount: 355,  price: 52500,  isPopular: true),
        const TopUpItem(label: '520 Diamonds',  amount: 520,  price: 77000),
        const TopUpItem(label: '710 Diamonds',  amount: 710,  price: 105000),
        const TopUpItem(label: '1060 Diamonds', amount: 1060, price: 157000, isBonus: true),
        const TopUpItem(label: '1450 Diamonds', amount: 1450, price: 215000),
        const TopUpItem(label: '2180 Diamonds', amount: 2180, price: 322000),
      ],
    ),
    GameProduct(
      id: 'pubg', name: 'PUBG Mobile', icon: Icons.military_tech_rounded, color: kPurple, color2: const Color(0xFF311B92),
      items: [
        const TopUpItem(label: '60 UC',         amount: 60,   price: 12000),
        const TopUpItem(label: '120 + 6 UC',    amount: 126,  price: 22000),
        const TopUpItem(label: '325 + 16 UC',   amount: 341,  price: 57000,  isPopular: true),
        const TopUpItem(label: '660 + 33 UC',   amount: 693,  price: 113000),
        const TopUpItem(label: '1800 + 90 UC',  amount: 1890, price: 306000, isBonus: true),
        const TopUpItem(label: '3850 + 192 UC', amount: 4042, price: 643000),
        const TopUpItem(label: '8100 + 405 UC', amount: 8505, price: 1350000),
      ],
    ),
    GameProduct(
      id: 'genshin', name: 'Genshin Impact', icon: Icons.auto_awesome_rounded, color: kGreen, color2: const Color(0xFF00695C), imageB64: GameImages.genshin,
      items: [
        const TopUpItem(label: '60 Genesis Crystals',    amount: 60,   price: 14000),
        const TopUpItem(label: '300 + 30 Genesis',       amount: 330,  price: 70000,  isPopular: true),
        const TopUpItem(label: '980 + 110 Genesis',      amount: 1090, price: 230000),
        const TopUpItem(label: '1980 + 260 Genesis',     amount: 2240, price: 460000, isBonus: true),
        const TopUpItem(label: '3280 + 600 Genesis',     amount: 3880, price: 760000),
        const TopUpItem(label: '6480 + 1600 Genesis',    amount: 8080, price: 1500000, isPopular: true),
      ],
    ),
    GameProduct(
      id: 'valorant', name: 'Valorant', icon: Icons.sports_esports_rounded, color: kRed, color2: const Color(0xFFB71C1C),
      items: [
        const TopUpItem(label: '475 VP',   amount: 475,   price: 38000),
        const TopUpItem(label: '1000 VP',  amount: 1000,  price: 75000,  isPopular: true),
        const TopUpItem(label: '2050 VP',  amount: 2050,  price: 150000),
        const TopUpItem(label: '3650 VP',  amount: 3650,  price: 265000, isBonus: true),
        const TopUpItem(label: '5350 VP',  amount: 5350,  price: 385000),
        const TopUpItem(label: '11000 VP', amount: 11000, price: 775000),
      ],
    ),
    GameProduct(
      id: 'hok', name: 'Honor of Kings', icon: Icons.shield_rounded, color: const Color(0xFFFF9100), color2: const Color(0xFFE65100),
      items: [
        const TopUpItem(label: '50 Tokens',   amount: 50,   price: 7500),
        const TopUpItem(label: '100 Tokens',  amount: 100,  price: 15000),
        const TopUpItem(label: '250 Tokens',  amount: 250,  price: 37000, isPopular: true),
        const TopUpItem(label: '500 Tokens',  amount: 500,  price: 72000),
        const TopUpItem(label: '1000 Tokens', amount: 1000, price: 140000, isBonus: true),
        const TopUpItem(label: '2000 Tokens', amount: 2000, price: 275000),
      ],
    ),
  ];

  static final List<Transaction> transactions = [
    Transaction(game: 'Mobile Legends', item: '86 + 8 Diamonds', amount: '94 Diamonds', price: 19000, date: DateTime.now().subtract(const Duration(hours: 2)), status: 'Sukses', icon: Icons.gamepad_rounded, color: kPrimary),
    Transaction(game: 'Free Fire', item: '100 Diamonds', amount: '100 Diamonds', price: 15000, date: DateTime.now().subtract(const Duration(days: 1)), status: 'Sukses', icon: Icons.whatshot_rounded, color: kGold),
    Transaction(game: 'PUBG Mobile', item: '325 + 16 UC', amount: '341 UC', price: 57000, date: DateTime.now().subtract(const Duration(days: 2)), status: 'Sukses', icon: Icons.military_tech_rounded, color: kPurple),
    Transaction(game: 'Genshin Impact', item: '300 + 30 Genesis', amount: '330 Genesis', price: 70000, date: DateTime.now().subtract(const Duration(days: 3)), status: 'Gagal', icon: Icons.auto_awesome_rounded, color: kGreen),
    Transaction(game: 'Valorant', item: '1000 VP', amount: '1000 VP', price: 75000, date: DateTime.now().subtract(const Duration(days: 5)), status: 'Sukses', icon: Icons.sports_esports_rounded, color: kRed),
  ];

  static String formatPrice(int p) {
    final s = p.toString();
    final b = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) b.write('.');
      b.write(s[i]);
    }
    return 'Rp ${b.toString()}';
  }

  static String timeAgo(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    return '${diff.inDays} hari lalu';
  }
}

// ═══════════════════════════════════════════════
// APP ROOT
// ═══════════════════════════════════════════════
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jay TopUp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: kBg, colorScheme: const ColorScheme.dark(primary: kPrimary, secondary: kGold, surface: kCard)),
      initialRoute: '/login',
      onGenerateRoute: (s) {
        switch (s.name) {
          case '/login':    return _route(const LoginScreen());
          case '/forgot':   return _route(const ForgotPasswordScreen());
          case '/dashboard':return _route(const DashboardScreen());
          case '/riwayat':  return _route(const RiwayatScreen());
          case '/promo':    return _route(const PromoScreen());
          case '/support':  return _route(const SupportScreen());
          case '/profil':   return _route(const ProfilScreen());
          case '/topup':    return _route(TopUpScreen(game: s.arguments as GameProduct));
          case '/order':
            final a = s.arguments as Map<String, dynamic>;
            return _route(OrderScreen(game: a['game'] as GameProduct, item: a['item'] as TopUpItem));
          default: return _route(const LoginScreen());
        }
      },
    );
  }
  PageRoute _route(Widget w) => MaterialPageRoute(builder: (_) => w);
}

// ═══════════════════════════════════════════════
// SHARED WIDGETS
// ═══════════════════════════════════════════════
class AppBg extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  const AppBg({super.key, required this.child, this.colors = const [Color(0xFF0D0D0F), Color(0xFF0A1628), Color(0xFF0D0D0F)]});
  @override
  Widget build(BuildContext context) => Stack(children: [
    Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: colors))),
    child,
  ]);
}

class BackBtn extends StatelessWidget {
  const BackBtn({super.key});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white12)),
      child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
    ),
  );
}

class GlowBtn extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool isLoading;
  final IconData? icon;
  final double height;
  const GlowBtn({super.key, required this.label, required this.color, required this.onTap, this.isLoading = false, this.icon, this.height = 54});
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity, height: height,
    child: ElevatedButton(
      onPressed: isLoading ? null : onTap,
      style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: kBg, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), elevation: 8, shadowColor: color.withOpacity(0.5)),
      child: isLoading
        ? SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: kBg))
        : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 8)],
            Text(label, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, letterSpacing: 1.5)),
          ]),
    ),
  );
}

void showSnack(BuildContext ctx, String msg, Color color) {
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    content: Text(msg), backgroundColor: color, behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ));
}

// ═══════════════════════════════════════════════
// LOGIN SCREEN
// ═══════════════════════════════════════════════
// ═══════════════════════════════════════════════
// LOGIN SCREEN (DIUBAH MENJADI EMAIL)
// ═══════════════════════════════════════════════
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  late AnimationController _ac;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _fade = CurvedAnimation(parent: _ac, curve: Curves.easeOut);
    _ac.forward();
  }

  @override
  void dispose() {
    _ac.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Validasi email sederhana
  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showSnack(context, 'Email dan password tidak boleh kosong', kRed);
      return;
    }

    if (!_isValidEmail(email)) {
      showSnack(context, 'Masukkan format email yang valid', kRed);
      return;
    }

    setState(() => _loading = true);

    // Simulasi proses login
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() => _loading = false);
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBg(
        child: SafeArea(
          child: FadeTransition(
            opacity: _fade,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(colors: [kPrimary, Color(0xFF0077B6)]),
                        boxShadow: [BoxShadow(color: kPrimary.withOpacity(0.4), blurRadius: 24, spreadRadius: 2)],
                      ),
                      child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 48),
                    ),
                    const SizedBox(height: 16),
                    const Text('JAY TOPUP', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: 4, color: Colors.white)),
                    const SizedBox(height: 6),
                    Container(width: 60, height: 3, decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), gradient: const LinearGradient(colors: [kPrimary, kGold]))),
                    const SizedBox(height: 36),

                    Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: kCard,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: kPrimary.withOpacity(0.2)),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 30, offset: const Offset(0, 10))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Selamat Datang 👋', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 4),
                          Text('Silakan login untuk melanjutkan', style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.5))),
                          const SizedBox(height: 28),

                          // EMAIL FIELD
                          _lbl('Email'),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'contoh@email.com',
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 14),
                              prefixIcon: const Icon(Icons.email_outlined, color: kPrimary, size: 20),
                              filled: true,
                              fillColor: kInput,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: kPrimary, width: 1.5)),
                            ),
                          ),

                          const SizedBox(height: 18),

                          // PASSWORD FIELD
                          _lbl('Password'),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _passwordController,
                            obscureText: _obscure,
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Masukkan password',
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 14),
                              prefixIcon: const Icon(Icons.lock_outline_rounded, color: kPrimary, size: 20),
                              suffixIcon: IconButton(
                                icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.white38, size: 20),
                                onPressed: () => setState(() => _obscure = !_obscure),
                              ),
                              filled: true,
                              fillColor: kInput,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: kPrimary, width: 1.5)),
                            ),
                          ),

                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(context, '/forgot'),
                              child: const Text('Lupa Password?', style: TextStyle(color: kPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                            ),
                          ),

                          const SizedBox(height: 28),
                          GlowBtn(
                            label: 'LOGIN SEKARANG',
                            color: kPrimary,
                            onTap: _login,
                            isLoading: _loading,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text('Versi 1.00', style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.3), letterSpacing: 1)),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _lbl(String t) => Text(t, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.7)));
}
// ═══════════════════════════════════════════════
// FORGOT PASSWORD SCREEN
// ═══════════════════════════════════════════════
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _ec = TextEditingController();
  bool _sent = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AppBg(child: SafeArea(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 28), child: Column(children: [
      const SizedBox(height: 16),
      const Align(alignment: Alignment.centerLeft, child: BackBtn()),
      const SizedBox(height: 40),
      Container(width: 70, height: 70, decoration: BoxDecoration(shape: BoxShape.circle, color: kGold.withOpacity(0.15), border: Border.all(color: kGold.withOpacity(0.4), width: 1.5)), child: const Icon(Icons.lock_reset_rounded, color: kGold, size: 34)),
      const SizedBox(height: 20),
      const Text('Lupa Password', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
      const SizedBox(height: 8),
      Text('Masukkan email untuk reset password', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.5))),
      const SizedBox(height: 40),
      if (!_sent) Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(20), border: Border.all(color: kGold.withOpacity(0.2))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Email', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.7))),
        const SizedBox(height: 10),
        TextField(controller: _ec, keyboardType: TextInputType.emailAddress, style: const TextStyle(color: Colors.white, fontSize: 14), decoration: InputDecoration(hintText: 'contoh@email.com', hintStyle: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 14), prefixIcon: const Icon(Icons.email_outlined, color: kGold, size: 20), filled: true, fillColor: kInput, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: kGold, width: 1.5)))),
        const SizedBox(height: 20),
        GlowBtn(label: 'KIRIM RESET LINK', color: kGold, onTap: () => setState(() => _sent = true)),
      ]))
      else Container(padding: const EdgeInsets.all(28), decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.green.withOpacity(0.4))), child: Column(children: [
        const Icon(Icons.check_circle_outline_rounded, color: Colors.green, size: 50),
        const SizedBox(height: 14),
        const Text('Email Terkirim!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 8),
        Text('Cek inbox email dan ikuti instruksi reset password.', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.5))),
        const SizedBox(height: 20),
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Kembali ke Login', style: TextStyle(color: kPrimary, fontWeight: FontWeight.bold))),
      ])),
    ])))));
  }
}

// ═══════════════════════════════════════════════
// DASHBOARD SCREEN
// ═══════════════════════════════════════════════
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override State<DashboardScreen> createState() => _DashboardScreenState();
}
class _DashboardScreenState extends State<DashboardScreen> {
  int _tab = 0;

  Widget _body() {
    switch (_tab) {
      case 0: return _HomeTab(onGame: (g) => Navigator.pushNamed(context, '/topup', arguments: g));
      case 1: return const RiwayatScreen(embedded: true);
      case 2: return const ProfilScreen(embedded: true);
      default: return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: kCard, border: Border(top: BorderSide(color: Colors.white.withOpacity(0.08)))),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent, selectedItemColor: kPrimary, unselectedItemColor: Colors.white30,
          currentIndex: _tab, onTap: (i) => setState(() => _tab = i), type: BottomNavigationBarType.fixed, elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Beranda'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded), label: 'Transaksi'),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}

// ─── Home Tab ───────────────────────────────────
class _HomeTab extends StatelessWidget {
  final void Function(GameProduct) onGame;
  const _HomeTab({required this.onGame});

  @override
  Widget build(BuildContext context) {
    return AppBg(
      colors: const [Color(0xFF0A1628), kBg],
      child: SafeArea(child: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [

        // Header
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(24, 20, 24, 0), child: Row(children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(shape: BoxShape.circle, gradient: const LinearGradient(colors: [kPrimary, Color(0xFF0077B6)])), child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 24)),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Selamat Datang,', style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5))),
            const Text('User', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          ]),
          const Spacer(),
          IconButton(onPressed: () => Navigator.pushReplacementNamed(context, '/login'), icon: const Icon(Icons.logout_rounded, color: Colors.white54, size: 22)),
        ]))),

        // Balance
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(24, 20, 24, 0), child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF004E92), Color(0xFF000428)]), borderRadius: BorderRadius.circular(20), border: Border.all(color: kPrimary.withOpacity(0.3)), boxShadow: [BoxShadow(color: kPrimary.withOpacity(0.15), blurRadius: 20, offset: const Offset(0, 8))]),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text('Saldo Kamu', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13)),
              const Spacer(),
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: kPrimary.withOpacity(0.15), borderRadius: BorderRadius.circular(20)), child: const Text('AKTIF', style: TextStyle(color: kPrimary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1))),
            ]),
            const SizedBox(height: 10),
            const Text('Rp 250.000', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900)),
            const SizedBox(height: 4),
            Text('ID: #JAY-20240001', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12)),
          ]),
        ))),

        // Quick menu
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(24, 24, 24, 14), child: Text('Menu Cepat', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.7), letterSpacing: 0.5)))),
        SliverPadding(padding: const EdgeInsets.symmetric(horizontal: 24), sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.85),
          delegate: SliverChildListDelegate([
            _QMenu(Icons.gamepad_rounded, 'Top Up', kPrimary, () {}),
            _QMenu(Icons.history_rounded, 'Riwayat', kPurple, () => Navigator.pushNamed(context, '/riwayat')),
            _QMenu(Icons.local_offer_rounded, 'Promo', kGold, () => Navigator.pushNamed(context, '/promo')),
            _QMenu(Icons.headset_mic_rounded, 'Support', kGreen, () => Navigator.pushNamed(context, '/support')),
          ]),
        )),

        // Games
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(24, 24, 24, 14), child: Text('Pilih Game', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.7), letterSpacing: 0.5)))),
        SliverPadding(padding: const EdgeInsets.symmetric(horizontal: 24), sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.1),
          delegate: SliverChildBuilderDelegate((ctx, i) {
            final g = AppData.games[i];
            return GestureDetector(onTap: () => onGame(g), child: Container(
              decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [g.color.withOpacity(0.2), g.color2.withOpacity(0.1)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: g.color.withOpacity(0.3))),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                g.imageB64 != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: GameImages.image(g.imageB64, size: 56),
                    )
                  : Container(
                      width: 56, height: 56,
                      decoration: BoxDecoration(color: g.color.withOpacity(0.15), shape: BoxShape.circle),
                      child: Icon(g.icon, color: g.color, size: 28),
                    ),
                const SizedBox(height: 8),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: Text(g.name, textAlign: TextAlign.center, maxLines: 2, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600))),
              ]),
            ));
          }, childCount: AppData.games.length),
        )),

        // Recent tx
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(24, 24, 24, 12), child: Row(children: [
          Text('Transaksi Terakhir', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.7))),
          const Spacer(),
          GestureDetector(onTap: () => Navigator.pushNamed(context, '/riwayat'), child: Text('Lihat semua', style: TextStyle(fontSize: 12, color: kPrimary.withOpacity(0.8)))),
        ]))),
        SliverPadding(padding: const EdgeInsets.fromLTRB(24, 0, 24, 24), sliver: SliverList(delegate: SliverChildBuilderDelegate(
          (ctx, i) => TxCard(tx: AppData.transactions[i]),
          childCount: AppData.transactions.take(3).length,
        ))),
      ])),
    );
  }
}

class _QMenu extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _QMenu(this.icon, this.label, this.color, this.onTap);
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Container(width: 56, height: 56, decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.3))), child: Icon(icon, color: color, size: 26)),
    const SizedBox(height: 6),
    Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
  ]));
}

class TxCard extends StatelessWidget {
  final Transaction tx;
  const TxCard({super.key, required this.tx});
  @override
  Widget build(BuildContext context) {
    final ok = tx.status == 'Sukses';
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withOpacity(0.05))),
      child: Row(children: [
        Container(width: 42, height: 42, decoration: BoxDecoration(color: tx.color.withOpacity(0.12), borderRadius: BorderRadius.circular(12)), child: Icon(tx.icon, color: tx.color, size: 22)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(tx.game, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(tx.item, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12)),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(AppData.formatPrice(tx.price), style: const TextStyle(color: kPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 2),
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: (ok ? kGreen : kRed).withOpacity(0.15), borderRadius: BorderRadius.circular(6)), child: Text(tx.status, style: TextStyle(color: ok ? kGreen : kRed, fontSize: 11, fontWeight: FontWeight.bold))),
        ]),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════
// TOP UP SCREEN
// ═══════════════════════════════════════════════
class TopUpScreen extends StatefulWidget {
  final GameProduct game;
  const TopUpScreen({super.key, required this.game});
  @override State<TopUpScreen> createState() => _TopUpScreenState();
}
class _TopUpScreenState extends State<TopUpScreen> {
  final _idCtrl = TextEditingController();
  TopUpItem? _sel;
  @override void dispose() { _idCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final g = widget.game;
    return Scaffold(
      body: AppBg(child: SafeArea(child: Column(children: [
        Padding(padding: const EdgeInsets.fromLTRB(24, 16, 24, 0), child: Row(children: [
          const BackBtn(), const SizedBox(width: 14),
          Container(width: 38, height: 38, decoration: BoxDecoration(color: g.color.withOpacity(0.15), shape: BoxShape.circle),
            child: g.imageB64 != null
              ? ClipRRect(borderRadius: BorderRadius.circular(10), child: GameImages.image(g.imageB64, size: 38))
              : Icon(g.icon, color: g.color, size: 20)),
          const SizedBox(width: 10),
          Text(g.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ])),
        const SizedBox(height: 16),
        Expanded(child: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [

          // ID Input
          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: g.color.withOpacity(0.2))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Masukkan ID Game', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.7))),
              const SizedBox(height: 10),
              TextField(
                controller: _idCtrl, keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Contoh: 123456789', hintStyle: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 14),
                  prefixIcon: Icon(Icons.person_pin_rounded, color: g.color, size: 20),
                  filled: true, fillColor: kInput, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: g.color, width: 1.5)),
                ),
              ),
            ]),
          ))),

          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(24, 20, 24, 14), child: Text('Pilih Nominal', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.7))))),

          SliverPadding(padding: const EdgeInsets.symmetric(horizontal: 24), sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2.4),
            delegate: SliverChildBuilderDelegate((ctx, i) {
              final item = g.items[i];
              final sel = _sel == item;
              return GestureDetector(onTap: () => setState(() => _sel = item), child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(color: sel ? g.color.withOpacity(0.18) : kCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: sel ? g.color : Colors.white.withOpacity(0.08), width: sel ? 1.5 : 1)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Row(children: [
                    Expanded(child: Text(item.label, style: TextStyle(color: sel ? g.color : Colors.white, fontSize: 12, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis)),
                    if (item.isPopular) _badge('HOT', kRed),
                    if (item.isBonus) _badge('BONUS', kGreen),
                  ]),
                  const SizedBox(height: 4),
                  Text(AppData.formatPrice(item.price), style: TextStyle(color: sel ? g.color : Colors.white.withOpacity(0.5), fontSize: 13, fontWeight: FontWeight.bold)),
                ]),
              ));
            }, childCount: g.items.length),
          )),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ])),
      ]))),
      bottomNavigationBar: _sel == null ? null : Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
        decoration: BoxDecoration(color: kCard, border: Border(top: BorderSide(color: Colors.white.withOpacity(0.08)))),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _sumRow('Dipilih', _sel!.label),
          const SizedBox(height: 4),
          _sumRow('Total', AppData.formatPrice(_sel!.price), color: g.color),
          const SizedBox(height: 14),
          GlowBtn(label: 'BELI SEKARANG', color: g.color, icon: Icons.shopping_cart_rounded, onTap: () {
            if (_idCtrl.text.isEmpty) { showSnack(context, 'Masukkan ID game terlebih dahulu', kRed); return; }
            Navigator.pushNamed(context, '/order', arguments: {'game': g, 'item': _sel!});
          }),
        ]),
      ),
    );
  }

  Widget _badge(String t, Color c) => Container(margin: const EdgeInsets.only(left: 4), padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2), decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(4)), child: Text(t, style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)));

  Widget _sumRow(String l, String v, {Color? color}) => Row(children: [
    Text(l, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)),
    const Spacer(),
    Text(v, style: TextStyle(color: color ?? Colors.white, fontSize: color != null ? 15 : 13, fontWeight: color != null ? FontWeight.w900 : FontWeight.w600)),
  ]);
}

// ═══════════════════════════════════════════════
// ORDER / KONFIRMASI SCREEN
// ═══════════════════════════════════════════════
class OrderScreen extends StatefulWidget {
  final GameProduct game;
  final TopUpItem item;
  const OrderScreen({super.key, required this.game, required this.item});
  @override State<OrderScreen> createState() => _OrderScreenState();
}
class _OrderScreenState extends State<OrderScreen> {
  String _pay = 'Dana';
  bool _loading = false, _done = false;

  final _methods = const [
    {'name': 'Dana',        'icon': Icons.account_balance_wallet_rounded, 'color': kPrimary},
    {'name': 'OVO',         'icon': Icons.account_balance_wallet_rounded, 'color': kPurple},
    {'name': 'GoPay',       'icon': Icons.account_balance_wallet_rounded, 'color': kGreen},
    {'name': 'Transfer Bank','icon': Icons.account_balance_rounded,       'color': kGold},
  ];

  @override
  Widget build(BuildContext context) {
    if (_done) return _SuccessPage(game: widget.game, item: widget.item, pay: _pay);
    final g = widget.game;
    final it = widget.item;
    return Scaffold(
      body: AppBg(child: SafeArea(child: Column(children: [
        Padding(padding: const EdgeInsets.fromLTRB(24, 16, 24, 0), child: Row(children: [
          const BackBtn(), const SizedBox(width: 14),
          const Text('Konfirmasi Order', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ])),
        const SizedBox(height: 16),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.symmetric(horizontal: 24), physics: const BouncingScrollPhysics(), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Summary card
          Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: g.color.withOpacity(0.2))), child: Column(children: [
            Row(children: [
              Container(width: 46, height: 46, decoration: BoxDecoration(color: g.color.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                child: g.imageB64 != null
                  ? ClipRRect(borderRadius: BorderRadius.circular(12), child: GameImages.image(g.imageB64, size: 46))
                  : Icon(g.icon, color: g.color, size: 24)),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(g.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                Text(it.label, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
              ])),
              Text(AppData.formatPrice(it.price), style: TextStyle(color: g.color, fontWeight: FontWeight.w900, fontSize: 16)),
            ]),
            const SizedBox(height: 16),
            Divider(color: Colors.white.withOpacity(0.08)),
            const SizedBox(height: 12),
            _r('Nominal', it.label), const SizedBox(height: 8),
            _r('Harga', AppData.formatPrice(it.price)), const SizedBox(height: 8),
            _r('Biaya Admin', 'Gratis'), const SizedBox(height: 8),
            _r('Total', AppData.formatPrice(it.price), hi: true, c: g.color),
          ])),
          const SizedBox(height: 20),
          Text('Metode Pembayaran', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.7))),
          const SizedBox(height: 12),
          ..._methods.map((m) {
            final isSel = _pay == m['name'];
            final c = m['color'] as Color;
            return GestureDetector(onTap: () => setState(() => _pay = m['name'] as String), child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(color: isSel ? c.withOpacity(0.12) : kCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: isSel ? c : Colors.white.withOpacity(0.08), width: isSel ? 1.5 : 1)),
              child: Row(children: [
                Icon(m['icon'] as IconData, color: c, size: 22),
                const SizedBox(width: 12),
                Text(m['name'] as String, style: TextStyle(color: isSel ? c : Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                const Spacer(),
                if (isSel) Icon(Icons.check_circle_rounded, color: c, size: 20),
              ]),
            ));
          }),
          const SizedBox(height: 100),
        ]))),
      ]))),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
        decoration: BoxDecoration(color: kCard, border: Border(top: BorderSide(color: Colors.white.withOpacity(0.08)))),
        child: GlowBtn(label: 'BAYAR ${AppData.formatPrice(it.price)}', color: g.color, icon: Icons.payment_rounded, onTap: () async {
          setState(() => _loading = true);
          await Future.delayed(const Duration(seconds: 3));
          if (!mounted) return;
          setState(() { _loading = false; _done = true; });
        }, isLoading: _loading),
      ),
    );
  }

  Widget _r(String l, String v, {bool hi = false, Color? c}) => Row(children: [
    Text(l, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)), const Spacer(),
    Text(v, style: TextStyle(color: hi ? (c ?? kPrimary) : Colors.white, fontWeight: hi ? FontWeight.w900 : FontWeight.w600, fontSize: hi ? 15 : 13)),
  ]);
}

class _SuccessPage extends StatelessWidget {
  final GameProduct game; final TopUpItem item; final String pay;
  const _SuccessPage({required this.game, required this.item, required this.pay});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AppBg(child: SafeArea(child: Center(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 32), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, color: kGreen.withOpacity(0.15), border: Border.all(color: kGreen, width: 2)), child: const Icon(Icons.check_rounded, color: kGreen, size: 44)),
      const SizedBox(height: 24),
      const Text('Pembayaran Berhasil!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
      const SizedBox(height: 8),
      Text('Top up kamu sedang diproses', style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.5))),
      const SizedBox(height: 32),
      Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.08))), child: Column(children: [
        _s('Game', game.name), const SizedBox(height: 10),
        _s('Item', item.label), const SizedBox(height: 10),
        _s('Metode', pay), const SizedBox(height: 10),
        _s('Total', AppData.formatPrice(item.price), hi: true), const SizedBox(height: 10),
        _s('Status', '✅ Sukses', hi: true),
      ])),
      const SizedBox(height: 32),
      GlowBtn(label: 'KEMBALI KE BERANDA', color: kPrimary, onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (_) => false)),
      const SizedBox(height: 12),
      TextButton(onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/riwayat', (_) => false), child: const Text('Lihat Riwayat', style: TextStyle(color: Colors.white54))),
    ]))))));
  }
  Widget _s(String l, String v, {bool hi = false}) => Row(children: [
    Text(l, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)), const Spacer(),
    Text(v, style: TextStyle(color: hi ? kGreen : Colors.white, fontWeight: hi ? FontWeight.bold : FontWeight.w600, fontSize: 13)),
  ]);
}

// ═══════════════════════════════════════════════
// RIWAYAT SCREEN
// ═══════════════════════════════════════════════
class RiwayatScreen extends StatefulWidget {
  final bool embedded;
  const RiwayatScreen({super.key, this.embedded = false});
  @override State<RiwayatScreen> createState() => _RiwayatScreenState();
}
class _RiwayatScreenState extends State<RiwayatScreen> {
  String _f = 'Semua';
  List<Transaction> get _list => _f == 'Semua' ? AppData.transactions : AppData.transactions.where((t) => t.status == _f).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AppBg(child: SafeArea(child: Column(children: [
      Padding(padding: const EdgeInsets.fromLTRB(24, 16, 24, 0), child: Row(children: [
        if (!widget.embedded) ...[const BackBtn(), const SizedBox(width: 14)],
        const Text('Riwayat Transaksi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      ])),
      const SizedBox(height: 16),
      SizedBox(height: 36, child: ListView(padding: const EdgeInsets.symmetric(horizontal: 24), scrollDirection: Axis.horizontal, children: ['Semua', 'Sukses', 'Gagal'].map((f) {
        final s = _f == f;
        return GestureDetector(onTap: () => setState(() => _f = f), child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(color: s ? kPrimary : kCard, borderRadius: BorderRadius.circular(20), border: Border.all(color: s ? kPrimary : Colors.white12)),
          child: Text(f, style: TextStyle(color: s ? kBg : Colors.white70, fontSize: 13, fontWeight: FontWeight.w600)),
        ));
      }).toList())),
      const SizedBox(height: 16),
      Expanded(child: _list.isEmpty
        ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.receipt_long_outlined, color: Colors.white24, size: 60), const SizedBox(height: 12), Text('Tidak ada transaksi', style: TextStyle(color: Colors.white38, fontSize: 14))]))
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            physics: const BouncingScrollPhysics(),
            itemCount: _list.length,
            itemBuilder: (ctx, i) {
              final tx = _list[i];
              final ok = tx.status == 'Sukses';
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withOpacity(0.05))),
                child: Column(children: [
                  Row(children: [
                    Container(width: 42, height: 42, decoration: BoxDecoration(color: tx.color.withOpacity(0.12), borderRadius: BorderRadius.circular(12)), child: Icon(tx.icon, color: tx.color, size: 22)),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(tx.game, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(tx.item, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12)),
                    ])),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text(AppData.formatPrice(tx.price), style: const TextStyle(color: kPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(height: 2),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: (ok ? kGreen : kRed).withOpacity(0.15), borderRadius: BorderRadius.circular(6)), child: Text(tx.status, style: TextStyle(color: ok ? kGreen : kRed, fontSize: 11, fontWeight: FontWeight.bold))),
                    ]),
                  ]),
                  const SizedBox(height: 10),
                  Divider(color: Colors.white.withOpacity(0.06), height: 1),
                  const SizedBox(height: 8),
                  Row(children: [
                    const Icon(Icons.access_time_rounded, color: Colors.white30, size: 13), const SizedBox(width: 4),
                    Text(AppData.timeAgo(tx.date), style: TextStyle(color: Colors.white38, fontSize: 11)),
                    const Spacer(),
                    Text(tx.amount, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 11)),
                  ]),
                ]),
              );
            },
          )),
    ]))));
  }
}

// ═══════════════════════════════════════════════
// PROMO SCREEN
// ═══════════════════════════════════════════════
class PromoScreen extends StatelessWidget {
  const PromoScreen({super.key});
  static const _promos = [
    {'title': 'Cashback 20% ML Diamond', 'desc': 'Beli 86 diamond ke atas, cashback 20% untuk pengguna baru.', 'color': kPrimary, 'icon': Icons.gamepad_rounded, 'exp': '30 Apr 2025', 'badge': 'NEW'},
    {'title': 'Gratis Admin Free Fire',  'desc': 'Gratis biaya admin untuk semua top up Free Fire hari ini.',  'color': kGold,   'icon': Icons.whatshot_rounded, 'exp': '15 Apr 2025', 'badge': 'HOT'},
    {'title': 'Double Bonus PUBG UC',    'desc': 'Beli 325 UC atau lebih, bonus UC senilai 10%.',              'color': kPurple, 'icon': Icons.military_tech_rounded, 'exp': '20 Apr 2025', 'badge': ''},
    {'title': 'Diskon 15% Genshin',      'desc': 'Khusus member premium, diskon semua paket Genesis Crystal.', 'color': kGreen,  'icon': Icons.auto_awesome_rounded, 'exp': '25 Apr 2025', 'badge': 'VIP'},
    {'title': 'Flash Sale Valorant',     'desc': 'Harga spesial 1000 VP, hanya hari ini!',                     'color': kRed,    'icon': Icons.sports_esports_rounded, 'exp': '14 Apr 2025', 'badge': 'FLASH'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AppBg(child: SafeArea(child: Column(children: [
      Padding(padding: const EdgeInsets.fromLTRB(24, 16, 24, 0), child: Row(children: [
        const BackBtn(), const SizedBox(width: 14),
        const Text('Promo & Diskon', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      ])),
      const SizedBox(height: 16),
      Expanded(child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24), physics: const BouncingScrollPhysics(),
        itemCount: _promos.length,
        itemBuilder: (ctx, i) {
          final p = _promos[i];
          final c = p['color'] as Color;
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [c.withOpacity(0.2), kCard]), borderRadius: BorderRadius.circular(16), border: Border.all(color: c.withOpacity(0.3))),
            child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Icon(p['icon'] as IconData, color: c, size: 22), const SizedBox(width: 10),
                Expanded(child: Text(p['title'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15))),
                if ((p['badge'] as String).isNotEmpty) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(8)), child: Text(p['badge'] as String, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
              ]),
              const SizedBox(height: 10),
              Text(p['desc'] as String, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13)),
              const SizedBox(height: 12),
              Row(children: [
                const Icon(Icons.timer_outlined, color: Colors.white38, size: 14), const SizedBox(width: 4),
                Text('Berakhir: ${p['exp']}', style: const TextStyle(color: Colors.white38, fontSize: 12)),
                const Spacer(),
                GestureDetector(onTap: () => showSnack(ctx, 'Promo berhasil diklaim! 🎉', kGreen), child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6), decoration: BoxDecoration(color: c.withOpacity(0.2), borderRadius: BorderRadius.circular(8), border: Border.all(color: c.withOpacity(0.5))), child: Text('Klaim', style: TextStyle(color: c, fontSize: 12, fontWeight: FontWeight.bold)))),
              ]),
            ])),
          );
        },
      )),
    ]))));
  }
}

// ═══════════════════════════════════════════════
// SUPPORT SCREEN
// ═══════════════════════════════════════════════
class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});
  @override State<SupportScreen> createState() => _SupportScreenState();
}
class _SupportScreenState extends State<SupportScreen> {
  final _mc = TextEditingController();
  bool _sent = false;

  static const _faqs = [
    {'q': 'Berapa lama proses top up?', 'a': 'Diproses otomatis dalam 1–5 menit setelah pembayaran dikonfirmasi.'},
    {'q': 'Apakah ID game saya aman?', 'a': 'Kami hanya memerlukan User ID, bukan password.'},
    {'q': 'Bagaimana jika top up gagal?', 'a': 'Dana dikembalikan otomatis dalam 1x24 jam ke saldo akun kamu.'},
    {'q': 'Metode pembayaran apa saja?', 'a': 'Kami mendukung Dana, OVO, GoPay, dan Transfer Bank.'},
    {'q': 'Apakah ada biaya admin?', 'a': 'Tidak ada biaya admin! Semua harga sudah termasuk biaya layanan.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AppBg(child: SafeArea(child: Column(children: [
      Padding(padding: const EdgeInsets.fromLTRB(24, 16, 24, 0), child: Row(children: [
        const BackBtn(), const SizedBox(width: 14),
        const Text('Bantuan & Support', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      ])),
      const SizedBox(height: 16),
      Expanded(child: SingleChildScrollView(padding: const EdgeInsets.symmetric(horizontal: 24), physics: const BouncingScrollPhysics(), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: _cBtn(Icons.chat_rounded, 'WhatsApp', kGreen, () => showSnack(context, 'Membuka WhatsApp...', kGreen))),
          const SizedBox(width: 10),
          Expanded(child: _cBtn(Icons.alternate_email_rounded, 'Email', kPrimary, () => showSnack(context, 'Membuka Email...', kPrimary))),
          const SizedBox(width: 10),
          Expanded(child: _cBtn(Icons.send_rounded, 'Telegram', kPurple, () => showSnack(context, 'Membuka Telegram...', kPurple))),
        ]),
        const SizedBox(height: 24),
        Text('FAQ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.7))),
        const SizedBox(height: 12),
        ..._faqs.map((f) => _FaqTile(q: f['q']!, a: f['a']!)),
        const SizedBox(height: 24),
        Text('Kirim Pesan', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.7))),
        const SizedBox(height: 12),
        if (!_sent) Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white12)), child: Column(children: [
          TextField(controller: _mc, maxLines: 4, style: const TextStyle(color: Colors.white, fontSize: 14), decoration: InputDecoration(hintText: 'Ceritakan masalah kamu...', hintStyle: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 13), filled: true, fillColor: kInput, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: kGreen, width: 1.5)))),
          const SizedBox(height: 14),
          GlowBtn(label: 'KIRIM PESAN', color: kGreen, icon: Icons.send_rounded, onTap: () => setState(() => _sent = true)),
        ]))
        else Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: kGreen.withOpacity(0.3))), child: Row(children: [
          const Icon(Icons.check_circle_rounded, color: kGreen, size: 30), const SizedBox(width: 12),
          Expanded(child: Text('Pesan terkirim! Tim kami merespons dalam 1x24 jam.', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13))),
        ])),
        const SizedBox(height: 30),
      ]))),
    ]))));
  }

  Widget _cBtn(IconData icon, String label, Color color, VoidCallback onTap) => GestureDetector(onTap: onTap, child: Container(padding: const EdgeInsets.symmetric(vertical: 14), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.3))), child: Column(children: [
    Icon(icon, color: color, size: 24), const SizedBox(height: 6),
    Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
  ])));
}

class _FaqTile extends StatefulWidget {
  final String q, a;
  const _FaqTile({required this.q, required this.a});
  @override State<_FaqTile> createState() => _FaqTileState();
}
class _FaqTileState extends State<_FaqTile> {
  bool _open = false;
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: () => setState(() => _open = !_open), child: AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: _open ? kPrimary.withOpacity(0.08) : kCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: _open ? kPrimary.withOpacity(0.3) : Colors.white12)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(child: Text(widget.q, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600))),
        Icon(_open ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, color: Colors.white38, size: 20),
      ]),
      if (_open) ...[const SizedBox(height: 8), Text(widget.a, style: TextStyle(color: Colors.white.withOpacity(0.55), fontSize: 12, height: 1.5))],
    ]),
  ));
}

// ═══════════════════════════════════════════════
// PROFIL SCREEN
// ═══════════════════════════════════════════════
class ProfilScreen extends StatelessWidget {
  final bool embedded;
  const ProfilScreen({super.key, this.embedded = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AppBg(child: SafeArea(child: SingleChildScrollView(physics: const BouncingScrollPhysics(), child: Column(children: [
      if (!embedded) Padding(padding: const EdgeInsets.fromLTRB(24, 16, 24, 0), child: Row(children: [
        const BackBtn(), const SizedBox(width: 14),
        const Text('Profil', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      ])),
      const SizedBox(height: 24),
      Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, gradient: const LinearGradient(colors: [kPrimary, Color(0xFF0077B6)]), boxShadow: [BoxShadow(color: kPrimary.withOpacity(0.4), blurRadius: 20)]), child: const Icon(Icons.person_rounded, color: Colors.white, size: 44)),
      const SizedBox(height: 14),
      const Text('User', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 4),
      Text('user@email.com', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13)),
      const SizedBox(height: 6),
      Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4), decoration: BoxDecoration(color: kGold.withOpacity(0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: kGold.withOpacity(0.3))), child: const Text('Member Premium', style: TextStyle(color: kGold, fontSize: 12, fontWeight: FontWeight.bold))),
      const SizedBox(height: 28),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: Row(children: [
        _stat('Total Transaksi', '24'),
        _div(),
        _stat('Total Belanja', 'Rp 1,2 Jt'),
        _div(),
        _stat('Member Sejak', '2024'),
      ])),
      const SizedBox(height: 28),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: Column(children: [
        _mi(Icons.person_outline_rounded,       'Edit Profil',          kPrimary,  () => showSnack(context, 'Fitur edit profil segera hadir!', kPrimary)),
        _mi(Icons.account_balance_wallet_outlined,'Saldo & Pembayaran',  kGold,     () => showSnack(context, 'Saldo: Rp 250.000', kGold)),
        _mi(Icons.notifications_outlined,        'Notifikasi',           kGreen,    () => showSnack(context, 'Tidak ada notifikasi baru', kGreen)),
        _mi(Icons.security_rounded,              'Keamanan',             kPurple,   () => showSnack(context, 'Fitur keamanan segera hadir!', kPurple)),
        _mi(Icons.help_outline_rounded,          'Bantuan',              const Color(0xFFFF9100), () => Navigator.pushNamed(context, '/support')),
        _mi(Icons.logout_rounded,                'Keluar',               kRed,      () => Navigator.pushReplacementNamed(context, '/login')),
      ])),
      const SizedBox(height: 30),
      Text('Jay TopUp v1.00', style: TextStyle(color: Colors.white.withOpacity(0.2), fontSize: 12)),
      const SizedBox(height: 20),
    ])))));
  }

  Widget _stat(String label, String value) => Expanded(child: Column(children: [
    Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
    const SizedBox(height: 4),
    Text(label, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11), textAlign: TextAlign.center),
  ]));
  Widget _div() => Container(width: 1, height: 32, color: Colors.white12);
  Widget _mi(IconData icon, String label, Color color, VoidCallback onTap) => GestureDetector(onTap: onTap, child: Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
    decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withOpacity(0.05))),
    child: Row(children: [
      Container(width: 36, height: 36, decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 20)),
      const SizedBox(width: 14),
      Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
      const Spacer(),
      const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 14),
    ]),
  ));
}
