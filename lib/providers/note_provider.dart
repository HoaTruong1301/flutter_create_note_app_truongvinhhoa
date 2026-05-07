import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/note.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> _notes = [];
  bool _isLoading = false;
  String? _error;

  List<Note> get notes => [..._notes];
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadNotes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _notes = await DatabaseHelper.instance.readAll();
    } catch (e) {
      _error = "Không thể tải ghi chú: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addNote(Note note) async {
    try {
      await DatabaseHelper.instance.create(note);
      await loadNotes();
    } catch (e) {
      _error = "Không thể thêm ghi chú: $e";
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      await DatabaseHelper.instance.update(note);
      await loadNotes();
    } catch (e) {
      _error = "Không thể cập nhật ghi chú: $e";
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      await DatabaseHelper.instance.delete(id);
      await loadNotes();
    } catch (e) {
      _error = "Không thể xóa ghi chú: $e";
      notifyListeners();
      rethrow;
    }
  }
}
