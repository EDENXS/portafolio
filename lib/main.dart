import 'package:flutter/material.dart';
import 'dart:ui';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portafolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'SF Pro Display',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _buildHeroSection(),
                _buildAboutSection(),
                _buildProjectsSection(),
                _buildExperienceSection(),
                _buildSkillsSection(),
                _buildContactSection(),
              ],
            ),
          ),
          _buildNavBar(),
        ],
      ),
    );
  }

  Widget _buildNavBar() {
    final isScrolled = _scrollOffset > 50;
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    if (isMobile) {
      return Container(
        height: 44,
        decoration: BoxDecoration(
          color: isScrolled ? Colors.white.withOpacity(0.8) : Colors.transparent,
          border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(isScrolled ? 0.2 : 0), width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _navItem('Inicio'),
            _navItem('Proyectos'),
            _navItem('Contacto'),
          ],
        ),
      );
    }
    
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: isScrolled ? Colors.white.withOpacity(0.8) : Colors.transparent,
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(isScrolled ? 0.2 : 0), width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _navItem('Inicio'),
          _navItem('Proyectos'),
          _navItem('Experiencia'),
          _navItem('Habilidades'),
          _navItem('Contacto'),
        ],
      ),
    );
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _navItem(String text) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 5 : 20),
      child: TextButton(
        onPressed: () {
          switch (text) {
            case 'Inicio':
              _scrollToSection(_heroKey);
              break;
            case 'Proyectos':
              _scrollToSection(_projectsKey);
              break;
            case 'Experiencia':
              _scrollToSection(_experienceKey);
              break;
            case 'Habilidades':
              _scrollToSection(_skillsKey);
              break;
            case 'Contacto':
              _scrollToSection(_contactKey);
              break;
          }
        },
        child: Text(
          text,
          style: TextStyle(
            color: _scrollOffset > 50 ? Colors.black : Colors.white,
            fontSize: isMobile ? 12 : 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    final parallax = _scrollOffset * 0.5;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    
    return Container(
      key: _heroKey,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade900, Colors.purple.shade900],
        ),
      ),
      child: Stack(
        children: [
          Transform.translate(
            offset: Offset(0, parallax),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Eduardo Enríquez',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 36 : 72,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -2,
                      ),
                    ),
                    SizedBox(height: isMobile ? 15 : 20),
                    Text(
                      'Desarrollador Móvil Senior',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: isMobile ? 20 : 32,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: isMobile ? 20 : 30),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Text(
                        'Desarrollador Full Stack con +4 años de experiencia liderando arquitecturas móviles escalables. Especializado en soluciones cloud con IA integrada.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: isMobile ? 16 : 20,
                          fontWeight: FontWeight.w300,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsSection() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final projects = [
      {'name': 'Mobo Inspect App', 'folder': 'app_mobo_inspect', 'images': ['app_mobo_inspect_1.jpeg', 'app_mobo_inspect_3.jpeg']},
      {'name': 'Mobo Inspect Web', 'folder': 'web_mobo_inspect', 'images': ['web_mobo_inspect.PNG', 'web_mobo_inspect_2.PNG']},
      {'name': 'Mobo Fácil', 'folder': 'mobo_facil', 'images': ['mobo_facil_app_1.jpeg', 'mobo_facil_app_2.jpeg']},
      {'name': 'Ikkilock', 'folder': 'ikkilock_app', 'images': ['ikki_lock_01.jpeg', 'ikki_lock_02.jpeg']},
      {'name': 'Brial', 'folder': 'brial', 'images': ['brial_01.png', 'brial_02.png']},
      {'name': 'La Torti', 'folder': 'la_torti', 'images': ['la_torti_1.jpeg', 'la_torti_2.jpeg']},
    ];

    return Container(
      key: _projectsKey,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60, vertical: isMobile ? 60 : 100),
      color: Colors.black,
      child: Column(
        children: [
          Text(
            'Algunas soluciones implementadas',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 32 : 56,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.5,
            ),
          ),
          SizedBox(height: isMobile ? 40 : 80),
          ...projects.map((project) => _projectCard(
            project['name'] as String,
            project['folder'] as String,
            project['images'] as List<String>,
          )),
        ],
      ),
    );
  }

  void _showImageDialog(String folder, List<String> images, int initialIndex) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => _ImageDialogContent(folder: folder, images: images, initialIndex: initialIndex),
    );
  }

  Widget _projectCard(String name, String folder, List<String> images) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Container(
      margin: EdgeInsets.only(bottom: isMobile ? 40 : 80),
      child: Column(
        children: [
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 24 : 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: isMobile ? 20 : 40),
          isMobile
              ? Column(
                  children: images.asMap().entries.map((entry) => GestureDetector(
                    onTap: () => _showImageDialog(folder, images, entry.key),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 40,
                            offset: const Offset(0, 20),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'lib/assets/$folder/${entry.value}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )).toList(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: images.asMap().entries.map((entry) => GestureDetector(
                    onTap: () => _showImageDialog(folder, images, entry.key),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      width: 400,
                      height: 700,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 40,
                            offset: const Offset(0, 20),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'lib/assets/$folder/${entry.value}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )).toList(),
                ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60, vertical: isMobile ? 60 : 120),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              Text(
                'Soluciones inteligentes que optimizan procesos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 28 : 48,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.5,
                  height: 1.2,
                ),
              ),
              SizedBox(height: isMobile ? 20 : 30),
              Text(
                'Desarrollador Full Stack con +4 años de experiencia liderando arquitecturas móviles escalables. Especializado en Flutter, React Native y soluciones cloud con IA integrada.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 22,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w300,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceSection() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      key: _experienceKey,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60, vertical: isMobile ? 60 : 100),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          Text(
            'Experiencia',
            style: TextStyle(
              fontSize: isMobile ? 36 : 56,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.5,
            ),
          ),
          SizedBox(height: isMobile ? 40 : 80),
          _experienceCard(
            'Desarrollador Móvil Sr',
            'MOBO',
            '2023 - 2026',
            'Lideré arquitectura Flutter escalable y desarrollo de Mobo Inspect y Mobo Fácil. Implementé backend SQL/NoSQL con banca offline descentralizada. Diseñé CMS web con gestión de roles y dashboards dinámicos.',
          ),
          const SizedBox(height: 40),
          _experienceCard(
            'Desarrollador de Apps',
            'Industrias del Maíz',
            '2022 - 2023',
            'Sistema de asistencia con QR y geolocalización. Evaluaciones y encuestas. Registro de productos por QR.',
          ),
          const SizedBox(height: 40),
          _experienceCard(
            'Programador de Apps',
            'IKKILOCK',
            '2022 - 2023',
            'WebSockets para comunicación en tiempo real. Chat de voz, texto e imagen. Sistema de notificaciones e intercomunicador.',
          ),
          const SizedBox(height: 40),
          _experienceCard(
            'Programador',
            'BRIAL',
            '2021 - 2022',
            'App en AppStore y PlayStore. Videollamadas grupales con Agora. Pasarela de pagos con Stripe. Sistema de agendas y citas.',
          ),
        ],
      ),
    );
  }

  Widget _experienceCard(String role, String company, String period, String description) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      constraints: const BoxConstraints(maxWidth: 900),
      padding: EdgeInsets.all(isMobile ? 20 : 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            role,
            style: TextStyle(
              fontSize: isMobile ? 20 : 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$company • $period',
            style: TextStyle(
              fontSize: isMobile ? 14 : 18,
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: Colors.grey.shade700,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      key: _skillsKey,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60, vertical: isMobile ? 60 : 100),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Tecnologías',
            style: TextStyle(
              fontSize: isMobile ? 36 : 56,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.5,
            ),
          ),
          SizedBox(height: isMobile ? 40 : 80),
          _skillCategory('Móvil', [
            _skillCard(Icons.phone_android, 'Flutter & Dart'),
            _skillCard(Icons.code, 'React Native'),
            _skillCard(Icons.apple, 'Swift'),
            _skillCard(Icons.android, 'Kotlin'),
          ]),
          const SizedBox(height: 60),
          _skillCategory('Web & Backend', [
            _skillCard(Icons.web, 'React'),
            _skillCard(Icons.javascript, 'JavaScript'),
            _skillCard(Icons.code_outlined, 'TypeScript'),
            _skillCard(Icons.storage, 'Node.js'),
            _skillCard(Icons.api, 'PHP'),
            _skillCard(Icons.terminal, 'Python'),
          ]),
          const SizedBox(height: 60),
          _skillCategory('Cloud & DevOps', [
            _skillCard(Icons.cloud, 'AWS'),
            _skillCard(Icons.cloud_upload, 'S3 & Lambda'),
            _skillCard(Icons.cloud_queue, 'Google Cloud'),
            _skillCard(Icons.monitor_heart, 'CloudWatch'),
            _skillCard(Icons.dns, 'Firebase & SQL'),
            _skillCard(Icons.computer, 'Linux Servers'),
            _skillCard(Icons.precision_manufacturing, 'Jenkins'),
            _skillCard(Icons.sync, 'CI/CD GitHub Actions'),
            _skillCard(Icons.view_in_ar, 'Docker'),
            _skillCard(Icons.hub_outlined, 'Kubernetes'),
            _skillCard(Icons.speed, 'Redis'),
            _skillCard(Icons.storage_outlined, 'PostgreSQL'),
          ]),
          const SizedBox(height: 60),
          _skillCategory('IA & Automatización', [
            _skillCard(Icons.hub, 'n8n'),
            _skillCard(Icons.psychology, 'IA & Automatización'),
            _skillCard(Icons.chat, 'Claude & Gemini'),
            _skillCard(Icons.edit_note, 'Prompt Engineering'),
          ]),
          const SizedBox(height: 60),
          _skillCategory('Diseño UI/UX', [
            _skillCard(Icons.design_services, 'Figma'),
            _skillCard(Icons.brush, 'Sketch'),
            _skillCard(Icons.grid_on, 'Stitch'),
            _skillCard(Icons.straighten, 'Pixel Perfect'),
          ]),
        ],
      ),
    );
  }

  Widget _skillCategory(String title, List<Widget> skills) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isMobile ? 22 : 28,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: isMobile ? 30 : 40),
        Wrap(
          spacing: isMobile ? 15 : 30,
          runSpacing: isMobile ? 15 : 30,
          alignment: WrapAlignment.center,
          children: skills,
        ),
      ],
    );
  }

  Widget _skillCard(IconData icon, String title) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      width: isMobile ? 150 : 200,
      height: isMobile ? 150 : 200,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: isMobile ? 40 : 56, color: Colors.blue.shade700),
          SizedBox(height: isMobile ? 15 : 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 14 : 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      key: _contactKey,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60, vertical: isMobile ? 60 : 120),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade900, Colors.purple.shade900],
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              'Trabajemos juntos',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 32 : 56,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.5,
              ),
            ),
            SizedBox(height: isMobile ? 40 : 60),
            _contactItem(Icons.email, 'eduardoenriquez970@gmail.com'),
            const SizedBox(height: 20),
            _contactItem(Icons.phone, '+52 56 4739 8101'),
            const SizedBox(height: 20),
            _contactItem(Icons.location_on, 'Ciudad de México, México'),
            SizedBox(height: isMobile ? 40 : 80),
            Text(
              '© 2026 Eduardo Enríquez García',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactItem(IconData icon, String text) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.9), size: isMobile ? 20 : 24),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: isMobile ? 14 : 20,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _ImageDialogContent extends StatefulWidget {
  final String folder;
  final List<String> images;
  final int initialIndex;

  const _ImageDialogContent({
    required this.folder,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_ImageDialogContent> createState() => _ImageDialogContentState();
}

class _ImageDialogContentState extends State<_ImageDialogContent> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                      maxHeight: MediaQuery.of(context).size.height * 0.9,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'lib/assets/${widget.folder}/${widget.images[currentIndex]}',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 32),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              if (widget.images.length > 1) ...[
                Positioned(
                  left: 20,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 32),
                      onPressed: currentIndex > 0 ? () => setState(() => currentIndex--) : null,
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 32),
                      onPressed: currentIndex < widget.images.length - 1 ? () => setState(() => currentIndex++) : null,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${currentIndex + 1} de ${widget.images.length}',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
