# Simple Note App - Trương Vĩnh Hòa
Ứng dụng ghi chú hiện đại và tối giản được xây dựng bằng Flutter, giúp bạn dễ dàng lưu lại những ý tưởng, công việc cần làm và quản lý chúng một cách khoa học ngay trên thiết bị di động.

## ✨ Tính năng chính
*   **Quản lý ghi chú toàn diện:** Thêm, sửa, và xóa ghi chú với giao diện trực quan, mượt mà.
*   **Lưu trữ cục bộ an toàn:** Sử dụng SQLite (`sqflite`) để lưu trữ dữ liệu bền vững, đảm bảo dữ liệu không bị mất.
*   **Tìm kiếm thông minh:** Tìm nhanh ghi chú theo tiêu đề hoặc nội dung ngay trên thanh công cụ.
*   **Sắp xếp linh hoạt:** Hỗ trợ sắp xếp danh sách ghi chú theo thời gian cập nhật mới nhất hoặc theo tiêu đề A-Z.
*   **Cá nhân hóa màu sắc:** 
    *   Lựa chọn 8 màu sắc chủ đề sinh động cho mỗi ghi chú.
    *   **Giao diện thích ứng:** Màu chữ tự động chuyển đổi giữa Đen/Trắng dựa trên độ sáng của nền để đảm bảo trải nghiệm đọc tốt nhất.
*   **Chế độ Giao diện:** Hỗ trợ đầy đủ Light Mode (Sáng) và Dark Mode (Tối) giúp bảo vệ mắt và tiết kiệm pin.
*   **UX tối ưu:** 
    *   Nhấn giữ để mở menu tùy chọn nhanh (Edit/Delete).
    *   Hộp thoại xác nhận an toàn khi xóa hoặc hủy bỏ các thay đổi chưa lưu.

## 🛠 Công nghệ sử dụng
*   **Framework:** Flutter & Dart
*   **Quản lý trạng thái (State Management):** Provider
*   **Cơ sở dữ liệu:** sqflite (SQLite)
*   **Định dạng thời gian:** intl
*   **Lưu trữ tệp:** path_provider

## 🚀 Hướng dẫn cài đặt và chạy ứng dụng
### 1. Chuẩn bị
*   Đảm bảo bạn đã cài đặt Flutter SDK trên máy tính.
*   Thiết bị Android/iOS hoặc Máy ảo đã sẵn sàng.

### 2. Chạy ứng dụng
1.  **Lấy các gói phụ thuộc:**
    ```bash
    flutter pub get
    ```
2.  **Chạy ứng dụng:**
    ```bash
    flutter run
    ```


## 📸 Ảnh chụp màn hình (Screenshots)

| Chế độ Sáng | Chế độ Tối | Tìm kiếm | Soạn thảo |
| :---: | :---: | :---: | :---: |
| ![Light Mode](screenshots/home_light.png) | ![Dark Mode](screenshots/home_dark.png) | ![Search](screenshots/search.png) | ![Editor](screenshots/add_note.png) |

| Tùy chọn nhanh | Xác nhận xóa | Cảnh báo thoát |
| :---: | :---: | :---: |
| ![Options](screenshots/note_options.png) | ![Delete](screenshots/delete_dialog.png) | ![Discard](screenshots/discard_dialog.png) |

---
Được xây dựng với ❤️ nhằm mang lại sự tiện lợi trong việc quản lý ghi chú hằng ngày.
