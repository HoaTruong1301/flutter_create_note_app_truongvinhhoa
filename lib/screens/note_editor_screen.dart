import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;
  const NoteEditorScreen({super.key, this.note});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _content;
  late int _selectedColor;
  bool _isChanged = false;

  final List<int> _colors = [
    0xFFFFFFFF, // White
    0xFFFFAB91, // Deep Orange
    0xFFFFCC80, // Orange
    0xFFE6EE9C, // Lime
    0xFF80CBC4, // Teal
    0xFF90CAF9, // Blue
    0xFFB39DDB, // Deep Purple
    0xFFF48FB1, // Pink
  ];

  @override
  void initState() {
    super.initState();
    _title = widget.note?.title ?? '';
    _content = widget.note?.content ?? '';
    _selectedColor = widget.note?.color ?? _colors[0];
  }

  Future<void> _saveNote() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final now = DateTime.now();

      try {
        if (widget.note == null) {
          final newNote = Note(
            title: _title,
            content: _content,
            createdAt: now,
            updatedAt: now,
            color: _selectedColor,
          );
          await Provider.of<NoteProvider>(context, listen: false).addNote(newNote);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đã lưu ghi chú')),
            );
          }
        } else {
          final updatedNote = widget.note!.copyWith(
            title: _title,
            content: _content,
            updatedAt: now,
            color: _selectedColor,
          );
          await Provider.of<NoteProvider>(context, listen: false).updateNote(updatedNote);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đã cập nhật ghi chú')),
            );
          }
        }
        if (mounted) Navigator.of(context).pop();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi khi lưu: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  Future<bool> _onWillPop() async {
    if (!_isChanged) return true;

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hủy bỏ thay đổi?'),
        content: const Text('Bạn có những thay đổi chưa lưu. Bạn có thực sự muốn hủy bỏ chúng không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Bỏ qua', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = Color(_selectedColor);
    final bool isDark = ThemeData.estimateBrightnessForColor(bgColor) == Brightness.dark;
    final Color contentColor = isDark ? Colors.white : Colors.black87;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: contentColor),
          title: Text(
            widget.note == null ? 'Thêm ghi chú' : 'Sửa ghi chú',
            style: TextStyle(color: contentColor),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.save, color: contentColor),
              onPressed: _saveNote,
            ),
          ],
        ),
        body: Column(
          children: [
            // Color Picker Row
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _colors.length,
                itemBuilder: (ctx, i) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = _colors[i];
                        _isChanged = true;
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(_colors[i]),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _selectedColor == _colors[i] 
                              ? (isDark ? Colors.white : Colors.black) 
                              : Colors.grey.withOpacity(0.5),
                          width: _selectedColor == _colors[i] ? 3 : 1,
                        ),
                      ),
                      child: _selectedColor == _colors[i] 
                          ? Icon(Icons.check, 
                              size: 20, 
                              color: ThemeData.estimateBrightnessForColor(Color(_colors[i])) == Brightness.dark 
                                  ? Colors.white 
                                  : Colors.black) 
                          : null,
                    ),
                  );
                },
              ),
            ),
            Divider(color: contentColor.withOpacity(0.2)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  onChanged: () => _isChanged = true,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _title,
                        style: TextStyle(
                          fontSize: 22, 
                          fontWeight: FontWeight.bold,
                          color: contentColor,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Tiêu đề',
                          hintStyle: TextStyle(color: contentColor.withOpacity(0.5)),
                          border: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Tiêu đề không được để trống';
                          return null;
                        },
                        onSaved: (v) => _title = v!.trim(),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: TextFormField(
                          initialValue: _content,
                          style: TextStyle(fontSize: 18, color: contentColor),
                          decoration: InputDecoration(
                            hintText: 'Bắt đầu nhập...',
                            hintStyle: TextStyle(color: contentColor.withOpacity(0.5)),
                            border: InputBorder.none,
                          ),
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Nội dung không được để trống';
                            return null;
                          },
                          onSaved: (v) => _content = v!.trim(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
