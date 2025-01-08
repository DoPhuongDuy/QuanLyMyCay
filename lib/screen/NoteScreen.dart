import 'package:damh4/screen/Custom/CustomAppBar.dart';
import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  final String initialNote;
  final ValueChanged<String> onNoteSaved;

  const NoteScreen({
    Key? key,
    required this.initialNote,
    required this.onNoteSaved,
  }) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialNote);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Thêm Ghi Chú'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Nhập ghi chú...',
              ),
              maxLines: null,
              onChanged: (value) {
                // Khi người dùng thay đổi ghi chú, bạn có thể làm gì đó
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Quay lại màn hình trước mà không lưu ghi chú
                  },
                  child: Text(
                    'Hủy',
                    style: TextStyle(
                      color: Colors.white, // Đổi màu chữ thành trắng
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey, // Màu nền của nút Hủy
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onNoteSaved(_controller.text); // Lưu ghi chú
                    Navigator.pop(context); // Quay lại màn hình trước
                  },
                  child: Text(
                    'Lưu ghi chú',
                    style: TextStyle(
                      color: Colors.white, // Đổi màu chữ thành trắng
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDF3E12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
