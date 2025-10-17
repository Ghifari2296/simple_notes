import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Note {
  final String title;
  final String description;
  Note(this.title, this.description);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Notes App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal, // 
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal.shade50,
          foregroundColor: Colors.teal.shade900,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.teal.shade900,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.teal, // 
          foregroundColor: Colors.white,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}


final List<Color> _pastelColors = [
  Colors.teal.shade50,
  Colors.green.shade50,
  Colors.lightGreen.shade50,
  Colors.cyan.shade50,
  Colors.lime.shade50.withOpacity(0.7),
  Colors.grey.shade100,
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Note> notes = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  void _addNote(String title, String description) {
    if (title.trim().isEmpty) return;
    setState(() {
      notes.insert(0, Note(title.trim(), description.trim()));
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Catatan berhasil ditambahkan! ✅'),
        backgroundColor: Colors.teal.shade700, // 
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _deleteNote(int index) {
    final deletedNote = notes[index];
    setState(() {
      notes.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('“${deletedNote.title}” dihapus'),
        backgroundColor: Colors.red.shade600, // tetap merah biar jelas
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              notes.insert(index, deletedNote);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '🌿 Simple Notes',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.teal.shade900,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              '${notes.length} catatan',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.teal.shade700,
              ),
            ),
          ),
        ),
      ),
      body: notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit_note_outlined,
                      size: 60,
                      color: Colors.teal.shade600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Belum ada catatan',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Tekan tombol + untuk menambah ide, tugas, atau hal penting lainnya.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                final color = _pastelColors[index % _pastelColors.length];
                return Dismissible(
                  key: Key('${note.title}-$index'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red.shade100,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.red),
                  ),
                  onDismissed: (_) => _deleteNote(index),
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    elevation: 2, // ✅ sedikit bayangan
                    color: color,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      title: Text(
                        note.title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.teal.shade900,
                        ),
                      ),
                      subtitle: note.description.isNotEmpty
                          ? Text(
                              note.description,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                              ),
                            )
                          : null,
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.teal),
                        onPressed: () => _deleteNote(index),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _titleController.clear();
          _descController.clear();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                title: Text(
                  'Tambah Catatan',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: Colors.teal.shade800,
                  ),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _titleController,
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: 'Judul',
                          labelStyle: GoogleFonts.poppins(color: Colors.teal.shade700),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.teal),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _descController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Deskripsi (opsional)',
                          labelStyle: GoogleFonts.poppins(color: Colors.teal.shade600),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.teal),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Batal', style: GoogleFonts.poppins(color: Colors.grey.shade700)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addNote(_titleController.text, _descController.text);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Text('Simpan', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500)),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}