import 'package:flutter/material.dart';
import 'package:praktikum/new_form.dart';

class PortfolioItem {
  const PortfolioItem({
    required this.title,
    required this.description,
    required this.tech,
    required this.icon,
  });

  final String title;
  final String description;
  final String tech;
  final IconData icon;
}

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPage();
}

class _ProfilPage extends State<ProfilPage> {
  static const Color _primary = Color(0xFF5AA9FF);
  static const Color _primaryDark = Color(0xFF2D7FE8);
  static const Color _surface = Color(0xFFF8FBFF);
  static const Color _textPrimary = Color(0xFF17324D);
  static const Color _textMuted = Color(0xFF6B86A5);

  final String _name = 'Naufal Arya Maulana';
  final String _role = 'Mahasiswa Teknik Informatika';
  final String _address = 'Jakarta, Indonesia';
  final String _major = 'Teknik Informatika 2023';
  final String _avatarAsset = 'assets/Foto Profil Naufal Arya.jpeg';

  final List<String> _skills = const [
    'C for IoT',
    'NextJS',
    'TailwindCSS',
    'Python',
    'Figma',
  ];

  final List<PortfolioItem> _portfolioItems = const [
    PortfolioItem(
      title: 'ZeroSampah',
      description:
          'Community-based waste management system integrated with Gemini AI to help communities sort, monitor, and improve waste handling.',
      tech: 'NextJS, TailwindCSS, Typescript, Clerk, Supabase',
      icon: Icons.recycling_outlined,
    ),
    PortfolioItem(
      title: 'IoT For Flood Warning System',
      description:
          'A canal level monitoring system that detects rising water levels and sends messages to users before flooding happens.',
      tech: 'Arduino IDE, Grafana, InfluxDB, HiveMQTT',
      icon: Icons.water_outlined,
    ),
    PortfolioItem(
      title: 'Infinite Running Game',
      description:
          'A Subway Surfers inspired Unity game set in a city destroyed by dragons where players collect points and avoid obstacles.',
      tech: 'Unity, C language',
      icon: Icons.videogame_asset_outlined,
    ),
  ];

  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: _surface,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewForm(
                title: _portfolioItems.first.title,
                description: _portfolioItems.first.description,
                tech: _portfolioItems.first.tech,
                icon: _portfolioItems.first.icon,
              ),
            ),
          );
        },
        backgroundColor: _primaryDark,
        icon: const Icon(Icons.open_in_new, color: Colors.white),
        label: const Text(
          'Detail',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                _buildHeader(screenHeight, screenWidth),
                const SizedBox(height: 60),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _activePage == 0
                      ? _aboutPage()
                      : (_activePage == 1 ? _portoPage() : _contactPage()),
                ),
                const SizedBox(height: 80),
              ],
            ),
            Positioned(
              top: screenHeight * 0.29,
              left: 16,
              right: 16,
              child: _buildTabBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.33,
      width: screenWidth,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_primary, _primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 52,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage(_avatarAsset),
          ),
          const SizedBox(height: 12),
          Text(
            _name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _role,
              style: const TextStyle(fontSize: 13, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: _tabButton('About Me', 0, Icons.person_outline)),
          Expanded(child: _tabButton('Porto', 1, Icons.work_outline)),
          Expanded(child: _tabButton('Contact', 2, Icons.mail_outline)),
        ],
      ),
    );
  }

  Widget _tabButton(String label, int index, IconData icon) {
    final bool isActive = _activePage == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _activePage = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? _primaryDark : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? Colors.white : Colors.grey,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _aboutPage() {
    return Container(
      key: const ValueKey('about'),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Tentang Saya'),
          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _infoRow(Icons.person, 'Nama', _name),
                  const Divider(height: 20),
                  _infoRow(Icons.location_on, 'Alamat', _address),
                  const Divider(height: 20),
                  _infoRow(Icons.school, 'Jurusan', _major),
                  const Divider(height: 20),
                  _infoRow(Icons.badge_outlined, 'Role', _role),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _sectionTitle('Fakta Singkat'),
          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  _CompactFact(label: 'NIM', value: '123103124'),
                  SizedBox(height: 12),
                  _CompactFact(label: 'Hobby', value: 'Swimming'),
                  SizedBox(height: 12),
                  _CompactFact(label: 'Hometown', value: 'Jakarta Timur'),
                  SizedBox(height: 12),
                  _CompactFact(label: 'Others', value: 'Math enthusiast'),
                  SizedBox(height: 12),
                  _CompactFact(label: 'Others', value: 'Like to VibeCode'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _sectionTitle('Keahlian'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _skills.map(_skillChip).toList(),
          ),
        ],
      ),
    );
  }

  Widget _portoPage() {
    return Container(
      key: const ValueKey('porto'),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Portfolio'),
          ..._portfolioItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == _portfolioItems.length - 1 ? 0 : 12,
              ),
              child: _portoCard(item),
            );
          }),
        ],
      ),
    );
  }

  Widget _contactPage() {
    return Container(
      key: const ValueKey('contact'),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Hubungi Saya'),
          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _infoRow(Icons.email, 'Email', 'naufal.maulana@students.paramadina.ac.id'),
                  const Divider(height: 20),
                  _infoRow(Icons.phone, 'Phone', '081292091767'),
                  const Divider(height: 20),
                  _infoRow(Icons.code, 'GitHub', 'github.com/aarz24'),
                  const Divider(height: 20),
                  _infoRow(Icons.link, 'LinkedIn', 'linkedin.com/in/naufal-arya-maulana-4a2a31354'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: _textPrimary,
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF4FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: _primaryDark),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: _textMuted),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _skillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF4FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFBBD8FF)),
      ),
      child: Text(
        skill,
        style: const TextStyle(
          fontSize: 13,
          color: _primaryDark,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _portoCard(PortfolioItem item) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewForm(
                title: item.title,
                description: item.description,
                tech: item.tech,
                icon: item.icon,
              ),
            ),
          );
        },
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF4FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: _primaryDark),
          ),
          title: Text(
            item.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          subtitle: Text(
            item.tech,
            style: const TextStyle(fontSize: 12, color: _textMuted),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ),
      ),
    );
  }
}

class _CompactFact extends StatelessWidget {
  const _CompactFact({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 86,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: _ProfilPage._textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: _ProfilPage._textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
